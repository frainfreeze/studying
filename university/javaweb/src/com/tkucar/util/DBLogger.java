package com.tkucar.util;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class DBLogger {
    DBConnection dBConnection = new DBConnection();
    Connection con = dBConnection.getConn();

    public void accessLog(String user_id, String ip, String txt) {
        try {
            PreparedStatement ps = con.prepareStatement(
                    "insert into access_log (user_id, ip, txt) values (?, ?, ?)");

            ps.setString(1, user_id);
            ps.setString(2, ip);
            ps.setString(3, txt);

            int i = ps.executeUpdate();
            con.close();
        } catch (Exception e2) {
            e2.printStackTrace();
        }
    }
}
