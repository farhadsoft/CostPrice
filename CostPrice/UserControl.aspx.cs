using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using MobileCenter.Classes;
using Telerik.Web.UI;

namespace MobileCenter
{
    public partial class UserControl : System.Web.UI.Page
    {
        private const string LoginPage = "LogIn.aspx";
        private const string DefaultCountryIso = "AE";

        private string gridMessage;

        protected void Page_Load(object sender, EventArgs e)
        {
            // A null session value also fails this check, as before.
            if ((string)Session["UserType"] != UserTypes.Admin.ToString())
            {
                Server.Transfer(LoginPage);
            }

            var userMenuItem = (HtmlGenericControl)Master.FindControl("userPage");
            userMenuItem.Attributes.Add("class", "active");
        }

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            var item = e.Item as GridEditableItem;
            if (item == null || !item.IsInEditMode || item is GridEditFormInsertItem)
            {
                return;
            }

            var idEditor = item.EditManager.GetColumnEditor("Id") as GridTextBoxColumnEditor;
            idEditor.TextBoxControl.Enabled = false;
        }

        protected void RadGrid1_ItemInserted(object source, GridInsertedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                gridMessage = "Customer cannot be inserted. Reason: " + e.Exception.Message;
            }
            else
            {
                gridMessage = "New customer is inserted!";
            }
        }

        protected void RadGrid1_PreRender(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(gridMessage))
            {
                RadGrid1.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", gridMessage)));
            }
        }

        protected void rbtnAddUser_Click(object sender, EventArgs e)
        {
            if (!addUserPanel.Visible)
            {
                addUserPanel.Visible = true;
                rtbPassword.Text = Credentials.GeneratePassword();
            }
            else
            {
                InsertUser();
                addUserPanel.Visible = false;
                RadGrid1.DataBind();
            }
        }

        private void InsertUser()
        {
            const string insertSql =
                "INSERT INTO Users (email, password, name, surname, country, mobileNum1, enable) " +
                "VALUES (@email, @password, @name, @surname, @country, @phoneNumber, 1)";

            using (SqlConnection connection = Database.OpenConnection())
            using (var command = new SqlCommand(insertSql, connection))
            {
                command.Parameters.AddWithValue("@email", rtbEmail.Text);
                command.Parameters.AddWithValue("@password", Credentials.HashPassword(rtbPassword.Text));
                command.Parameters.AddWithValue("@name", rtbName.Text);
                command.Parameters.AddWithValue("@surname", rtbSurname.Text);
                command.Parameters.AddWithValue("@country", DefaultCountryIso);
                command.Parameters.AddWithValue("@phoneNumber", rtbMobile1.Text);
                command.ExecuteNonQuery();
            }
        }
    }
}
