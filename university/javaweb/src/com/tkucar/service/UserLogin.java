package com.tkucar.service;

import com.tkucar.util.DBConnection;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserLogin extends HttpServlet {
    DBConnection dBConnection;
    Connection con;

    @Override
    public void init() {
        dBConnection = new DBConnection();
        con = dBConnection.checkUser();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        try {
            if (checkUser(con, email, pass)) {
                RequestDispatcher rs = request.getRequestDispatcher("Welcome");
                rs.forward(request, response);
            } else {
                out.println("Username or Password incorrect");
                RequestDispatcher rs = request.getRequestDispatcher("login.jsp");
                rs.include(request, response);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public boolean checkUser(Connection con, String email, String pass) throws SQLException {
        PreparedStatement ps = con.prepareStatement
                ("select * from user where email=? and pwd=?");
        ps.setString(1, email);
        ps.setString(2, pass);
        ResultSet rs = ps.executeQuery();
        return rs.next();
    }
}
