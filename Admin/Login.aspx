<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Admin.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin - Login page</title>
    <style>
        body{
          background:#161616;
          color:#888;
          font-family: 'Ubuntu Mono', sans-serif;
          text-transform:uppercase;
        }
 
        .box{
          width:90%;
          max-width:450px;
          height:auto;
          margin:0 auto;
          margin-top:100px;
          background:#222;
          border-radius:7px;
          box-shadow: 0px 3px 10px 1px rgba(0, 0, 0, 0.9);
        }
 
        .content{
          width:85%;
          height:auto;
          position:;
          margin:0 auto;
          padding:30px 0px;
          background:;
          text-align:center;
        }
 
        .content h1{
          font-size: 24px;
          font-weight:400;
          color:#FFBF00;
          letter-spacing:0.125em;
          text-align:center;
        }
 
        .field{
          width:100%;
          margin:10px auto;
          padding:10px;
          background:#2c2c2c;
          border:none;
          box-shadow: 0px 1px 0px 0px #111;
          border-radius:3px;
          outline:none;
          color:#FFBF00;
          font-weight:700;
          letter-spacing:0.125em;
          text-align:center;
          text-transform:uppercase;
        }
 
 
        ::-webkit-input-placeholder{ /* WebKit browsers */
          color:#5A5A5A;
        }
        :-moz-placeholder{ /* Mozilla Firefox 4 to 18 */
          color:#5A5A5A;
        }
        ::-moz-placeholder{ /* Mozilla Firefox 19+ */
          color:#5A5A5A;
        }
        :-ms-input-placeholder{ /* Internet Explorer 10+ */
          color:#5A5A5A;
        }
 
        .btn{
          width:100%;
          margin:10px auto;
          padding:10px;
          background:#161616;
          border:none;
          box-shadow: 0px 1px 0px 0px #111;
          border-radius:3px;
          outline:none;
          color:#FFBF00;
          font-weight:700;
          letter-spacing:0.125em;
          text-align:center;
          text-transform:uppercase;
        }
 
        .btn:hover{
          background:#FFBF00;
          color:#333;
        }
 
        .btn:active{
          background:#FACC2E;
          color:#333;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Login ID="Login1" runat="server" Style="width: 100%;" OnAuthenticate="ValidateUser">
                <LayoutTemplate>
                    <div class="box">
                        <div class="content">
                            <h1>Authentication Required</h1>
                            <asp:TextBox class="field" placeholder="Username" ID="UserName" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                            <br>
                            <asp:TextBox class="field" placeholder="Password" ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                            <br>
                            <asp:Button class="btn" ID="LoginButton" runat="server" CommandName="Login" Text="Log In" ValidationGroup="Login1"></asp:Button>
                            <br>
                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                        </div>
                    </div>
                </LayoutTemplate>
            </asp:Login>
        </div>
    </form>
</body>
</html>
