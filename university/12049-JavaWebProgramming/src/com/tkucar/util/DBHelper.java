package com.tkucar.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBHelper {
    public DBHelper() throws SQLException {
    }

    public String getUserId(String email) throws SQLException {
        DBConnection dBConnection = new DBConnection();
        Connection con = dBConnection.getConn();
        PreparedStatement ps = con.prepareStatement
                ("select id from usr where email=?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        String id = "";
        if (rs.next())
            id = rs.getString("id");
        con.close();
        return id;
    }
}
