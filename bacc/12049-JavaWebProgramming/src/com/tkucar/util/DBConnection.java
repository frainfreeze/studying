package com.tkucar.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    //    final String url = "jdbc:sqlite:/home/frain/git/studying/university/javaweb/redrivers.db";
//
//    public Connection getConn() {
//        try {
//            Class.forName("org.sqlite.JDBC");
//            Connection conn = DriverManager.getConnection(url);
//            return conn;
//        } catch (SQLException | ClassNotFoundException e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
    String url = "jdbc:postgresql://localhost/jabaweb";

    public Connection getConn() throws SQLException {
        Connection con;

        try {
            Class.forName("org.postgresql.Driver");
        } catch (java.lang.ClassNotFoundException e) {
            System.err.print("ClassNotFoundException: ");
            System.err.println(e.getMessage());
        }

        con = DriverManager.getConnection(url, "postgres", "pwd");
        return con;
    }
}
