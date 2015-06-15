<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="MobileCenter.Registration" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Registration page</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0" />
    <script src="/vendor/jquery/jquery.min.js"></script>
    <link href="/app/css/bootstrap.css" rel="stylesheet" />
    <script src="/js/bootstrap/js/bootstrap.js"></script>
    <link rel="stylesheet" href="css/demo.css?v=33" />
    <link rel="stylesheet" href="css/sky-forms.css?v=33" />
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
        $(document).ready(function () {
            $(function () {
                $('[data-toggle="tooltip"]').tooltip({ html: true });
            });
        });
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
<body class="bg-cyan">
    <div class="body body-s" style="max-width: 600px;">
        <form runat="server" class="sky-form">
            <asp:ScriptManager ID="ScriptManager1" runat="server" />

            <header>Registration form</header>
            <telerik:RadNotification ID="RadNotification1" runat="server" Skin="MetroTouch" Position="Center" Width="400" TitleIcon="" AutoCloseDelay="0"></telerik:RadNotification>
            <fieldset>
                <div class="row">
                    <section class="col col-6">
                        <span id="company" runat="server" class="input"></span>
                    </section>
                    <section class="col col-6">
                        <span id="shop" runat="server" class="input"></span>
                    </section>
                    <section class="col col-6">
                        <span id="user" runat="server" class="input"></span>
                    </section>
                    <section class="col col-6">
                        <span id="online" runat="server" class="input"></span>
                    </section>
                </div>

                <div class="row">
                    <section class="col col-6">
                        <span id="spName" runat="server" class="input">
                            <asp:TextBox ID="tbName" type="text" placeholder="First name" runat="server" />
                        </span>
                    </section>
                    <section class="col col-6">
                        <span id="spSurName" runat="server" class="input">
                            <asp:TextBox ID="tbSurName" type="text" placeholder="Last name" runat="server" />
                        </span>
                    </section>
                </div>
                <asp:RequiredFieldValidator ID="nameValidator" runat="server" Display="None" ControlToValidate="tbName" EnableClientScript="False"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="surNameValidator" runat="server" Display="None" ControlToValidate="tbSurName" EnableClientScript="False"></asp:RequiredFieldValidator>

                <section>
                    <span runat="server" id="spEmail" class="input">
                        <i class="icon-append icon-envelope-alt"></i>
                        <asp:TextBox ID="tbEmail" type="text" placeholder="Email address" runat="server" />
                        <b class="tooltip tooltip-bottom-right">Needed to verify your account</b>
                    </span>
                </section>

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

                <section style="float: left; clear: both;">
                    <asp:RadioButton runat="server" Checked="True" CssClass="Space" ID="Personaluser" GroupName="UserType" Text="Personal user" />
                    <i class="icon-question-sign" style="cursor: pointer;" data-placement="right" data-toggle="tooltip" title="Lorem ipsum dolor sit amet, <br/> consectetur adipiscing elit, <br/> sed do eiusmod tempor incididunt ut labore  <br/>et dolore magna aliqua."></i>
                </section>
                <br />
                <br />
                <section style="float: left; clear: both;">
                    <asp:RadioButton runat="server" CssClass="Space" ID="Shopsuser" GroupName="UserType" Text="Shops user" />
                    <i class="icon-question-sign" style="cursor: pointer;" data-placement="right" data-toggle="tooltip" title="Lorem ipsum dolor sit amet, <br/> consectetur adipiscing elit, <br/> sed do eiusmod tempor incididunt ut labore  <br/>et dolore magna aliqua."></i>
                </section>
                <br />
                <br />
                <section style="float: left; clear: both;">
                    <asp:RadioButton runat="server" CssClass="Space" ID="Companyuser" GroupName="UserType" Text="Company user" />
                    <i class="icon-question-sign" data-placement="right" style="cursor: pointer;" data-toggle="tooltip" title="Lorem ipsum dolor sit amet, <br/> consectetur adipiscing elit, <br/> sed do eiusmod tempor incididunt ut labore  <br/>et dolore magna aliqua."></i>
                </section>

                <section style="clear: both;">
                    <span class="select">
                        <asp:DropDownList ID="ddlCountry" runat="server"></asp:DropDownList>
                        <i></i>
                    </span>
                </section>

                <div class="row">
                    <section class="col col-6">
                        <span runat="server" id="spPhoneNumber" class="input">
                            <asp:TextBox ID="tbPhoneNumber" Width="200px" runat="server"></asp:TextBox>
                            <i class="icon-prepend icon-phone"></i>
                        </span>
                    </section>
                    <section class="col col-2">
                        <span runat="server" id="spConfPhoneNumber" class="input">
                            <telerik:RadMaskedTextBox ID="tbConfPhoneNumber" runat="server" Mask="###-###" Font-Size="Medium" ForeColor="Gray" Enabled="False" Visible="False"></telerik:RadMaskedTextBox>
                        </span>
                    </section>
                </div>

                <asp:CustomValidator ID="phoneNumberValidation" runat="server" ControlToValidate="tbPhoneNumber" EnableClientScript="False" Display="None" />
                <asp:RegularExpressionValidator ID="emailValidation" runat="server" ControlToValidate="tbEmail" ValidationExpression="^[a-z][a-z|0-9|]*([_][a-z|0-9]+)*([.][a-z|0-9]+([_][a-z|0-9]+)*)?@[a-z][a-z|0-9|]*\.([a-z][a-z|0-9]*(\.[a-z][a-z|0-9]*)?)$" EnableClientScript="False" />
                <asp:RequiredFieldValidator ID="emailValidationEmpty" ControlToValidate="tbEmail" runat="server" EnableClientScript="False"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="passwordValidator1" runat="server" ControlToValidate="tbPassword" EnableClientScript="False" Display="None" />
                <asp:RegularExpressionValidator ID="passwordValidator2" runat="server" ControlToValidate="tbPassword" ValidationExpression="[^\s]{4,12}" EnableClientScript="False" Display="None" />
                <asp:RequiredFieldValidator ID="rePasswordValidator1" runat="server" ControlToValidate="tbConfPassword" EnableClientScript="False" />
                <asp:CompareValidator ID="rePasswordValidator2" runat="server" ControlToValidate="tbConfPassword" ControlToCompare="tbPassword" EnableClientScript="False" />
            </fieldset>

            <footer>

                <asp:Button ID="btnSubmit" type="submit" class="button" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                <asp:Button ID="btnConfirm" type="submit" class="button" runat="server" Text="Confirm" OnClick="btnConfirm_Click" Enabled="False" Visible="False" />
                <a class="button" href="/AllPriceList.aspx">Back to Price List</a>
            </footer>

        </form>
    </div>
</body>
</html>
