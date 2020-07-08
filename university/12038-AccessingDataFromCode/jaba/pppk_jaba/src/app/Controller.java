package app;

import app.Utils.DBHelper;
import app.Utils.CSVHelper;
import app.Utils.PDFHelper;
import app.Utils.XMLHelper;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Label;

import java.nio.file.Paths;
import java.sql.SQLException;

public class Controller {
    public static DBHelper dh = DBHelper.getInstance();
    public static final String DATA_DIRECTORY_PATH = Paths.get(System.getProperty("user.dir"),"workdir").toString();
    @FXML
    private Label lbl;

    public void UvozVozaca(javafx.event.ActionEvent actionEvent) {
        lbl.setText("Uvoz vozaca...");
        CSVHelper cdh = new CSVHelper();
        int n = cdh.importVozaci(Paths.get(DATA_DIRECTORY_PATH,"vozaci.csv").toString());
        lbl.setText("Broj uvezenih vozaca: " + n + ".");
    }

    public void UvozVozila(ActionEvent actionEvent) {
        lbl.setText("Uvoz vozila...");
        CSVHelper cdh = new CSVHelper();
        int n = cdh.importVozila(Paths.get(DATA_DIRECTORY_PATH,"vozila.csv").toString());
        lbl.setText("Broj uvezenih vozila: " + n + ".");
    }

    public void UvozRuta(ActionEvent actionEvent) {
        lbl.setText("Uvoz ruta...");
        XMLHelper xdh = new XMLHelper();
        int n = xdh.importRute(Paths.get(DATA_DIRECTORY_PATH,"rute.xml").toString());
        lbl.setText("Broj uvezenih ruta: " + n);
    }

    public void IzvozRuta(ActionEvent actionEvent) {
        lbl.setText("Izvoz ruta...");
        XMLHelper xdh = new XMLHelper();
        int n = xdh.exportRute(1,DATA_DIRECTORY_PATH,"rute_izvoz.xml");
        lbl.setText("Broj izvezenih ruta: " + n + ".");
    }

    public void GenPDF(ActionEvent actionEvent) {
        lbl.setText("Generiranje PDF-a...");
        PDFHelper pdh = new PDFHelper();
        try {
            pdh.generatePutniNalogPdf(1,DATA_DIRECTORY_PATH,"report.pdf");
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        lbl.setText("PDF generiran.");
    }
}
