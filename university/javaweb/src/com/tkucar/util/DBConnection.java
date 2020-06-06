package com.tkucar.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    final String url = "jdbc:sqlite:/home/frain/git/studying/university/javaweb/redrivers.db";

    public Connection getConn() {

        try {
//            Connection con;
//            //loading drivers for mysql
//            Class.forName("com.mysql.jdbc.Driver");
//
//            //creating connection with the database
//            con=DriverManager.getConnection
//                    ("jdbc:mysql://localhost:3306/user","root","");
            Connection conn;
            Class.forName("org.sqlite.JDBC");
            // create a connection to the database
            conn = DriverManager.getConnection(url);

            return conn;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }
}
