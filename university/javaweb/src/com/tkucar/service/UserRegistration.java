package com.tkucar.service;

import com.tkucar.util.DBConnection;
import com.tkucar.util.DBHelper;
import com.tkucar.util.DBLogger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class UserRegistration extends HttpServlet {
    DBConnection dBConnection;
    Connection con;
    DBLogger logger;
    DBHelper dbelper;

    @Override
    public void init() {
        dBConnection = new DBConnection();
        con = dBConnection.checkUser();
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();


        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        System.out.println("Username: " + email + " Pass: " + pass);

        try {

            PreparedStatement ps = con.prepareStatement(
                    "insert into user (email,pwd) values(?,?)");


            ps.setString(1, email);
            ps.setString(2, pass);


            int i = ps.executeUpdate();
            if (i > 0) {
                out.print("You are successfully registered...");
                //logger.accessLog(dbelper.getUserId(email), (String)request.getRemoteAddr(), "User successfully registered.");
            }
        } catch (Exception e2) {
            e2.printStackTrace();
        }

        out.close();
    }
}
