<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Campanias.aspx.cs" Inherits="Masters_Odyssey.Campanias" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
      <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
      <link rel="stylesheet" type="text/css" href="css/estilos.css"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
      <title>Master's Odyssey - Eliminar Bestia</title>
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
        <%
            DAO d = new DAO();
            if (Request.QueryString["id"] != null)
            {
                int id = int.Parse(Request.QueryString["id"]);
                string nom = d.NombreBestia(id);

                Session["ideli"] = id;

                Response.Write("<h5>¿Está seguro de querer eliminar la bestia "+nom+"?</h5>");
            }
           
            
        %>

        <br/>
        <form id="form2" method="post" action="EliminarBestia.aspx">
           <div class="container">
               <table>
                   <tr>
                       <td><input type="submit" name="btnsi" value="Sí"/></td>
                       <td><input type="submit" name="btnno" value="No"/></td>
                   </tr>
               </table>
           </div>
        </form>
      </div>

    <%
        string op = Session["ideli"].ToString();


        if (!string.IsNullOrEmpty(Request.Form["btnsi"]))
        {
            string mensaje = d.BorrarBestia(int.Parse(op));
            Response.Write("<script>alert('"+mensaje+"');</script>");
            Response.Write("<script>location.href='Bestiario.aspx';</script>");
        }

        if (!string.IsNullOrEmpty(Request.Form["btnno"]))
        {
            Response.Write("<script>location.href='Bestiario.aspx';</script>");
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
