package app.Utils;

import app.Models.PutniNalog;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import javax.persistence.ParameterMode;
import javax.persistence.StoredProcedureQuery;
import java.io.IOException;
import java.nio.file.Paths;

public class PDFHelper {

    public void generatePutniNalogPdf(int id, String path, String fname) {
        Configuration cfg = createHibernateConfiguration();
        try (SessionFactory sessionFactory = cfg.buildSessionFactory();
             Session session = sessionFactory.openSession()) {
            session.beginTransaction();
            StoredProcedureQuery spq = session.createStoredProcedureCall("dohvati_putni_nalog");
            spq.registerStoredProcedureParameter("id", int.class, ParameterMode.IN);
            spq.setParameter("id", id);
            spq.execute();
            Object[] result = (Object[]) spq.getResultList().get(0);
            String datum_izrade = result[4].toString();
            String datum_pocetka = result[5].toString();
            String datum_zavrsetka = result[6].toString();
            String status = (String) result[7];
            String ime = (String) result[8];
            String prezime = (String) result[9];
            String marka = (String) result[10];
            String godina_proizvodnje = String.valueOf((int) result[11]);

            PutniNalog pn = new PutniNalog(datum_izrade, datum_pocetka, datum_zavrsetka, status, ime, prezime, marka, godina_proizvodnje);

            try (PDDocument doc = new PDDocument()) {

                PDPage myPage = new PDPage();
                doc.addPage(myPage);

                try (PDPageContentStream cont = new PDPageContentStream(doc, myPage)) {

                    cont.beginText();

                    cont.setFont(PDType1Font.TIMES_ROMAN, 12);
                    cont.setLeading(14.5f);

                    cont.newLineAtOffset(25, 700);
                    String line1 = "Datum izrade putnog naloga: " + pn.getDatum_izrade();
                    cont.showText(line1);

                    cont.newLine();

                    String line2 =  "Pocetak i kraj putnog naloga: " + pn.getDatum_pocetka() + " - " + pn.getDatum_zavrsetka();
                    cont.showText(line2);
                    cont.newLine();

                    String line3 = "Ime i prezime: " + pn.getIme() + ", " + pn.getPrezime();
                    cont.showText(line3);
                    cont.newLine();

                    String line4 = "Status: " + pn.getStatus();
                    cont.showText(line4);
                    cont.newLine();

                    cont.endText();
                }

                doc.save(Paths.get(path, fname).toString());
            } catch (IOException e) {
                e.printStackTrace();
            }

            session.getTransaction().commit();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    private Configuration createHibernateConfiguration() {
        String url = "jdbc:sqlserver://DESKTOP-RTVO6TF\\SQLEXPRESS;databaseName=PPPK_DATABASE";
        Configuration cfg = new Configuration()
                .setProperty("hibernate.connection.driver_class", "com.microsoft.sqlserver.jdbc.SQLServerDriver")
                .setProperty("hibernate.connection.url", url)
                .setProperty("hibernate.connection.username", "tom")
                .setProperty("hibernate.connection.password", "SQL")
                .setProperty("hibernate.connection.autocommit", "true")
                .setProperty("hibernate.show_sql", "false");

        // Tell Hibernate to use the 'SQL Server' dialect when dynamically
        // generating SQL queries
        cfg.setProperty("hibernate.dialect", "org.hibernate.dialect.SQLServerDialect");

        // Tell Hibernate to show the generated T-SQL
        cfg.setProperty("hibernate.show_sql", "false");

        // This is ok during development, but not recommended in production
        // See: http://stackoverflow.com/questions/221379/hibernate-hbm2ddl-auto-update-in-production
        cfg.setProperty("hibernate.hbm2ddl.auto", "update");
        return cfg;
    }
}
