<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cerrar.aspx.cs" Inherits="Masters_Odyssey.Cerrar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <% 
        Session.Abandon();
        Session.RemoveAll();
        Response.Cookies.Clear();
        Response.Redirect("index.aspx");
    %>
</body>
</html>
