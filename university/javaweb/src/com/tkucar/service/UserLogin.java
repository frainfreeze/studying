package com.tkucar.service;

import com.tkucar.util.DBConnection;
import com.tkucar.util.DBHelper;
import com.tkucar.util.DBLogger;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserLogin extends HttpServlet {
    DBConnection dBConnection;
    Connection con;
    DBLogger logger = new DBLogger();
    DBHelper dbhelper = new DBHelper();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        HttpSession session = request.getSession(true);

        try {
            dBConnection = new DBConnection();
            con = dBConnection.getConn();

            if (checkUser(con, email, pass)) {
                logger.accessLog(dbhelper.getUserId(email), (String)request.getRemoteAddr(), "User logged in successfully");
                if (email == "tom@tom.com") {
                    session.setAttribute("admin", true);
                    System.out.println("Admin here!");
                }
                System.out.println(email);
                session.setAttribute("email", email);
                session.setAttribute("authenticated", true);
                session.setAttribute("admin", true);

                RequestDispatcher rs = request.getRequestDispatcher("/app/user.jsp");
                rs.forward(request, response);
            } else {
                logger.accessLog("1", (String)request.getRemoteAddr(), "Failed login. Email: " + email + " Password: " + pass);
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
        Boolean nxt = rs.next();
        return nxt;
    }
}
