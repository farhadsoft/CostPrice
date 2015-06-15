using System.Configuration;
using System.Data.SqlClient;

namespace MobileCenter.Classes
{
    internal static class Database
    {
        /// <summary>Connection string name shared with the SqlDataSource controls in the .aspx markup.</summary>
        public const string ConnectionStringName = "ConnectionString";

        public static SqlConnection OpenConnection()
        {
            var connection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConnectionStringName].ConnectionString);
            connection.Open();
            return connection;
        }
    }
}
