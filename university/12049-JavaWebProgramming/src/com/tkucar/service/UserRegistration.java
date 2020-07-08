package com.tkucar.service;

import com.tkucar.util.DBConnection;
import com.tkucar.util.DBHelper;
import com.tkucar.util.DBLogger;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UserRegistration extends HttpServlet {
    DBConnection dBConnection;
    Connection con;
    final DBLogger logger = new DBLogger();
    final DBHelper dbhelper = new DBHelper();

    public UserRegistration() throws SQLException {
    }

    @Override
    public void init() {
        dBConnection = new DBConnection();
        try {
            con = dBConnection.getConn();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();


        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        System.out.println("Username: " + email + " Pass: " + pass);

        try {

            PreparedStatement ps = con.prepareStatement(
                    "insert into usr (email,pwd) values(?,?)");


            ps.setString(1, email);
            ps.setString(2, pass);


            int i = ps.executeUpdate();
            if (i > 0) {
                out.print("You are successfully registered...");
                request.getSession().setAttribute("loggedInUser", email);
                RequestDispatcher rs = request.getRequestDispatcher("app/user.jsp");
                rs.forward(request, response);
                logger.accessLog(dbhelper.getUserId(email), request.getRemoteAddr(), "User successfully registered.");
            }
            con.close();
        } catch (Exception e2) {
            e2.printStackTrace();
        }

        out.close();
    }
}
