<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Campanias.aspx.cs" Inherits="Masters_Odyssey.Campanias" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
      <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
      <link rel="stylesheet" type="text/css" href="css/estilos.css"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
      <title>Master's Odyssey - Campaña</title>
</head>
<body class="indigo lighten-5">
    <%@ Import Namespace= "Masters_Odyssey.Clases" %>
    <%

        if (Session["nom_usu"] == null || Session["cor_usu"] == null)
        {
            Response.Write("<script>alert('Debe iniciar sesión para ingresar a esta página.');</script>");
            Response.Write("<script>location.href='Login.aspx';</script>");
        }
        string ids = Session["id_cam"].ToString(), nom = "", usu = "";
        int id = int.Parse(ids);

        nom = Session["nom_cam"].ToString();
        usu = Session["nom_usu"].ToString();

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
          <h5>Campaña: <%Response.Write(Session["nom_cam"]);%></h5>
        <br/>
          <div class="container" style="align-content: center">        
            <table style="margin-left: 120px">
              <tr>
                <td style="width:30px">
                    <form action="Reglas.aspx">
                      <button type="submit"> RECORDATORIO DE REGLAS </button>
                    </form>
                </td> 
                <td>
                    <form action="Personajes.aspx">
                      <button type="submit"> PERSONAJES </button>
                    </form>
                </td>
                <td>
                    <form action="Bestiario.aspx">
                      <button type="submit"> BESTIARIO </button>
                    </form>
                </td>       
              </tr>
            </table>
          </div>
      </div>
    <a href="Campanias.aspx" style="padding-left:100px;"><--Volver</a>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
      <script type="text/javascript" src="js/materialize.min.js"></script>
      <script type="text/javascript">
         $(document).ready(function() {
          $('select').material_select();
        });
      </script>
</body>
</html>
