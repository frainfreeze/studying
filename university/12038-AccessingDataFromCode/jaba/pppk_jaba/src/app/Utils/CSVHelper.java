
package app.Utils;

import app.Models.Vozac;
import app.Models.Vozilo;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;


public class CSVHelper {
    private static final DBHelper db = DBHelper.getInstance();
    public int importVozila(String filename){
        String line;
        String cvsSplitBy = ",";
        int broj = 0;
        try (BufferedReader br = new BufferedReader(new FileReader(filename))) {
            while ((line = br.readLine()) != null) {
                String[] data = line.split(cvsSplitBy);
                int tip_vozila_id = Integer.parseInt(data[0]);
                String marka = data[1];
                int godina_proizvodnje = Integer.parseInt(data[2]);
                double pocetni_km = Double.parseDouble(data[3]);
                double trenutni_km = Double.parseDouble(data[4]);
                
                
                Vozilo v = new Vozilo(tip_vozila_id,marka,godina_proizvodnje,pocetni_km,trenutni_km);
                db.InsertVozilo(v);
                ++broj;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }finally{
            return broj;
        }
    }
    
    public int importVozaci(String filename){
        String line;
        String cvsSplitBy = ",";
        int broj = 0;
        try (BufferedReader br = new BufferedReader(new FileReader(filename))) {
            while ((line = br.readLine()) != null) {
                String[] data = line.split(cvsSplitBy);
                String ime =           data[0];
                String prezime =       data[1];
                String broj_mobitela = data[2];
                String broj_vozacke =  data[3];
                
                Vozac v = new Vozac(ime,prezime,broj_mobitela,broj_vozacke);
                db.InsertVozac(v);
                ++broj;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }finally{
            return broj;
        }
    }
}
