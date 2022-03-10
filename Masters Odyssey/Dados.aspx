<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dados.aspx.cs" Inherits="Masters_Odyssey.Dados" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
      <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
      <link rel="stylesheet" type="text/css" href="css/estilos.css"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title> Master's Odyssey - Dados </title>
</head>
<body class="indigo lighten-5">
    <%@ Import Namespace="Masters_Odyssey.Clases" %>
    <%
        if (Session["nom_usu"] == null || Session["cor_usu"] == null)
        {
            Response.Write("<script>alert('Debe iniciar sesión para ingresar a esta página.');</script>");
            Response.Write("<script>location.href='Login.aspx';</script>");
        }
    %>
    <header style="text-align: right; margin-right: 10px">
        Hola, <%Response.Write(Session["nom_usu"]);%>! || 
        <a href="Cerrar.aspx"> Cerrar sesión</a>
      </header>
      <h2 style="text-align:center">Master's Odyssey</h2>
    	<nav class="indigo darken-4">
		    <div class="nav-wrapper">
		        <ul class="center hide-on-med-and-down">
		        <li class="indigo darken-3" style="width: 25%"><a href="Campanias.aspx">Campañas</a></li>
		        <li class="indigo darken-3" style="width: 25%"><a href="Partidas.aspx">Partidas</a></li>
                <li class="indigo darken-3" style="width: 25%"><a href="Cementerio.aspx">Cementerio</a></li>
                <li class="indigo darken-3" style="width: 25%"><a href="Dados.aspx">Lanzar dados</a></li>
		      </ul>
		    </div>
	  	</nav>
        <div class="container" style="align-content:center" id="div_per">
            <h5> Lazar Dados </h5>
        </div>
        <br/>
    <form id="form1" runat="server" method="post" action="Dados.aspx">
        <div class="container" style="text-align:center">
            <div class="row">
                <div class="col s2" style="text-align:center"> D4 </div>
                <div class="col s2" style="text-align:center"> D6 </div>
                <div class="col s2" style="text-align:center"> D8</div>
                <div class="col s2" style="text-align:center"> D10 </div>
                <div class="col s2" style="text-align:center"> D20</div>
                <div class="col s2" style="text-align:center"> D100</div>
            </div>
            <div class="row">
                <div class="col s2">
                    <img src="img/d4.png" alt="d4" style="height:40px" />
                </div>
                <div class="col s2">
                    <img src="img/d6.png" alt="d6" style="height:40px" />
                </div>
                <div class="col s2">
                    <img src="img/d8.png" alt="d8" style="height:40px" />
                </div>
                <div class="col s2">
                    <img src="img/d10.png" alt="d10" style="height:40px" />
                </div>
                <div class="col s2">
                    <img src="img/d20.png" alt="d20" style="height:40px" />
                </div>
                <div class="col s2">
                    <img src="img/d100.png" alt="d100" style="height:40px" />
                </div>
            </div>
            <div class="row">
                <div class="col s2">
                    <input type="number" name="txt_d4" id="txt_d4" max="10" min="0" value="0" style="text-align:center"/>
                </div>
                <div class="col s2">
                    <input type="number" name="txt_d6" id="txt_d6" max="10" min="0" value="0" style="text-align:center"/>
                </div>
                <div class="col s2">
                    <input type="number" name="txt_d8" id="txt_d8" max="10" min="0" value="0" style="text-align:center"/>
                </div>
                <div class="col s2">
                    <input type="number" name="txt_d10" id="txt_d10" max="10" min="0" value="0" style="text-align:center"/>
                </div>
                <div class="col s2">
                    <input type="number" name="txt_d20" id="txt_d20" max="10" min="0" value="0" style="text-align:center"/>
                </div>
                <div class="col s2">
                    <input type="number" name="txt_d100" id="txt_d100" max="10" min="0" value="0" style="text-align:center"/>
                </div>
            </div>
            <div>
                <input type="submit" name="btncal" value="Tirar Dados" />
            </div>
         </div>
    </form>
    <%
        Random dado = new Random();
        int total = 0, dadotemp;
        string resultado = "";

        if (!string.IsNullOrEmpty(Request.Form["btncal"]))
        {
            int d4 = int.Parse(Request.Form["txt_d4"]);
            int d6 = int.Parse(Request.Form["txt_d6"]);
            int d8 = int.Parse(Request.Form["txt_d8"]);
            int d10 = int.Parse(Request.Form["txt_d10"]);
            int d20 = int.Parse(Request.Form["txt_d20"]);
            int d100 = int.Parse(Request.Form["txt_d100"]);

            if (int.Parse(Request.Form["txt_d4"]) > 0)
            {
                resultado = resultado + "D4: ";
                for (int i = 0; i < int.Parse(Request.Form["txt_d4"]); i++)
                {
                    dadotemp = dado.Next(1, 5);
                    resultado = resultado + dadotemp + "+";
                    total = total + dadotemp;
                    if (i == (d4-1))
                    {
                        resultado = resultado + "</br>";
                    }
                }
            }

            if (int.Parse(Request.Form["txt_d6"]) > 0)
            {
                resultado = resultado + "D6: ";
                for (int i = 0; i < int.Parse(Request.Form["txt_d6"]); i++)
                {
                    dadotemp = dado.Next(1, 7);
                    resultado = resultado + dadotemp + "+";
                    total = total + dadotemp;
                    if (i == (d6-1))
                    {
                        resultado = resultado + "</br>";
                    }
                }
            }

            if (int.Parse(Request.Form["txt_d8"]) > 0)
            {
                resultado = resultado + "D8: ";
                for (int i = 0; i < int.Parse(Request.Form["txt_d8"]); i++)
                {
                    dadotemp = dado.Next(1, 9);
                    resultado = resultado + dadotemp + "+";
                    total = total + dadotemp;
                    if (i == (d8-1))
                    {
                        resultado = resultado + "</br>";
                    }
                }
            }

            if (int.Parse(Request.Form["txt_d10"]) > 0)
            {
                resultado = resultado + "D10: ";
                for (int i = 0; i < int.Parse(Request.Form["txt_d10"]); i++)
                {
                    dadotemp = dado.Next(1, 11);
                    resultado = resultado + dadotemp + "+";
                    total = total + dadotemp;
                    if (i == (d10-1))
                    {
                        resultado = resultado + "</br>";
                    }
                }
            }

            if (int.Parse(Request.Form["txt_d20"]) > 0)
            {
                resultado = resultado + "D20: ";
                for (int i = 0; i < int.Parse(Request.Form["txt_d20"]); i++)
                {
                    dadotemp = dado.Next(1, 21);
                    resultado = resultado + dadotemp + "+";
                    total = total + dadotemp;
                    if (i == (d20-1))
                    {
                        resultado = resultado + "</br>";
                    }
                }
            }

            if (int.Parse(Request.Form["txt_d100"]) > 0)
            {
                resultado = resultado + "D100: ";
                for (int i = 0; i < int.Parse(Request.Form["txt_d100"]); i++)
                {
                    dadotemp = dado.Next(1, 101);
                    resultado = resultado + dadotemp + "+";
                    total = total + dadotemp;
                }
            }
            if (resultado.Length > 0)
            {
                resultado = resultado.Remove(resultado.Length - 1);
                resultado = resultado + "</br> = " + total;
                Response.Write("<div class='container' style='text-align:center; flex-wrap:wrap'>");
                Response.Write("<h4>"+resultado+"</h4>");
                Response.Write("</div>");

                Response.Write("<script>document.getElementById('txt_d4').value ='" + d4 + "';</script>");
                Response.Write("<script>document.getElementById('txt_d6').value ='" + d6 + "';</script>");
                Response.Write("<script>document.getElementById('txt_d8').value ='" + d8 + "';</script>");
                Response.Write("<script>document.getElementById('txt_d10').value ='" + d10 + "';</script>");
                Response.Write("<script>document.getElementById('txt_d20').value ='" + d20 + "';</script>");
                Response.Write("<script>document.getElementById('txt_d100').value ='" + d100 + "';</script>");
            }

        }
    %>
    
    <div class="container" style="text-align: right">
        <form action="Dados.aspx">
            <button type="submit">Limpiar</button>
        </form>
    </div>
    

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
      <script type="text/javascript" src="js/materialize.min.js"></script>
      <script type="text/javascript">
         $(document).ready(function() {
          $('select').material_select();
        });
      </script>
</body>
</html>
