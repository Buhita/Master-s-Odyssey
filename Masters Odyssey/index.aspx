<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Masters_Odyssey.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
      <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
      <link rel="stylesheet" type="text/css" href="css/estilos.css"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
      <title>Master's Odyssey</title>
</head>
<body class="indigo lighten-5">
    <header style="text-align: right; margin-right: 10px">
        <a href="Login.aspx">Iniciar Sesión |</a>
        <a href="Registro.aspx">| Registrarse</a>
      </header>
      <h2 align="center"><a href="index.aspx" class="black-text">Master's Odyssey</a></h2>
    	<nav class="indigo darken-4">
		    <div class="nav-wrapper;">
		        <ul class="center hide-on-med-and-down">
		        <li class="indigo darken-3" style="width: 25%"><a href="Campanias.aspx">Campañas</a></li>
		        <li class="indigo darken-3" style="width: 25%"><a href="Partidas.aspx">Partidas</a></li>
                <li class="indigo darken-3" style="width: 25%"><a href="Cementerio.aspx">Cementerio</a></li>
                <li class="indigo darken-3" style="width: 25%"><a href="Dados.aspx">Lanzar dados</a></li>
		      </ul>
		    </div>
	  	</nav>
      <div align="center">
        <h5>¡Bienvenido a Master's Odyssey!</h5>
        <p>Si eres director de juego, o quieres serlo</p>
        <p>y te ha costado organizar tus partidas de rol...</p>
        <p>¡Aquí tenemos la solución!</p>
        <p>De una forma sencilla y rápida.</p>
        <p>Solo inicia sesión o regístrate para comenzar</p>
      </div>
      <div align="center">
          <form action="Login.aspx">
            <button type="submit">Ya tengo una cuenta, ¡Déjame entrar!</button>
          </form>
          <form action="Registro.aspx">
            <button type="submit">No tengo cuenta, quiero registrarme</button>
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
