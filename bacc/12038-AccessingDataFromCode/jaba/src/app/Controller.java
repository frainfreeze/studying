package app;

import app.Utils.CSVHelper;
import app.Utils.DBHelper;
import app.Utils.PDFHelper;
import app.Utils.XMLHelper;
import javafx.fxml.FXML;
import javafx.scene.control.Label;

import java.nio.file.Paths;

public class Controller {
    public static DBHelper dh = DBHelper.getInstance();
    public static final String DATA_DIRECTORY_PATH = Paths.get(System.getProperty("user.dir"),"workdir").toString();
    @FXML
    private Label lbl;

    public void UvozVozaca() {
        lbl.setText("Uvoz vozaca...");
        CSVHelper cdh = new CSVHelper();
        int n = cdh.importVozaci(Paths.get(DATA_DIRECTORY_PATH,"vozaci.csv").toString());
        lbl.setText("Broj uvezenih vozaca: " + n + ".");
    }

    public void UvozVozila() {
        lbl.setText("Uvoz vozila...");
        CSVHelper cdh = new CSVHelper();
        int n = cdh.importVozila(Paths.get(DATA_DIRECTORY_PATH,"vozila.csv").toString());
        lbl.setText("Broj uvezenih vozila: " + n + ".");
    }

    public void UvozRuta() {
        lbl.setText("Uvoz ruta...");
        XMLHelper xdh = new XMLHelper();
        int n = xdh.importRute(Paths.get(DATA_DIRECTORY_PATH,"rute.xml").toString());
        lbl.setText("Broj uvezenih ruta: " + n);
    }

    public void IzvozRuta() {
        lbl.setText("Izvoz ruta...");
        XMLHelper xdh = new XMLHelper();
        int n = xdh.exportRute(1,DATA_DIRECTORY_PATH,"rute_izvoz.xml");
        lbl.setText("Broj izvezenih ruta: " + n + ".");
    }

    public void GenPDF() {
        lbl.setText("Generiranje PDF-a...");
        PDFHelper pdh = new PDFHelper();
        pdh.generatePutniNalogPdf(1,DATA_DIRECTORY_PATH,"report.pdf");
        lbl.setText("PDF generiran.");
    }
}
