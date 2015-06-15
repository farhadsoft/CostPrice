<%@ Page Title="User Control - CostPrice.today" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="UserControl.aspx.cs" Inherits="MobileCenter.UserControl" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="cphContent" runat="server">
    <!-- START Page content-->
    <section class="main-content">
        <form runat="server">
            <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
            <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="WebBlue" />
            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
            <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="RadGrid1">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                </AjaxSettings>
            </telerik:RadAjaxManager>
            <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" DecorationZoneID="demo" EnableRoundedCorners="false" DecoratedControls="All" />
            <h1>User Control</h1>
            <div id="addUserPanel" runat="server" Visible="False">
                <div class="panel-body">
                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" />
                    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel2">
                        <fieldset>
                            <div class="col-md-4">
                                <telerik:RadTextBox ID="rtbName" runat="server" Label="Name" Width="300"></telerik:RadTextBox>
                                <telerik:RadTextBox ID="rtbSurname" runat="server" Label="Surname" Width="300"></telerik:RadTextBox>
                                <telerik:RadTextBox ID="rtbEmail" runat="server" Label="Email" Width="300"></telerik:RadTextBox>
                                <telerik:RadTextBox ID="rtbPassword" runat="server" Label="Password" Width="300"></telerik:RadTextBox>
                                <telerik:RadTextBox ID="rtbMobile1" runat="server" Label="Mobile Phone:" Width="300"></telerik:RadTextBox>
                                <telerik:RadComboBox ID="rcbCountry" runat="server" Label="Country" Width="245px" DataSourceID="GetCountryList" DataTextField="nicename" DataValueField="iso"></telerik:RadComboBox>
                                <asp:SqlDataSource ID="GetCountryList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [nicename], [iso] FROM [Country]"></asp:SqlDataSource>
                            </div>
                        </fieldset>
                    </telerik:RadAjaxPanel>
                </div>
            </div>
            <fieldset>
                <div class="col-md-4">
                    <telerik:RadButton ID="rbtnAddUser" runat="server" Text="Add User" Width="100" OnClick="rbtnAddUser_Click"></telerik:RadButton>
                </div>
            </fieldset>
            <telerik:RadGrid ID="RadGrid1" runat="server"    OnItemDataBound="RadGrid1_ItemDataBound" OnDeleteCommand="RadGrid1_DeleteCommand" OnUpdateCommand="RadGrid1_UpdateCommand" AllowPaging="True" AllowSorting="True"  OnNeedDataSource="RadGrid1_NeedDataSource1" 
                AllowAutomaticUpdates="False" AllowAutomaticDeletes="False" AllowFilteringByColumn="True" OnItemCreated="RadGrid1_ItemCreated"
                OnItemInserted="RadGrid1_ItemInserted" OnPreRender="RadGrid1_PreRender" Culture="ru-RU" GroupPanelPosition="Top">
                <PagerStyle Mode="NextPrevAndNumeric" Position="Bottom" AlwaysVisible="True" />
                <MasterTableView AutoGenerateColumns="False" DataKeyNames="id"   AllowMultiColumnSorting="True" EditMode="InPlace">
                    <Columns>
                            <telerik:GridBoundColumn DataField="isred"   SortExpression="isred" UniqueName="isred" Display="False"   >
                                <ColumnValidationSettings>
                                    <ModelErrorMessage Text="" />
                                </ColumnValidationSettings>
                            </telerik:GridBoundColumn>     

                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" ReadOnly="True" SortExpression="Id" UniqueName="Id" Visible="False">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="email" FilterControlAltText="Filter email column" HeaderText="Email" SortExpression="email" UniqueName="email" ReadOnly="True" ShowFilterIcon="False" AutoPostBackOnFilter="True" CurrentFilterFunction="Contains" FilterControlWidth="98%">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="company"  FilterControlAltText="Filter company column" HeaderText="Company Name" SortExpression="company" UniqueName="company" ShowFilterIcon="False" AutoPostBackOnFilter="True" CurrentFilterFunction="Contains" FilterControlWidth="98%">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="mobileNum1" FilterControlAltText="Filter mobileNum1 column" HeaderText="Phone Number" SortExpression="mobileNum1" UniqueName="mobileNum1" ReadOnly="True" ShowFilterIcon="False" AutoPostBackOnFilter="True" CurrentFilterFunction="Contains" FilterControlWidth="98%">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="userType" DataType="System.Int32" FilterControlAltText="Filter userType column" HeaderText="User Type" SortExpression="userType" UniqueName="userType" Visible="False" ReadOnly="True" ShowFilterIcon="False" AutoPostBackOnFilter="True" CurrentFilterFunction="Contains">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridCheckBoxColumn DataField="enable" DataType="System.Boolean" FilterControlAltText="Filter enable column" AllowFiltering="False" HeaderText="Enable" SortExpression="enable" UniqueName="enable">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridTemplateColumn DataField="UsersType" FilterControlAltText="Filter UsersType column" HeaderText="Users Type" SortExpression="UsersType" UniqueName="TypeName" ShowFilterIcon="False" AutoPostBackOnFilter="True" CurrentFilterFunction="Contains">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlUsersType" runat="server" SelectedValue='<%# Bind("userType") %>' DataSourceID="GetUserType" DataTextField="TypeName" DataValueField="TypeId"></asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="UsersTypeLabel" runat="server" Text='<%# Eval("UsersType") %>'></asp:Label>
                            </ItemTemplate>
                            <FilterTemplate>
                                <telerik:RadComboBox ID="cbBrandList" DataSourceID="GetUserType" DataTextField="TypeName"
                                    DataValueField="TypeName" RenderMode="Auto" Height="200px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("TypeName").CurrentFilterValue %>'
                                    runat="server" OnClientSelectedIndexChanged="TitleIndexChanged">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="All" />
                                    </Items>
                                </telerik:RadComboBox>
                                <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                                    <script type="text/javascript">
                                        function TitleIndexChanged(sender, args) {
                                            var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                            tableView.filter("TypeName", args.get_item().get_value(), "EqualTo");
                                        }
                                    </script>
                                </telerik:RadScriptBlock>
                            </FilterTemplate>
                        </telerik:GridTemplateColumn>
                           <telerik:GridBoundColumn DataField="regdate" DataType="System.DateTime"  DataFormatString="{0:dd.MM.yy}"  FilterControlAltText="Filter Regdate column" HeaderText="Registrated Date" SortExpression="regdate" AllowFiltering="False" UniqueName="regdate" Visible="True" ReadOnly="True" ShowFilterIcon="False" AutoPostBackOnFilter="True" CurrentFilterFunction="Contains">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                          <telerik:GridBoundColumn DataField="lotit"  Display="False" FilterControlAltText="Filter latitude  column" HeaderText="Latitude "  UniqueName="lotit"   ShowFilterIcon="False"   AllowFiltering="False">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="longit"  Display="False" FilterControlAltText="Filter longitude  column" HeaderText="Longitude "  UniqueName="longit"   ShowFilterIcon="False"   AllowFiltering="False">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                       
                            <telerik:GridTemplateColumn AutoPostBackOnFilter="True"   FilterControlAltText="Filter company column" FilterControlWidth="80%" HeaderText="Company" ShowFilterIcon="False" SortExpression="company" UniqueName="PriceList"  AllowFiltering="False" CurrentFilterFunction="Custom">
                                <HeaderStyle HorizontalAlign="Center" />
     
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink1" Visible="<%#getVisibility()%>" runat="server" Text='Edit price list'  NavigateUrl='<%# Bind("Id", "MyStorage.aspx?cId={0}") %>'   Target="_blank"></asp:HyperLink>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn AutoPostBackOnFilter="True"   FilterControlAltText="Filter company column" FilterControlWidth="80%" HeaderText="Company page" ShowFilterIcon="False" SortExpression="company" UniqueName="CompanyPage"  AllowFiltering="False" CurrentFilterFunction="Custom">
                                <HeaderStyle HorizontalAlign="Center" />
     
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink2" Visible="<%#getVisibility()%>" runat="server" Text='Edit company page'  NavigateUrl='<%# Bind("Id", "CompanyDetail.aspx?pid={0}") %>'   Target="_blank"></asp:HyperLink>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                         <telerik:GridTemplateColumn AutoPostBackOnFilter="True"   FilterControlAltText="Filter company column" FilterControlWidth="80%" HeaderText="Company page" ShowFilterIcon="False" SortExpression="company" UniqueName="CompanyPage"  AllowFiltering="False" CurrentFilterFunction="Custom">
                                <HeaderStyle HorizontalAlign="Center" />
     
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink3" Visible="<%#getVisibility()%>" runat="server" Text='Edit user page'  NavigateUrl='<%# Bind("Id", "Default.aspx?cId={0}") %>'   Target="_blank"></asp:HyperLink>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" Text="Delete" />
                    </Columns>
                    <EditFormSettings>
                        <EditColumn ButtonType="ImageButton" />
                    </EditFormSettings>
                    <PagerStyle AlwaysVisible="True"></PagerStyle>
                </MasterTableView>
            </telerik:RadGrid>
            <asp:SqlDataSource ID="GetUsersList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                 UpdateCommand="UPDATE Users SET company = @company, userType = @userType, enable = @enable,lotit=@lotit,longit=@longit  WHERE (Id = @id)" DeleteCommand="DELETE FROM Users WHERE (Id = @id)">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="company" Type="String" />
                    <asp:Parameter Name="userType" Type="String" />
                         <asp:Parameter Name="lotit" Type="String" />
                          <asp:Parameter Name="longit" Type="String" />
                    <asp:Parameter Name="enable" Type="String" />
                    <asp:Parameter Name="id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="GetUserType" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [TypeId], [TypeName] FROM [UserType]"></asp:SqlDataSource>
        </form>
    </section>
    <!-- END Page content-->
</asp:Content>
