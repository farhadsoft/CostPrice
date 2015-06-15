<%@ Page AutoEventWireup="true" CodeBehind="Reset.aspx.cs" Inherits="MobileCenter.Reset" Language="C#" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Reset password page</title>
    <link rel="shortcut icon" href="~/icons/icon.ico" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0" />

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
    <!--Start of Zopim Live Chat Script-->
    <script type="text/javascript">
        window.$zopim || (function (d, s) {
            var z = $zopim = function (c) { z._.push(c) }, $ = z.s =
            d.createElement(s), e = d.getElementsByTagName(s)[0]; z.set = function (o) {
                z.set.
                _.push(o)
            }; z._ = []; z.set._ = []; $.async = !0; $.setAttribute('charset', 'utf-8');
            $.src = '//v2.zopim.com/?2sEoeIz91qClyvcQSz9qUgXmxUhVAbf8'; z.t = +new Date; $.
            type = 'text/javascript'; e.parentNode.insertBefore($, e)
        })(document, 'script');
    </script>
    <!--End of Zopim Live Chat Script-->
    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
            m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

        ga('create', 'UA-61861090-1', 'auto');
        ga('send', 'pageview');
    </script>
</head>

<body class="bg-black">
    <div class="body body-s">
        <form class="sky-form" id="loginForm" runat="server">
            <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
            </telerik:RadStyleSheetManager>
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
                <Scripts>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js">
                    </asp:ScriptReference>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js">
                    </asp:ScriptReference>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js">
                    </asp:ScriptReference>
                </Scripts>
            </telerik:RadScriptManager>
            <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            </telerik:RadAjaxManager>
            <telerik:RadNotification ID="RadNotification1" runat="server" Skin="MetroTouch" Position="Center" Width="400" TitleIcon="" AutoCloseDelay="0"></telerik:RadNotification>
            <header>Reset password form</header>
              <fieldset>
             

                    <section>
                        <span runat="server" id="spPassword" class="input">
                            <i class="icon-append icon-lock"></i>
                            <asp:TextBox ID="tbPassword" type="password" placeholder="Password" runat="server" />
                            <b class="tooltip tooltip-bottom-right">Password must be 4-12 latin characters and numbers</b>
                        </span>
                    </section>

                    <section>
                        <span runat="server" id="spConfPassword" class="input">
                            <i class="icon-append icon-lock"></i>
                            <asp:TextBox ID="tbConfPassword" type="password" placeholder="Confirm password" runat="server" />
                        </span>
                    </section>
 
                 

                     <asp:RequiredFieldValidator ID="passwordValidator1" runat="server" ControlToValidate="tbPassword" EnableClientScript="False" Display="None" />
                    <asp:RegularExpressionValidator ID="passwordValidator2" runat="server" ControlToValidate="tbPassword" ValidationExpression="[^\s]{4,12}" EnableClientScript="False" Display="None" />
                    <asp:RequiredFieldValidator ID="rePasswordValidator1" runat="server" ControlToValidate="tbConfPassword" EnableClientScript="False" />
                    <asp:CompareValidator ID="rePasswordValidator2" runat="server" ControlToValidate="tbConfPassword" ControlToCompare="tbPassword" EnableClientScript="False" />
                </fieldset>
            <footer>
                <asp:Button ID="btnSubmit" runat="server" Text="Save" CssClass="button" OnClick="btnSubmit_Click" />
                     <a class="button" href="/AllPriceList.aspx">Back to Price List</a>
            </footer>
        </form>
 
    </div>
</body>
</html>
