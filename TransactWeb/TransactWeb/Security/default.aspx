<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="TransferAuthorizationWeb.Security._default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title>jQuery UI Example Page</title>
		<link type="text/css" href="../Scripts/JQueryUI/css/ui-lightness/jquery-ui-1.8.17.custom.css" rel="stylesheet" />	
		<script type="text/javascript" src="../Scripts/JQueryUI/js/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="../Scripts/JQueryUI/js/jquery-ui-1.8.17.custom.min.js"></script>

        <script type="text/javascript">
            $(function () {
                $("input:submit, a, button", ".demo").button();
                $("a", ".demo").click(function () { return false; });
            });
			
        </script>

</head>


<body>

    <div class="demo">

<button>A button element</button>

<input value="A submit button" type="submit"/>

<a href="#">An anchor</a>

</div><!-- End demo -->


    <form id="form1" runat="server">
    <div>
        Username: <asp:TextBox ID="txtUserName" runat="server" />
    </div>
    <div>
        Password: <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" />
    </div>
    <div>
        <asp:Button ID="btnLogin" runat="server" Text="Login" 
            onclick="btnLogin_Click" />
    </div>
    </form>
</body>
</html>
