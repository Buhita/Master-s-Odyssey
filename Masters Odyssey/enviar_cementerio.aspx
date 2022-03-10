<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="enviar_cementerio.aspx.cs" Inherits="Masters_Odyssey.enviar_cementerio" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
     <%@ Import Namespace= "Masters_Odyssey.Clases" %>
     <%

         if (Session["nom_usu"] == null || Session["cor_usu"] == null)
         {
             Response.Write("<script>alert('Debe iniciar sesión para ingresar a esta página.');</script>");
             Response.Write("<script>location.href='Login.aspx';</script>");
         }
         else
         {
             DAO d = new DAO();
             int id = int.Parse(Request.QueryString["id"]);

             string mensaje = d.EnviarCementerio(id);
             Response.Write("<script>alert('"+mensaje+"');</script>");
             
             Response.Write("<script>location.href='Personajes.aspx';</script>");
         }
    %>
</body>
</html>
