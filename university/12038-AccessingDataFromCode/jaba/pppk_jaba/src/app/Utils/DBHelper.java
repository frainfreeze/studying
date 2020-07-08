package app.Utils;


import app.Models.Ruta;
import app.Models.Vozac;
import app.Models.Vozilo;

import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


public class DBHelper {
    private static final String DEFAULT_JAVA_CLASS = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private final String PROJECT_DIRECTORY = System.getProperty("user.dir");
    private static final String URL_FORMAT = "jdbc:sqlserver://DESKTOP-RTVO6TF\\SQLEXPRESS;databaseName=PPPK_DATABASE;user=tom;password=SQL";
    private static DBHelper instance = null;
    private static Connection connection = null;

    private DBHelper() throws ClassNotFoundException{
        Class.forName(DBHelper.DEFAULT_JAVA_CLASS);
    }

    public static DBHelper getInstance(){
        if(instance == null){
            try {
                instance = new DBHelper();
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(DBHelper.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return instance;
    }

    private void OpenConnection(){
        try {
            connection = DriverManager.getConnection(URL_FORMAT);
        } catch (SQLException e) {
            CloseConnection();
            Logger.getLogger(DBHelper.class.getName()).log(Level.SEVERE, null, e);
        }

    }

    private void CloseConnection(){
        try{
            connection.close();
        }catch(SQLException e){
            Logger.getLogger(DBHelper.class.getName()).log(Level.SEVERE, null, e);
        }

    }


    public void InsertVozac(Vozac v){
        CallableStatement cstmt;
        try{
            OpenConnection();
            cstmt = connection.prepareCall("{call insert_vozac(?,?,?,?)}");
            cstmt.setString("ime", v.getIme());
            cstmt.setString("prezime", v.getPrezime());
            cstmt.setString("broj_mobitela", v.getBroj_mobitela());
            cstmt.setString("broj_vozacke", v.getBroj_vozacke());
            cstmt.execute();
        }catch(Exception ex){
            ex.printStackTrace();
        }finally{
            CloseConnection();
        }
    }

    public void InsertVozilo(Vozilo v){
        CallableStatement cstmt;
        try{
            OpenConnection();
            cstmt = connection.prepareCall("{call insert_vozilo(?,?,?,?,?)}");
            cstmt.setString("marka", v.getMarka());
            cstmt.setInt("tip_vozila_id", v.getTip_vozila_id());
            cstmt.setDouble("pocetni_km", v.getPocetni_km());
            cstmt.setDouble("trenutni_km", v.getTrenutni_km());
            cstmt.setInt("godina_proizvodnje", v.getGodina_proizvodnje());
            cstmt.execute();
        }catch(SQLException ex){
            ex.printStackTrace();
        }finally{
            CloseConnection();
        }
    }

    public void InsertRuta(Ruta r) {
        CallableStatement cstmt;
        try{
            OpenConnection();
            cstmt = connection.prepareCall("{call insert_ruta(?,?,?,?,?,?,?)}");
            cstmt.setInt("putni_nalog_id", r.getPutni_nalog_id());
            cstmt.setDouble("x_koordinata_a", r.getX_koordinata_a());
            cstmt.setDouble("y_koordinata_a", r.getY_koordinata_a());
            cstmt.setDouble("x_koordinata_b", r.getX_koordinata_b());
            cstmt.setDouble("y_koordinata_b", r.getY_koordinata_b());
            cstmt.setDouble("km_izmedu_a_b", r.getKm_izmedu_a_b());
            cstmt.setDouble("prosjecna_brzina", r.getProsjecna_brzina());
            cstmt.execute();
        }catch (SQLException ex){
            ex.printStackTrace();
        }finally{
            CloseConnection();
        }

    }

    public ArrayList<Ruta> SelectRute(int putni_nalog_id) {
        ArrayList<Ruta> l = new ArrayList<>();
        ResultSet rs;
        Statement statement;
        try {
            OpenConnection();
            statement = connection.createStatement();
            rs = statement.executeQuery("SELECT * FROM RUTA WHERE putni_nalog_id=" + putni_nalog_id);
            while(rs.next()){
                Ruta r = new Ruta(
                        rs.getInt("id"),
                        rs.getInt("putni_nalog_id"),
                        rs.getDouble("x_koordinata_a"),
                        rs.getDouble("y_koordinata_a"),
                        rs.getDouble("x_koordinata_b"),
                        rs.getDouble("y_koordinata_b"),
                        rs.getDouble("km_izmedu_a_b"),
                        rs.getDouble("prosjecna_brzina")
                );
                l.add(r);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBHelper.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            CloseConnection();
        }
        return l;
    }
}
