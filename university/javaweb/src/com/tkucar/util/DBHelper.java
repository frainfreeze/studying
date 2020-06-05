package com.tkucar.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBHelper {
    DBConnection dBConnection;
    Connection con;

    public String getUserId(String email) throws SQLException {
        PreparedStatement ps = con.prepareStatement
                ("select id from user where email=?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        //return rs.toString();
        System.out.println(rs.toString());
        return "1;";
    }
}
