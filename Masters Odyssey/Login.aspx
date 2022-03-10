<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Masters_Odyssey.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
      <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
      <link rel="stylesheet" type="text/css" href="css/estilos.css"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
      <title>Master's Odyssey - Inicio de sesión</title>
</head>
<body class="indigo lighten-5">
     <header style="text-align: right; margin-right: 10px">
        <a href="Login.aspx">Iniciar Sesión |</a>
        <a href="Registro.aspx">| Registrarse</a>
      </header>
      <h2 align="center"><a href="index.aspx" class="black-text">Master's Odyssey</a></h2>
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
      <div class="container" style="text-align:center">
        <h5>Inicio de sesión</h5>
        <br/>
        <form id="form_log" runat="server" method="post" action="Login.aspx">
            <h6>Usuario: </h6>
            <input type="text" name="txt_nom" id="txt_nom" class="loginput" style="width:300px"/>
            <h6>Contraseña: </h6>
            <input type="password" name="txt_con" id="txt_con" class="loginput" style="width:300px"/>
            <br />
            <input type="submit" name="btnenv" value="Iniciar sesión" class="btn waves-effect indigo lighten-2" />
        </form>   
      </div>

    <%@ Import Namespace="Masters_Odyssey.Clases" %>

    <%
        Usuario u;
        DAO d = new DAO();

        string nom = "", cor = "", con = "", error = "";

        if (!string.IsNullOrEmpty(Request.Form["btnenv"])){
            nom = Request.Form["txt_nom"];
            con = Request.Form["txt_con"];

            if(nom.Length == 0 || con.Length == 0){
                error = "Existen campos que no fueron completados! :(";
                Response.Write("<script>alert('"+error+"');</script>");
                Response.Write("<script>document.getElementById('txt_nom').value ='" + nom + "';</script>");
            }else{
                u = new Usuario(nom, cor, con);
                cor = d.BuscarUsuario(u);
            }

            if (cor == null){
                error = "El nombre de usuario y la contraseña no coinciden.";
                Response.Write("<script>alert('"+error+"');</script>");
                Response.Write("<script>document.getElementById('txt_nom').value ='" + nom + "';</script>");
            }else{
                Session["nom_usu"] = nom;
                Session["cor_usu"] = cor;
                Response.Redirect("Campanias.aspx");
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
