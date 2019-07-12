<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Admin._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>DiabPro Admin Dashboard</h1>
        <p class="lead">
            Language:&nbsp;
            <asp:RadioButton ID="RadioButton1" runat="server" Text="HR" />
            <asp:RadioButton ID="RadioButton2" runat="server" Text="ENG" />
        </p>
    </div>

    <div class="container">
        <p class="lead">
            Built in tables:
        </p>
        <div class="row">
            <div class="col-md-4">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="IDGender" DataSourceID="ds1">
                    <Columns>
                        <asp:BoundField DataField="IDGender" HeaderText="IDGender" InsertVisible="False" ReadOnly="True" SortExpression="IDGender" />
                        <asp:BoundField DataField="Desc" HeaderText="Desc" SortExpression="Desc" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="ds1" runat="server" ConnectionString="<%$ ConnectionStrings:db %>" SelectCommand="SELECT * FROM Gender ORDER BY IDGender ASC"></asp:SqlDataSource>
            </div>
            <div class="col-md-4">
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="IDDiabetesType" DataSourceID="ds2">
                    <Columns>
                        <asp:BoundField DataField="IDDiabetesType" HeaderText="IDDiabetesType" InsertVisible="False" ReadOnly="True" SortExpression="IDDiabetesType" />
                        <asp:BoundField DataField="Desc" HeaderText="Desc" SortExpression="Desc" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="ds2" runat="server" ConnectionString="<%$ ConnectionStrings:db %>" SelectCommand="SELECT * FROM DiabetesType ORDER BY IDDiabetesType ASC"></asp:SqlDataSource>
            </div>
            <div class="col-md-4">
                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataKeyNames="IDActivityLevel" DataSourceID="ds3">
                    <Columns>
                        <asp:BoundField DataField="IDActivityLevel" HeaderText="IDActivityLevel" InsertVisible="False" ReadOnly="True" SortExpression="IDActivityLevel  " />
                        <asp:BoundField DataField="Desc" HeaderText="Desc" SortExpression="Desc" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="ds3" runat="server" ConnectionString="<%$ ConnectionStrings:db %>" SelectCommand="SELECT * FROM ActivityLevel ORDER BY IDActivityLevel ASC"></asp:SqlDataSource>
            </div>
        </div>
    </div>

</asp:Content>
