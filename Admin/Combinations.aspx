<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Combinations.aspx.cs" Inherits="Admin.Combinations" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <br>
        <p>
            <asp:Label ID="Label1" runat="server" Text="Number of meals   "></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server" style="margin-left: 40" Width="192px"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Apply" />
        <p>
            <asp:Label ID="Label2" runat="server" Text="Starting on:  "></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        <p>
            <asp:Label ID="Label3" runat="server" Text="Valid until:   "></asp:Label>
            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
        </p>
    </div>
    <div>

        <div id="dvGrid" style="padding: 10px; width: 450px">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="MealName,Carbs,Fat,Protein,Total"
                        OnRowDataBound="OnRowDataBound"
                        OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit"
                        PageSize="10" AllowPaging="true" OnPageIndexChanging="OnPaging"
                        OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting"
                        EmptyDataText="No records has been added." Width="450">
                        <Columns>
                            <asp:TemplateField HeaderText="MealName" ItemStyle-Width="150">
                                <ItemTemplate>
                                    <asp:Label ID="lblMealName" runat="server" Text='<%# Eval("MealName") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMealName" runat="server" Text='<%# Eval("MealName") %>' Width="140"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Carbs" ItemStyle-Width="150">
                                <ItemTemplate>
                                    <asp:Label ID="lblCarbs" runat="server" Text='<%# Eval("Carbs") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtCarbs" runat="server" Text='<%# Eval("Carbs") %>' Width="140"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Fat" ItemStyle-Width="150">
                                <ItemTemplate>
                                    <asp:Label ID="lblFat" runat="server" Text='<%# Eval("Fat") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtFat" runat="server" Text='<%# Eval("Fat") %>' Width="140"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Protein" ItemStyle-Width="150">
                                <ItemTemplate>
                                    <asp:Label ID="lblProtein" runat="server" Text='<%# Eval("Protein") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtProtein" runat="server" Text='<%# Eval("Protein") %>' Width="140"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Total" ItemStyle-Width="150">
                                <ItemTemplate>
                                    <asp:Label ID="lblTotal" runat="server" Text='<%# Eval("Total") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTotal" runat="server" Text='<%# Eval("Total") %>' Width="140"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true"
                                ItemStyle-Width="150" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

    </div>
    
</asp:Content>
