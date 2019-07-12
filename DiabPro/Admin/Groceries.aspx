<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Groceries.aspx.cs" Inherits="Admin.Groceries" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="dvGrid" style="padding: 10px">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="IDGrocery,Name,kJ,kcal,Grocery Type,Unit,Quantity,Enabled"
                    OnRowDataBound="OnRowDataBound"
                    OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit"
                    PageSize="10" AllowPaging="true" OnPageIndexChanging="OnPaging"
                    OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting"
                    EmptyDataText="No records has been added.">
                    <Columns>
                        <asp:TemplateField HeaderText="Name" ItemStyle-Width="150">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName" runat="server" Text='<%# Eval("Name") %>' Width="140"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="kJ" ItemStyle-Width="150">
                            <ItemTemplate>
                                <asp:Label ID="lblKJ" runat="server" Text='<%# Eval("kJ") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtKJ" runat="server" Text='<%# Eval("kJ") %>' Width="140"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="kcal" ItemStyle-Width="150">
                            <ItemTemplate>
                                <asp:Label ID="lblKcal" runat="server" Text='<%# Eval("kcal") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtKcal" runat="server" Text='<%# Eval("kcal") %>' Width="140"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Grocery Type" ItemStyle-Width="150">
                            <ItemTemplate>
                                <asp:Label ID="lblGroceryType" runat="server" Text='<%# Eval("Grocery Type") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtGroceryType" runat="server" Text='<%# Eval("Grocery Type") %>' Width="140"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Unit" ItemStyle-Width="150">
                            <ItemTemplate>
                                <asp:Label ID="lblUnit" runat="server" Text='<%# Eval("Unit") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUnit" runat="server" Text='<%# Eval("Unit") %>' Width="140"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Quantity" ItemStyle-Width="150">
                            <ItemTemplate>
                                <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("Quantity") %>' Width="140"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Enabled" ItemStyle-Width="150">
                            <ItemTemplate>
                                <asp:Label ID="lblEnabled" runat="server" Text='<%# Eval("Enabled") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEnabled" runat="server" Text='<%# Eval("Enabled") %>' Width="140"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true"
                            ItemStyle-Width="150" />
                    </Columns>
                </asp:GridView>

                <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
                    <tr>
                        <td style="width: 150px">New Grocery:<br />
                            <asp:TextBox ID="txtName" runat="server" Width="140" />
                        </td>

                        <td style="width: 150px">kJ<br />
                            <asp:TextBox ID="txtKJ" runat="server" Width="140" />
                        </td>

                        <td style="width: 150px">kcal:<br />
                            <asp:TextBox ID="txtKcal" runat="server" Width="140" />
                        </td>

                        <td style="width: 150px">Grocery Type:<br />
                            <asp:TextBox ID="txtGroceryType" runat="server" Width="140" />
                        </td>

                        <td style="width: 150px">Unit:<br />
                            <asp:TextBox ID="txtUnit" runat="server" Width="140" />
                        </td>

                        <td style="width: 150px">Quantity:<br />
                            <asp:TextBox ID="txtQuantity" runat="server" Width="140" />
                        </td>

                        <td style="width: 150px">Enabled:<br />
                            <asp:TextBox ID="txtEnabled" runat="server" Width="140" />
                        </td>

                        <td style="width: 150px">
                            <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="Insert" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>