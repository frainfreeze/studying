<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>User page</title>
    <%@page import="com.tkucar.util.DBConnection" %>
    <%@ page import="java.sql.*" %>
    <%@ page import="jakarta.servlet.http.HttpSession" %>
    <%@ page import="java.util.Enumeration" %>
    <script type="text/javascript" charset="utf8"
            src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8"
            src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.js"></script>

    <script>
        $(document).ready(function () {
            $('#table_id').DataTable();
        });
    </script>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
</head>

<body>
<div class="table-responsive">
    <table id="table_id" class="display table table-striped table-sm">
        <thead>
        <tr>
            <th>User email</th>
            <th>Datetime</th>
            <th>Type of purchase</th>
            <th>Item</th>
            <th>Amount</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                DBConnection dBConnection = new DBConnection();
                Connection con = dBConnection.getConn();
                Statement st = con.createStatement();
                String email = (String)request.getSession().getAttribute("email");
                PreparedStatement pstmt = con.prepareStatement(
                        "select u.email as email, p.purchase_date as date, p.purchase_type as type, i.item as item, i.amount as amount from purchase as p " +
                                "    inner join item as i " +
                                "        on i.purchase_id = p.id" +
                                "    inner join user as u" +
                                "        on p.user_id = u.id" +
                                "    where u.email = ?"
                        );

                pstmt.setString(1, email);
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%=rs.getString("email") %>
            </td>
            <td><%=rs.getString("date") %>
            </td>
            <td><%=rs.getString("type") %>
            </td>
            <td><%=rs.getString("item") %>
            </td>
            <td><%=rs.getString("amount") %>
            </td>
        </tr>
        <%
                }
                st.close();
                con.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        %>
        </tbody>
    </table>
</div>
</body>

</html>