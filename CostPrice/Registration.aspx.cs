using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI.HtmlControls;
using MaxMind.GeoIP2;
using MobileCenter.Classes;
using MobileCenter.Models;

namespace MobileCenter
{
    public partial class Registration : System.Web.UI.Page
    {
        private const string PendingRegistrationSessionKey = "PendingRegistration";
        private const string FieldSuccessCssClass = "input state-success";
        private const string FieldErrorCssClass = "input state-error";
        private const string SuccessPage = "Success.aspx";
        private const string MaxMindHost = "geoip.maxmind.com";
        private const int MaxMindTimeoutMilliseconds = 3000;
        // Public IP used for GeoIP lookups when the site runs on localhost.
        private const string LocalhostFallbackIp = "85.132.99.44";
        private const int MinPhoneNumberLength = 8;
        private const string DefaultLongitude = "131.044922";
        private const string DefaultLatitude = "-25.363882";
        private const string DuplicateUserMessage =
            "Email or Phone is already in use. If you have questions please conact to administrator ";

        private readonly SMSC smsClient = new SMSC();

        [Serializable]
        private sealed class PendingRegistration
        {
            public string Name { get; set; }
            public string Surname { get; set; }
            public string Email { get; set; }
            public string Password { get; set; }
            public string Country { get; set; }
            public string PhoneNumber { get; set; }
            public int SmsCode { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string countryIso = DetectVisitorCountryIso();
                BindCountries();
                ddlCountry.SelectedValue = countryIso;
                tbPhoneNumber.Text = GetPhoneCode(countryIso);
            }

            ShowUserStatistics();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SetFieldStyle(spName, nameValidator.IsValid);
            SetFieldStyle(spSurName, surNameValidator.IsValid);

            bool isEmailValid = emailValidation.IsValid && emailValidationEmpty.IsValid && !IsEmailRegistered(tbEmail.Text);
            SetFieldStyle(spEmail, isEmailValid);
            emailValidation.IsValid = isEmailValid;

            SetFieldStyle(spPassword, passwordValidator1.IsValid && passwordValidator2.IsValid);
            SetFieldStyle(spConfPassword, rePasswordValidator1.IsValid && rePasswordValidator2.IsValid);

            bool isPhoneValid = tbPhoneNumber.Text.Length >= MinPhoneNumberLength;
            SetFieldStyle(spPhoneNumber, isPhoneValid);
            phoneNumberValidation.IsValid = isPhoneValid;

            if (IsEmailOrPhoneInUse(tbEmail.Text, tbPhoneNumber.Text))
            {
                RadNotification1.Show(DuplicateUserMessage);
            }

            if (!Page.IsValid)
            {
                return;
            }

            var pending = new PendingRegistration
            {
                Name = tbName.Text,
                Surname = tbSurName.Text,
                Email = tbEmail.Text,
                Password = tbPassword.Text,
                Country = ddlCountry.SelectedValue,
                PhoneNumber = tbPhoneNumber.Text,
                SmsCode = Credentials.GenerateSmsCode()
            };
            Session[PendingRegistrationSessionKey] = pending;

            ShowSmsConfirmationStep();
            smsClient.send_sms(pending.PhoneNumber, pending.SmsCode.ToString(), translit: 1);
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            var pending = Session[PendingRegistrationSessionKey] as PendingRegistration;
            if (pending == null || tbConfPhoneNumber.Text != pending.SmsCode.ToString())
            {
                return;
            }

            RegisterUser(pending);
            Session.Remove(PendingRegistrationSessionKey);
            Response.Redirect(SuccessPage);
        }

        private void ShowUserStatistics()
        {
            using (var context = new CostPriceEntities())
            {
                company.InnerHtml = "Company " + context.Users.Count(u => u.userType == UserTypes.Company);
                shop.InnerHtml = "Shop " + context.Users.Count(u => u.userType == UserTypes.Shop);
                user.InnerHtml = "User " + context.Users.Count(u => u.userType == UserTypes.Personal);
            }

            online.InnerHtml = "Online " + Application["OnlineVisitors"];
        }

        private string DetectVisitorCountryIso()
        {
            var geoIpClient = new WebServiceClient(
                int.Parse(ConfigurationManager.AppSettings["MaxMindUserId"]),
                ConfigurationManager.AppSettings["MaxMindLicenseKey"],
                MaxMindHost,
                MaxMindTimeoutMilliseconds);

            string ip = Request.Params["HTTP_CLIENT_IP"] ?? Request.UserHostAddress;
            if (ip == "127.0.0.1" || ip == "::1")
            {
                ip = LocalhostFallbackIp;
            }

            return geoIpClient.Country(ip).Country.IsoCode;
        }

        private void BindCountries()
        {
            using (var context = new CostPriceEntities())
            {
                ddlCountry.DataTextField = "nicename";
                ddlCountry.DataValueField = "iso";
                ddlCountry.DataSource = context.Country.OrderBy(c => c.id).ToList();
                ddlCountry.DataBind();
            }
        }

        private static string GetPhoneCode(string countryIso)
        {
            using (var context = new CostPriceEntities())
            {
                int? phoneCode = context.Country
                    .Where(c => c.iso == countryIso)
                    .Select(c => (int?)c.phonecode)
                    .FirstOrDefault();
                return "+" + phoneCode;
            }
        }

        private static bool IsEmailRegistered(string email)
        {
            using (var context = new CostPriceEntities())
            {
                return context.Users.Any(u => u.email == email);
            }
        }

        private static bool IsEmailOrPhoneInUse(string email, string phone)
        {
            using (var context = new CostPriceEntities())
            {
                return context.Users.Any(u => u.mobileNum1 == phone || u.mobileNum2 == phone
                    || u.mobileNum3 == phone || u.email == email);
            }
        }

        private static void SetFieldStyle(HtmlGenericControl field, bool isValid)
        {
            field.Attributes["class"] = isValid ? FieldSuccessCssClass : FieldErrorCssClass;
        }

        private void ShowSmsConfirmationStep()
        {
            tbName.Enabled = false;
            tbSurName.Enabled = false;
            tbEmail.Enabled = false;
            tbPassword.Enabled = false;
            tbConfPassword.Enabled = false;
            tbPhoneNumber.Enabled = false;
            ddlCountry.Enabled = false;
            tbConfPhoneNumber.Enabled = true;
            tbConfPhoneNumber.Visible = true;
            btnConfirm.Enabled = true;
            btnConfirm.Visible = true;
            btnSubmit.Enabled = false;
            btnSubmit.Visible = false;
        }

        private int GetSelectedUserType()
        {
            if (Companyuser.Checked)
            {
                return UserTypes.Company;
            }

            if (Shopsuser.Checked)
            {
                return UserTypes.Shop;
            }

            return Personaluser.Checked ? UserTypes.Personal : UserTypes.Unspecified;
        }

        private void RegisterUser(PendingRegistration pending)
        {
            const string insertSql =
                "INSERT INTO Users (contactEmail, longit, lotit, email, password, name, surname, country, mobileNum1, regdate, userType, enable) " +
                "VALUES (@email, @longitude, @latitude, @email, @password, @name, @surname, @country, @phoneNumber, @regdate, @userType, @enable)";

            using (SqlConnection connection = Database.OpenConnection())
            using (var command = new SqlCommand(insertSql, connection))
            {
                command.Parameters.AddWithValue("@email", pending.Email);
                command.Parameters.AddWithValue("@longitude", DefaultLongitude);
                command.Parameters.AddWithValue("@latitude", DefaultLatitude);
                command.Parameters.AddWithValue("@password", Credentials.HashPassword(pending.Password));
                command.Parameters.AddWithValue("@name", pending.Name);
                command.Parameters.AddWithValue("@surname", pending.Surname);
                command.Parameters.AddWithValue("@country", pending.Country);
                command.Parameters.AddWithValue("@phoneNumber", pending.PhoneNumber);
                command.Parameters.AddWithValue("@regdate", DateTime.Now);
                command.Parameters.AddWithValue("@userType", GetSelectedUserType());
                command.Parameters.AddWithValue("@enable", true);
                command.ExecuteNonQuery();
            }
        }
    }
}
