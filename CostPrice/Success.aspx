<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Success.aspx.cs" Inherits="MobileCenter.Success" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Registration Success</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0" />
    <meta http-equiv="refresh" content="10;URL='LogIn.aspx'" />

    <link rel="stylesheet" href="css/demo.css" />
    <link rel="stylesheet" href="css/sky-forms.css" />
    <!--[if lt IE 9]>
			<link rel="stylesheet" href="css/sky-forms-ie8.css">
		<![endif]-->

    <!--[if lt IE 10]>
			<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
			<script src="js/jquery.placeholder.min.js"></script>
		<![endif]-->
    <!--[if lt IE 9]>
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
			<script src="js/sky-forms-ie8.js"></script>
		<![endif]-->
</head>
<body class="bg-cyan">
    <div class="body body-s">
        <form runat="server" class="sky-form">
            <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <telerik:RadAjaxPanel ID="RadAjaxPanelSuccess" runat="server">
                <header>Registration Success</header>
                <fieldset>
                    <div class="row">
                        <h2>Congratulations!</h2>
                      Your registration request has been recieved successfully.
                    </div>
                    <br />
                    <br />
                </fieldset>
            </telerik:RadAjaxPanel>
        </form>
    </div>
</body>
</html>