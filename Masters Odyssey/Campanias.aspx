<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Campanias.aspx.cs" Inherits="Masters_Odyssey.Campanias" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
      <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
      <link rel="stylesheet" type="text/css" href="css/estilos.css"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
      <title>Master's Odyssey - Campañas</title>
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
      <div style="text-align:center">
        <h5>Mis campañas</h5>
        <br/>
          <form id="form_cam" runat="server" method="post" action="Campanias.aspx">
          <div class="container">        
            <table class="bordered">
              <tr>
                <td><h6>Nueva Campaña: </h6></td>
                <td>
                  <div class="row" style="margin-bottom: 0px; text-align:center">
                    <div class="col s6 input-field">
                      <input type="text" name="txt_nom" id="txt_nom"/>
                      <label for="txt">Nombre de la Campaña</label>
                    </div>
                  </div>
                </td>
                <td>
                    <input type="submit" name="btncre" value="Crear" /></td>
              </tr>
             </table>
           </div>
           </form>
           <form id="form2" method="post" action="Campanias.aspx">
           <div class="container">
            <table>
              <tr>
                <td><h6>Seleccionar Campaña: </h6></td>
                <td>
                  <select id="cbocam" name="cbocam" required="required">
                      <option value = "0">Lista de mis campañas...</option>
                      <%
                          List<Campania> lista = new List<Campania>();
                          DAO d = new DAO();
                          lista = d.ListaCampañas();
                          foreach (var item in lista)
                          {
                              if (item.Nom_usu.Equals(Session["nom_usu"]))
                              {
                                  Response.Write("<option value = '"+item.Id+"' >"+item.Nombre+"</option>");
                              }
                          }
                      %>
                  </select>
                </td>
                <td>
                    <input type="submit" name="btnenv" value="Elegir" />
                </td>
                  <td>
                      <input type="submit" name="btneli" value="Eliminar"/>
                  </td>
              </tr>
            </table>
        </div>
        </form>
      </div>


        <%
            Campania c;

            string nom = "", reg = "", usu="", error = "";
            int id = 0;
            string op = Request.Form["cbocam"];
            usu = Convert.ToString(Session["nom_usu"]);

            Session["opcion"] = op;

            if(!string.IsNullOrEmpty(Request.Form["btncre"])){
                nom = Request.Form["txt_nom"].Trim();

                if(nom.Length < 3 || nom.Length > 30){
                    error = "El nombre de la campaña debe tener entre 3 y 30 caracteres.";
                    Response.Write("<script>alert('"+error+"');</script>");
                    Response.Write("<script>document.getElementById('txt_nom').value ='" + nom + "';</script>");
                }else{
                    c = new Campania(id, nom, reg, usu);
                    string mensaje = d.CrearCampaña(c);
                    Response.Write("<script>alert('"+mensaje+"');</script>");
                    Response.Write("<script>location.href='Campanias.aspx';</script>");
                }
            }

            if (!string.IsNullOrEmpty(Request.Form["btneli"]))
            {
                if (int.Parse(op) == 0)
                {
                    Response.Write("<script>alert('No se puede borrar esta opcion.');</script>");
                }
                else
                {
                    lista = d.ElegirCampaña(int.Parse(op));
                    if (lista != null)
                    {
                        foreach (var item in lista)
                        {
                            Session["nom_cam"] = item.Nombre;
                        }
                    }

                    Response.Write("<script>location.href='EliminarCampania.aspx';</script>");
                }

            }


            if (!string.IsNullOrEmpty(Request.Form["btnenv"]))
            {
                if (int.Parse(op) == 0)
                {
                    Response.Write("<script>alert('No se puede elegir esta opcion.');</script>");
                }
                else
                {
                    lista = d.ElegirCampaña(int.Parse(op));
                    if (lista != null)
                    {
                        foreach (var item in lista)
                        {
                            Session["id_cam"] = item.Id;
                            Session["nom_cam"] = item.Nombre;
                            Response.Write("<script>location.href='Campania.aspx';</script>");
                        }
                    }
                    else
                    {
                        Response.Write("<script>alert('No se ha encontrado esta campaña.');</script>");
                    }

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
