package com.tkucar.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DBLogger {
    final DBConnection dBConnection = new DBConnection();
    final Connection con = dBConnection.getConn();

    public DBLogger() throws SQLException {
    }

    public void accessLog(String user_id, String ip, String txt) {
        try {
            PreparedStatement ps = con.prepareStatement(
                    "insert into access_log (user_id, ip, txt) values (?, ?, ?)");

            ps.setInt(1, Integer.parseInt(user_id));
            ps.setString(2, ip);
            ps.setString(3, txt);

            int i = ps.executeUpdate();
        } catch (Exception e2) {
            e2.printStackTrace();
        }
    }
}
