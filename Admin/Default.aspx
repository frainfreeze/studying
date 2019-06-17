﻿<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Admin._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>DiabPro Admin Dashboard</h1>
        <p class="lead">Users</p>
        <p class="lead">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="IDUser" DataSourceID="UsersSource" AllowPaging="True" AllowSorting="True">
                <Columns>
                    <asp:BoundField DataField="IDUser" HeaderText="IDUser" InsertVisible="False" ReadOnly="True" SortExpression="IDUser" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname" />
                    <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    <asp:BoundField DataField="DOB" HeaderText="DOB" SortExpression="DOB" />
                    <asp:BoundField DataField="Weight" HeaderText="Weight" SortExpression="Weight" />
                    <asp:BoundField DataField="Height" HeaderText="Height" SortExpression="Height" />
                    <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                    <asp:BoundField DataField="Tip Dijabetesa" HeaderText="Tip Dijabetesa" SortExpression="Tip Dijabetesa" />
                    <asp:BoundField DataField="Raz.Fiz. aktivnosti" HeaderText="Raz.Fiz. aktivnosti" SortExpression="Raz.Fiz. aktivnosti" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="UsersSource" runat="server" ConnectionString="<%$ ConnectionStrings:UsersSourceConn %>" SelectCommand="GetUsersForCSV" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </p>
        <p class="lead">
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Download users as CSV file" />
&nbsp;</p>
    </div>
   
</asp:Content>
