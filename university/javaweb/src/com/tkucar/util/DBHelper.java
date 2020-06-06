package com.tkucar.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBHelper {
    final DBConnection dBConnection = new DBConnection();
    final Connection con = dBConnection.getConn();

    public String getUserId(String email) throws SQLException {
        PreparedStatement ps = con.prepareStatement
                ("select id from user where email=?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        String id = rs.getString("id");
        con.close();
        return id;
    }
}
