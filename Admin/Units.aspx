<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Units.aspx.cs" Inherits="Admin.Units" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="dvGrid" style="padding: 10px; width: 450px">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="IDUnit,Desc,Enabled"
                    OnRowDataBound="OnRowDataBound"
                    OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit"
                    PageSize="10" AllowPaging="true" OnPageIndexChanging="OnPaging"
                    OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting"
                    EmptyDataText="No records has been added." Width="450">
                    <Columns>
                        <asp:TemplateField HeaderText="Desc" ItemStyle-Width="150">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("Desc") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDesc" runat="server" Text='<%# Eval("Desc") %>' Width="140"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Enabled" ItemStyle-Width="150">
                            <ItemTemplate>
                                <asp:Label ID="lblCountry" runat="server" Text='<%# Eval("Enabled") %>'></asp:Label>
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
                        <td style="width: 150px">New Unit:<br />
                            <asp:TextBox ID="txtDesc" runat="server" Width="140" />
                        </td>
                        <td style="width: 150px">Enabled (yes 1, no 0):<br />
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
