<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Editar_partidaporR.aspx.cs" Inherits="Masters_Odyssey.Editar_partidaporR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
      <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
      <link rel="stylesheet" type="text/css" href="css/estilos.css"/>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title> Master's Odyssey - Edición de Partida Realizada </title>
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
      <h2 align="center">Master's Odyssey</h2>
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
            <h5>Edición de partida por realizar</h5>
        <br/>
            <form id="form1" runat="server">
                <div class="container">
                <table id="tabpar">
                    <tr>
                        <td colspan="2"><h6>Seleccionar Campaña: </h6></td>
                        <td colspan="2">
                          <select id="cbocam" name="cbocam" required>
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
                    </tr>
                    <tr>
                        <td><h6>Nombre: </h6></td>
                        <td colspan="2"><input type="text" name="txt_nom" id="txt_nom" maxlength="30"/></td>
                    </tr>
                    <tr>
                        <td colspan="4"><h6>Notas: </h6></td>
                    </tr>
                    <tr>
                        <td colspan="4" rowspan="4"><textarea id="txt_not" class="materialize-textarea" maxlength="1000" style="height: 200px;" name="txt_not"></textarea></td>
                    </tr>
                    
                </table>
                    <table>
                <tr>
                    <td><input type="submit" name="btngua" value="Guardar partida"  /></td>
                </tr>
            </table>
                </div>
            </form>
            
            <form method="post">
            <table>
                <%
                    if (Request.QueryString["id"] != null)
                    {
                        Response.Write("<tr><td style='text-align:right;'><input type='submit' name='btnmar' value='Marcar como realizada'  /></td></tr>");
                    }
                %>
            </table>
            </form>
        </div>
    <a href="Partidas_porR.aspx" style="padding-left:100px;"><--Volver</a>
    <%
        string error = "", nom = "", res = "", not ="", cam = "";
        Partida p;

        if (Request.QueryString["id"] != null)
        {
            List<Partida> listapr = new List<Partida>();
            DAO d = new DAO();
            int id = int.Parse(Request.QueryString["id"]);
            listapr = d.EncontrarPartida(id);
            foreach (var item in listapr)
            {
                if (item.Id.Equals(id))
                {
                    List<Campania> listac = new List<Campania>();
                    listac = d.ListaCampañas();
                    foreach (var itemc in listac)
                    {
                        if (itemc.Id.Equals(item.Id_cam))
                        {
                            Response.Write("<script>document.getElementById('cbocam').value ='" + item.Id_cam + "';</script>");
                        }
                    }
                    Response.Write("<script>document.getElementById('txt_nom').value ='" + item.Nombre + "';</script>");
                    Response.Write("<script>document.getElementById('txt_not').value ='" + item.Notas + "';</script>");
                }
            }
            if (!string.IsNullOrEmpty(Request.Form["btnmar"]))
            {
                string mensaje = d.MarcarComoRealizada(id);
                Response.Write("<script>alert('"+mensaje+"');</script>");
                Response.Write("<script>location.href='Editar_partidaR.aspx?id="+id+"';</script>");
            }
        }

        if (!string.IsNullOrEmpty(Request.Form["btngua"]))
        {
            nom = Request.Form["txt_nom"];
            not = Request.Form["txt_not"];
            cam = Request.Form["cbocam"];
            if (Request.QueryString["id"] != null)
            {
                if (int.Parse(cam) == 0)
                {
                    error = error + "Debe seleccionar una campaña y si no existe ninguna, puede crearla en el apartado Campañas. ";
                }
                if (nom.Length < 1 || nom.Length > 30)
                {
                    error = error + "El nombre debe tener entre 1 y 30 caracteres. ";
                }
                if (not.Length > 1000)
                {
                    error = error + "Las notas deben tener hasta 1000 caracteres. ";
                }
                if (error.Length > 0)
                {
                    Response.Write("<script>alert('"+error+"');</script>");
                    Response.Write("<script>document.getElementById('txt_nom').value ='" + nom + "';</script>");
                    Response.Write("<script>document.getElementById('txt_not').value ='" + not + "';</script>");
                    Response.Write("<script>document.getElementById('cbocam').value ='" + cam + "';</script>");
                }
                else
                {
                    List<Partida> listapr = new List<Partida>();
                    DAO d = new DAO();
                    int id = int.Parse(Request.QueryString["id"]);
                    listapr = d.EncontrarPartida(id);
                    foreach (var item in listapr)
                    {
                        if (item.Id.Equals(id))
                        {
                            p = new Partida(id,nom,res,not,int.Parse(cam),0);
                            string mensaje = d.ModificarPartidaPorRealizar(p);
                            Response.Write("<script>alert('"+mensaje+"');</script>");
                            Response.Write("<script>location.href='Partidas_porR.aspx?id="+item.Id+"';</script>");
                        }
                    }
                }


            }
            else
            {
                if (int.Parse(cam) == 0)
                {
                    error = error + "Debe seleccionar una campaña y si no existe ninguna, puede crearla en el apartado Campañas. ";
                }
                if (nom.Length < 1 || nom.Length > 30)
                {
                    error = error + "El nombre debe tener entre 1 y 30 caracteres. ";
                }
                if (not.Length > 1000)
                {
                    error = error + "Las notas deben tener hasta 1000 caracteres. ";
                }
                if (error.Length > 0)
                {
                    Response.Write("<script>alert('"+error+"');</script>");
                    Response.Write("<script>document.getElementById('txt_nom').value ='" + nom + "';</script>");
                    Response.Write("<script>document.getElementById('txt_not').value ='" + not + "';</script>");
                    Response.Write("<script>document.getElementById('cbocam').value ='" + cam + "';</script>");
                }
                else
                {
                    DAO d = new DAO();
                    p = new Partida(0,nom,res,not,int.Parse(cam),0);
                    string mensaje = d.CrearPartidaPorRealizar(p);
                    Response.Write("<script>alert('"+mensaje+"');</script>");
                    Response.Write("<script>location.href='Partidas_porR.aspx';</script>");
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


