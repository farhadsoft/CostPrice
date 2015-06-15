# CostPrice

ASP.NET Web Forms front end for **CostPrice.today**, a price-list platform for computer and phone shops. It provides user registration with GeoIP country detection and SMS phone confirmation, an admin grid for managing users, and an Entity Framework 5 database-first model of the product catalogue (CPU, RAM, VGA, HDD, screens, brands, price lists).

## About this repository

This is a 2015 learning project. In 2026 it was refactored for readability and C# best practice without changing the technology stack, the NuGet packages or the C# language version. Four bugs found along the way were fixed (per-visitor state kept in `static` fields, a registration `INSERT` that listed a column twice, a country list that was reset on every postback, and a predictable password generator); everything else behaves as before.

The original repository was incomplete. The markup refers to pages and assets that are not included: `LogIn.aspx`, `LogOut.aspx`, `Default.aspx`, `AllPriceList.aspx`, `AdminPanel.aspx`, `ProductControl.aspx`, and the `css/`, `js/`, `vendor/`, `app/` and `icons/` folders. What is here: the registration, success, reset-password and user-management pages, the admin master page, and the data model.

## Tech stack

Kept exactly as in 2015:

- .NET Framework 4.5, C# 5
- ASP.NET Web Forms
- Entity Framework 5 (database-first, EDMX) and plain ADO.NET for inserts
- Telerik UI for ASP.NET AJAX, AjaxControlToolkit
- MaxMind GeoIP2 web service (visitor country)
- SMSC.ru SMS API (confirmation codes)
- SQL Server

`CostPrice/Classes/smsc_api.cs` is SMSC.ru's published C# client (v3.1, <https://smsc.ru/doc/api/smsc_api.cs>). The original file was not part of the 2015 sources, so it was restored from the vendor with three small changes: debug output goes to `System.Diagnostics.Debug` instead of a `MessageBox`, a `#pragma` silences the unreachable-code warning caused by the compile-time `SMSC_DEBUG` constant, and the login and password are read from `Web.config`.

## Build and run

The project is a legacy (non-SDK) Web Application project. It needs **Windows**, **Visual Studio 2013 or later** and the .NET Framework 4.5 targeting pack; `dotnet build` on macOS or Linux does not work.

1. **Referenced DLLs.** Third-party assemblies are referenced as `..\..\DLL\<name>.dll` from `CostPrice\CostPrice.csproj`, i.e. from a `DLL` folder next to the repository folder (`<repo>\..\DLL`). They are not part of this repository. Put these 17 files there:

   `AjaxControlToolkit.dll`, `AjaxMin.dll`, `Dynamic.dll`, `HtmlAgilityPack.dll`, `MaxMind.Db.dll`, `MaxMind.GeoIP2.dll`, `Microsoft.Data.Edm.dll`, `Microsoft.Data.OData.dll`, `Microsoft.QualityTools.Testing.Fakes.dll`, `Microsoft.WindowsAzure.Configuration.dll`, `Microsoft.WindowsAzure.Storage.dll`, `Newtonsoft.Json.dll`, `RestSharp.dll`, `System.Spatial.dll`, `System.Xml.4.0.0.0.Fakes.dll`, `Telerik.Web.UI.dll`, `Telerik.Web.UI.Skins.dll`

   Telerik UI for ASP.NET AJAX is commercial software; you need your own licence. The two `*Fakes*` assemblies are Visual Studio Fakes artefacts and nothing in this repository calls them.
2. **NuGet.** Restore packages (`EntityFramework 5.0.0`).
3. **Database.** Create a SQL Server database named `CostPrice` (for example with *Generate Database from Model* on `CostPrice/Models/Model1.edmx`) and fill the `Country` table, which the registration page lists.
4. **Configuration.** In `CostPrice/Web.config` replace the placeholders:

   | Setting | Section | Purpose |
   |---|---|---|
   | `CostPriceEntities` | `connectionStrings` | Entity Framework context |
   | `ConnectionString` | `connectionStrings` | ADO.NET inserts and the `SqlDataSource` controls |
   | `MaxMindUserId`, `MaxMindLicenseKey` | `appSettings` | GeoIP2 web service account |
   | `SmscLogin`, `SmscPassword` | `appSettings` | SMSC.ru account |

   Never commit real values. Keep them out of version control, for example in a `configSource` file that is listed in `.gitignore`, or in a Web.config transform.
5. **Run** with IIS Express (F5 in Visual Studio).

## Screenshots

<!-- TODO: add screenshots, then uncomment the two lines below.
![Registration form](docs/screenshots/registration.png)
![User management](docs/screenshots/user-management.png)
-->

## What I learned

- **Web Forms page lifecycle.** `Page_Load` runs on every postback, so one-time work (a GeoIP lookup, binding a list) needs an `IsPostBack` guard, or it overwrites what the visitor just chose.
- **ViewState vs. Session.** ViewState carries control state across postbacks of one page. State that must survive between the steps of a flow belongs in `Session`, never in `static` fields, which are shared by every visitor.
- **Entity Framework database-first.** An EDMX plus T4 templates generates the entity classes and the `DbContext`; generated files are not edited by hand.
- **Parameterised ADO.NET.** `SqlCommand` with parameters for inserts, and `SqlConnection`, `SqlCommand`, readers and EF contexts wrapped in `using` so they are released even when an exception is thrown.
- **Third-party control suites.** Telerik RadGrid, RadNotification and RadMaskedTextBox speed up the UI, but their binaries are licensed and cannot be committed.
- **External APIs.** Calling a GeoIP web service and an SMS gateway from page code, and keeping their credentials in configuration instead of source.
- **Refactoring.** Small commits that each keep the project compiling; named constants instead of repeated literals; shared logic (password hashing, user types, database connections) moved out of the pages.

## Known issues

Left as they were in 2015 on purpose:

- Passwords are stored as unsalted MD5 hashes (`Credentials.HashPassword`). Changing the format would break existing accounts and the (missing) login page.
- Some markup handlers have no code: `UserControl.aspx` wires `RadGrid1_NeedDataSource1`, `RadGrid1_ItemDataBound`, `RadGrid1_UpdateCommand` and `RadGrid1_DeleteCommand`, and `Reset.aspx` wires `btnSubmit_Click`. ASP.NET will not compile those two pages until the handlers exist.
- The pages and assets listed under *About this repository* are missing.
- `Application["OnlineVisitors"]` is read by the registration page but never set, so the "Online" counter is always empty.
- The admin "Add user" form always creates the user with country `AE`; its country combo box is ignored.
- There is no error handling around the GeoIP, SMS and database calls; a failure surfaces as an unhandled exception.
- The password textbox is disabled after the SMS step but still keeps its value in ViewState.
- A typo in a user-visible message ("conact") is kept, because user-visible strings were not changed.
