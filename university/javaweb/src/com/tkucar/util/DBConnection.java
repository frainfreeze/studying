package com.tkucar.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public Connection checkUser() {

        try {
//            Connection con;
//            //loading drivers for mysql
//            Class.forName("com.mysql.jdbc.Driver");
//
//            //creating connection with the database
//            con=DriverManager.getConnection
//                    ("jdbc:mysql://localhost:3306/user","root","");
            Connection conn = null;
            Class.forName("org.sqlite.JDBC");
            String url = "jdbc:sqlite:/home/frain/git/studying/university/javaweb/redrivers.db";
            // create a connection to the database
            conn = DriverManager.getConnection(url);

            return conn;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }
}
