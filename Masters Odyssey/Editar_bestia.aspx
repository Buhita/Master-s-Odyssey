<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Editar_bestia.aspx.cs" Inherits="Masters_Odyssey.Editar_bestia" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
      <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
      <link rel="stylesheet" type="text/css" href="css/estilos.css"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title> Master's Odyssey - Edición de Bestia </title>
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
            <h7>Campaña: <%Response.Write(Session["nom_cam"]);%></h7>
            <h5>Edición de bestia</h5>
        <br>
            <form id="form1" runat="server">
                <div class="container">
                <table id="tabbes">
                    <tr>
                        <td colspan="2"><label>Nombre</label></td>
                        <td colspan="2"><input type="text" name="txt_nom" id="txt_nom" maxlength="30"/></td>
                    </tr>
                    <tr>
                        <td colspan="2"><label>Estadísticas:</label></td>
                        <td colspan="2"><label>Características:</label></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="txt_est1" id="txt_est1" style="width: 150px;" maxlength="15"/></td>
                        <td><input type="text" name="txt_est2" id="txt_est2" style="width: 150px;" maxlength="15"/></td>
                        <td colspan="2" rowspan="4"><textarea id="txt_car" class="materialize-textarea" maxlength="500" style="height: 300px;" name="txt_car"></textarea></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="txt_est3" id="txt_est3" style="width: 150px;" maxlength="15"/></td>
                        <td><input type="text" name="txt_est4" id="txt_est4" style="width: 150px;" maxlength="15"/></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="txt_est5" id="txt_est5" style="width: 150px;" maxlength="15"/></td>
                        <td><input type="text" name="txt_est6" id="txt_est6" style="width: 150px;" maxlength="15"/></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="txt_est7" id="txt_est7" style="width: 150px;" maxlength="15"/></td>
                        <td><input type="text" name="txt_est8" id="txt_est8" style="width: 150px;" maxlength="15"/></td>
                    </tr>
                    <tr>
                        <td  colspan="4">
                           <input type="submit" name="btngua" value="Guardar bestia" />
                        </td>
                    </tr>
                </table>
                </div>
            </form>
        </div>
    <a href="Bestiario.aspx" style="padding-left:100px;"><--Volver</a>
     <%
        Bestia b;
        string error = "",nom = "", est1 = "", est2 = "", est3 = "", est4 = "", est5 = "", est6 = "", est7 = "", est8 = "", car = "";
        DAO d = new DAO();
        List<Bestia> listab = new List<Bestia>();

        if (Request.QueryString["id"] != null)
        {
            int id = int.Parse(Request.QueryString["id"]);
            listab = d.SacarBestia(id);
            foreach (var item in listab)
            {
                if (item.Id.Equals(id) && item.Id_cam.Equals(Session["id_cam"]))
                {
                    Response.Write("<script>document.getElementById('txt_nom').value ='" + item.Nombre + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est1').value ='" + item.Estado1 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est2').value ='" + item.Estado2 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est3').value ='" + item.Estado3 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est4').value ='" + item.Estado4 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est5').value ='" + item.Estado5 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est6').value ='" + item.Estado6 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est7').value ='" + item.Estado7 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est8').value ='" + item.Estado8 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_car').value ='" + item.Caracter + "';</script>");
                }
            }
        }

        if (!string.IsNullOrEmpty(Request.Form["btngua"]))
        {
            nom = Request.Form["txt_nom"].Trim();
            car = Request.Form["txt_car"].Trim();
            est1 = Request.Form["txt_est1"].Trim();
            est2 = Request.Form["txt_est2"].Trim();
            est3 = Request.Form["txt_est3"].Trim();
            est4 = Request.Form["txt_est4"].Trim();
            est5 = Request.Form["txt_est5"].Trim();
            est6 = Request.Form["txt_est6"].Trim();
            est7 = Request.Form["txt_est7"].Trim();
            est8 = Request.Form["txt_est8"].Trim();
            if (Request.QueryString["id"] != null)
            {

                if (nom.Length < 1 || nom.Length > 30)
                {
                    error = error + "El nombre debe tener entre 1 y 30 caracteres. ";
                }

                if (car.Length > 500)
                {
                    error = error + "Las características deben tener hasta 500 caracteres. ";
                }
                if (est1.Length > 15 || est2.Length > 15 || est3.Length > 15 || est4.Length > 15 || est5.Length > 15 || est6.Length > 15 || est7.Length > 15 || est8.Length > 15 )
                {
                    error = error + "Las estadísticas deben tener hasta 15 caracteres.  ";
                }

                if (error.Length > 0)
                {
                    Response.Write("<script>alert('"+error+"');</script>");
                    Response.Write("<script>document.getElementById('txt_nom').value ='" + nom + "';</script>");
                    Response.Write("<script>document.getElementById('txt_car').value ='" + car + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est1').value ='" + est1 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est2').value ='" + est2 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est3').value ='" + est3 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est4').value ='" + est4 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est5').value ='" + est5 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est6').value ='" + est6 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est7').value ='" + est7 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est8').value ='" + est8 + "';</script>");
                }
                else
                {
                    int id = int.Parse(Request.QueryString["id"]);
                    b = new Bestia(id,nom,est1,est2,est3,est4,est5,est6,est7,est8,car,int.Parse(Session["id_cam"].ToString()));
                    string mensaje = d.ModificarBestia(b);
                    Response.Write("<script>alert('"+mensaje+"');</script>");
                    Response.Write("<script>location.href='Bestiario.aspx?id="+id+"';</script>");
                }


            }
            else
            {

                if (nom.Length < 1 || nom.Length > 30)
                {
                    error = error + "El nombre debe tener entre 1 y 30 caracteres. ";
                }

                if (car.Length > 500)
                {
                    error = error + "Las características deben tener hasta 500 caracteres. ";
                }
                if (est1.Length > 8 || est2.Length > 8 || est3.Length > 8 || est4.Length > 8 || est5.Length > 8 || est6.Length > 8 || est7.Length > 8 || est8.Length > 8 )
                {
                    error = error + "Las estadísticas deben tener hasta 8 caracteres.  ";
                }

                if (error.Length > 0)
                {
                    Response.Write("<script>alert('"+error+"');</script>");
                    Response.Write("<script>document.getElementById('txt_nom').value ='" + nom + "';</script>");
                    Response.Write("<script>document.getElementById('txt_car').value ='" + car + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est1').value ='" + est1 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est2').value ='" + est2 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est3').value ='" + est3 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est4').value ='" + est4 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est5').value ='" + est5 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est6').value ='" + est6 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est7').value ='" + est7 + "';</script>");
                    Response.Write("<script>document.getElementById('txt_est8').value ='" + est8 + "';</script>");
                }
                else
                {
                    b = new Bestia(0,nom,est1,est2,est3,est4,est5,est6,est7,est8,car,int.Parse(Session["id_cam"].ToString()));
                    string mensaje = d.CrearBestia(b);
                    Response.Write("<script>alert('"+mensaje+"');</script>");
                    Response.Write("<script>location.href='Bestiario.aspx';</script>");
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

