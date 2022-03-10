<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Campanias.aspx.cs" Inherits="Masters_Odyssey.Campanias" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
      <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
      <link rel="stylesheet" type="text/css" href="css/estilos.css"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
      <title>Master's Odyssey - Reglas</title>
</head>
<body class="indigo lighten-5">
    <%@ Import Namespace= "Masters_Odyssey.Clases" %>
    <%
        
        if (Session["nom_usu"] == null || Session["cor_usu"] == null)
        {
            Response.Write("<script>alert('Debe iniciar sesión para ingresar a esta página.');</script>");
            Response.Write("<script>location.href='Login.aspx';</script>");
        }

    %>
     <header style="text-align: right; margin-right: 10px">
        Hola <%Response.Write(Session["nom_usu"]);%>! || 
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
      <div style="text-align:center">
        <h5>Recordatorio de reglas</h5>
          <h6>Campaña: <%Response.Write(Session["nom_cam"]);%></h6>
        <br/>
          <form id="form_cam" runat="server" method="post" action="Reglas.aspx">
          <div class="container">        
            <table>
              <tr>
                <td>
                    <textarea id="textarea1" class="materialize-textarea" maxlength="2000" name="txt_reg" style="height: 450px"></textarea>
                </td>                  
              </tr>
              <tr>
                  <td><input type="submit" name="btngua" value="Guardar" /></td>
              </tr>
            </table>
        </div>
        </form>
        <script>
            <%
                string ids = Session["id_cam"].ToString(), nom = "", usu = "", error = "";
                int id = int.Parse(ids);

                nom = Session["nom_cam"].ToString();
                usu = Session["nom_usu"].ToString();
                DAO d = new DAO();
                string reg = d.EncontrarReglas(id);
            %>
            document.getElementById("textarea1").value = "<%Response.Write(reg);%>";
        </script>

      </div>
    <a href="Campania.aspx" style="padding-left:100px;"><--Volver</a>


    <% 
        Campania c;

        if (!string.IsNullOrEmpty(Request.Form["btngua"]))
        {
           
            reg = Request.Form["txt_reg"];

            if (reg.Length > 2000)
            {
                error = "Las reglas pueden tener un máximo de 2000 caracteres. ";
            }

            if (error.Length > 0)
            {
                Response.Write("<script>alert('"+error+"');</script>");
            }
            else
            {
                c = new Campania(id, nom, reg, usu);
                string mensaje = d.GuardarReglas(c);
                Response.Write("<script>alert('"+mensaje+"');</script>");
                Response.Write("<script>location.href='Reglas.aspx';</script>");
            }
        }
    %>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
      <script type="text/javascript" src="js/materialize.min.js"></script>
      <script type="text/javascript">
         $(document).ready(function() {
          $('select').material_select();
        });
      </script>
</body>
</html>
