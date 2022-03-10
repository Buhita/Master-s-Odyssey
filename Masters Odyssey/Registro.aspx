|<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="Masters_Odyssey.Registro" %>

<!DOCTYPE html>

  <html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
      <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
      <link rel="stylesheet" type="text/css" href="css/estilos.css"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
      <title>Master's Odyssey - Registro</title>
    </head>
    <body class="indigo lighten-5">
      <header style="text-align: right; margin-right: 10px">
        <a href="Login.aspx">Iniciar Sesión |</a>
        <a href="Registro.aspx">| Registrarse</a>
      </header>
      <div style="text-align:center">
          <h2 align="center"><a href="index.aspx" class="black-text">Master's Odyssey</a></h2>
      </div>
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
        <h5>Registro</h5>
        <br/>
        <form runat="server" method="post" action="Registro.aspx">
            <h6>Usuario:</h6>
            <input type="text" name="txt_nom" id="txt_nom" class="loginput" placeholder="Nombre De Usuario" style="width:300px"/>
            <h6>Correo:</h6>
            <input type="text" name="txt_cor" id="txt_cor" class="loginput" placeholder="Correo" style="width:300px"/>
            <h6>Contraseña:</h6>
            <input type="password" name="txt_con" id="txt_con" class="loginput" placeholder="Contraseña" style="width:300px"/>
            <h6>Repita la Contraseña: </h6>
            <input type="password" name="txt_rco" id="txt_rco" class="loginput" placeholder="Repetir Contraseña" style="width:300px"/>
            <br />
            <input type="submit" name="btnreg" value="Registrarse" class="btn waves-effect indigo lighten-2" style="padding:10px" />
        </form>
          
          <%@ Import Namespace="Masters_Odyssey.Clases" %>

          <%
              Usuario u;
              DAO d = new DAO();

              string nom = "", cor = "", con = "", rco = "", error = "";

              if (!string.IsNullOrEmpty(Request.Form["btnreg"]))
              {
                  nom = Request.Form["txt_nom"].Trim();
                  cor = Request.Form["txt_cor"].Trim();
                  con = Request.Form["txt_con"].Trim();
                  rco = Request.Form["txt_rco"].Trim();

                  if (nom.Length < 3 || nom.Length > 10)
                  {
                      error = "El nombre debe tener entre 3 y 10 caracteres. ";
                  }

                  if (cor.Length < 6 || cor.Length > 40)
                  {
                      error = error + "El correo debe tener entre 6 y 40 caracteres. ";
                  }

                  if (!cor.Contains("@") || !cor.Contains("."))
                  {
                      error = error + "Debe ingresar un correo válido.  ";
                  }

                  if (con.Length < 5 || con.Length > 50)
                  {
                      error = error + "La contraseña debe tener entre 5 y 50 caracteres. ";
                  }

                  if (con.ToUpper() == con || con.ToLower() == con)
                  {
                      error = error + "La contraseña debe tener mayúsculas y minúsculas. ";
                  }

                  if (!rco.Equals(con))
                  {
                      error = error + "Debe repetir correctamente la contraseña. ";
                  }

                  if (error.Length > 0)
                  {
                      Response.Write("<script>alert('"+error+"');</script>");
                      Response.Write("<script>document.getElementById('txt_nom').value ='" + nom + "';</script>");
                      Response.Write("<script>document.getElementById('txt_cor').value ='" + cor + "';</script>");
                  }
                  else
                  {
                      u = new Usuario(nom,cor,con);
                      string mensaje = d.RegistrarUsuario(u);
                      Response.Write("<script>alert('"+mensaje+"');</script>");
                      if (mensaje.Equals("Usuario registrado correctamente"))
                      {
                          Response.Write("<script>location.href='Login.aspx';</script>");
                      }
                      else
                      {
                          Response.Write("<script>location.href='Registro.aspx';</script>");
                      }
                  }
              }

          %>
      </div>
      <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
      <script type="text/javascript" src="js/materialize.min.js"></script>
      <script type="text/javascript">
          $(document).ready(function () {
              $('select').material_select();
          });
      </script>
    </body>
  </html>
