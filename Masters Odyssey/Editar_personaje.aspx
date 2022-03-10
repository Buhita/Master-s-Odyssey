<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Personajes.aspx.cs" Inherits="Masters_Odyssey.Personajes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
      <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
      <link rel="stylesheet" type="text/css" href="css/estilos.css"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title> Master's Odyssey - Edición de Personaje </title>
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
            <h6>Campaña: <%Response.Write(Session["nom_cam"]);%></h6>
            <h5>Edición de personaje</h5>
        <br/>
            <form id="form1" runat="server">
                <div class="container">
                <table id="tabper">
                    <tr>
                        <td colspan="2"><label>Nombre</label></td>
                        <td colspan="2"><input type="text" name="txt_nom" id="txt_nom" maxlength="30"/></td>
                    </tr>
                    <tr>
                        <td><label>Raza: </label></td>
                        <td><input type="text" name="txt_raz" id="txt_raz" maxlength="20"/></td>
                        <td><label>Clase: </label></td>
                        <td><input type="text" name="txt_cla" id="txt_cla" maxlength="20"/></td>
                    </tr>
                    <tr>
                        <td colspan="2"><label>Estadísticas:</label></td>
                        <td colspan="2"><label>Características:</label></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="txt_est1" id="txt_est1" style="width: 150px;" maxlength="15"/></td>
                        <td><input type="text" name="txt_est2" id="txt_est2" style="width: 150px;" maxlength="15"/></td>
                        <td colspan="2" rowspan="4"><textarea id="txt_car" class="materialize-textarea" maxlength="500" style="height: 300px;" name="txt_car"></textarea></td><!--textarea-->
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
                            <input type="submit" name="btngua" value="Guardar personaje" />
                        </td>
                    </tr>
                </table>
                </div>
            </form>
        </div>
    <a href="Personajes.aspx" style="padding-left:100px;"><--Volver</a>
    <%
        Personaje p;
        string error = "",nom = "", raz = "", cla = "", est1 = "", est2 = "", est3 = "", est4 = "", est5 = "", est6 = "", est7 = "", est8 = "", car = "";
        DAO d = new DAO();
        List<Personaje> listap = new List<Personaje>();

        if (Request.QueryString["id"] != null)
        {
            int id = int.Parse(Request.QueryString["id"]);
            listap = d.SacarPersonaje(id);
            foreach (var item in listap)
            {
                if (item.Id.Equals(id) && item.Id_cam.Equals(Session["id_cam"]))
                {
                    Response.Write("<script>document.getElementById('txt_nom').value ='" + item.Nombre + "';</script>");
                    Response.Write("<script>document.getElementById('txt_raz').value ='" + item.Raza + "';</script>");
                    Response.Write("<script>document.getElementById('txt_cla').value ='" + item.Clase + "';</script>");
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
            raz = Request.Form["txt_raz"].Trim();
            cla = Request.Form["txt_cla"].Trim();
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

                if (raz.Length > 20)
                {
                    error = error + "La raza debe tener hasta 20 caracteres. ";
                }

                if (cla.Length > 20)
                {
                    error = error + "La clase debe tener hasta 20 caracteres. ";
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
                    Response.Write("<script>document.getElementById('txt_raz').value ='" + raz + "';</script>");
                    Response.Write("<script>document.getElementById('txt_cla').value ='" + cla + "';</script>");
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
                    p = new Personaje(id,nom,raz,cla,est1,est2,est3,est4,est5,est6,est7,est8,car,1,int.Parse(Session["id_cam"].ToString()));
                    string mensaje = d.ModificarPersonaje(p);
                    Response.Write("<script>alert('"+mensaje+"');</script>");
                    Response.Write("<script>location.href='Personajes.aspx?id="+id+"';</script>");
                }


            }
            else
            {

                if (nom.Length < 1 || nom.Length > 30)
                {
                    error = error + "El nombre debe tener entre 1 y 30 caracteres. ";
                }

                if (raz.Length > 20)
                {
                    error = error + "La raza debe tener hasta 20 caracteres. ";
                }

                if (cla.Length > 20)
                {
                    error = error + "La clase debe tener hasta 20 caracteres. ";
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
                    Response.Write("<script>document.getElementById('txt_raz').value ='" + raz + "';</script>");
                    Response.Write("<script>document.getElementById('txt_cla').value ='" + cla + "';</script>");
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
                    p = new Personaje(0,nom,raz,cla,est1,est2,est3,est4,est5,est6,est7,est8,car,1,int.Parse(Session["id_cam"].ToString()));
                    string mensaje = d.CrearPersonaje(p);
                    Response.Write("<script>alert('"+mensaje+"');</script>");
                    Response.Write("<script>location.href='Personajes.aspx';</script>");
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
