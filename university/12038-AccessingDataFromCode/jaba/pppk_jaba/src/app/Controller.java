package app;

import app.Utils.DbHelper;
import app.Utils.csvDataHandler;
import app.Utils.pdfDataHandler;
import app.Utils.xmlDataHandler;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Label;

import java.nio.file.Paths;

public class Controller {
    public static DbHelper dh = DbHelper.getInstance();
    public static final String DATA_DIRECTORY_PATH = Paths.get(System.getProperty("user.dir"),"workdir").toString();
    @FXML
    private Label lbl;

    public void UvozVozaca(javafx.event.ActionEvent actionEvent) {
        lbl.setText("Uvoz vozaca...");
        csvDataHandler cdh = new csvDataHandler();
        int n = cdh.importVozaci(Paths.get(DATA_DIRECTORY_PATH,"vozaci.csv").toString());
        lbl.setText("Broj uvezenih vozaca: " + n + ".");
    }

    public void UvozVozila(ActionEvent actionEvent) {
        lbl.setText("Uvoz vozila...");
        csvDataHandler cdh = new csvDataHandler();
        int n = cdh.importVozila(Paths.get(DATA_DIRECTORY_PATH,"vozila.csv").toString());
        lbl.setText("Broj uvezenih vozila: " + n + ".");
    }

    public void UvozRuta(ActionEvent actionEvent) {
        lbl.setText("Uvoz ruta...");
        xmlDataHandler xdh = new xmlDataHandler();
        int n = xdh.importRute(Paths.get(DATA_DIRECTORY_PATH,"rute.xml").toString());
        lbl.setText("Broj uvezenih ruta: " + n);
    }

    public void IzvozRuta(ActionEvent actionEvent) {
        lbl.setText("Izvoz ruta...");
        xmlDataHandler xdh = new xmlDataHandler();
        int n = xdh.exportRute(1,DATA_DIRECTORY_PATH,"rute_izvoz.xml");
        lbl.setText("Broj izvezenih ruta: " + n + ".");
    }

    public void GenPDF(ActionEvent actionEvent) {
        lbl.setText("Generiranje PDF-a...");
        pdfDataHandler pdh = new pdfDataHandler();
        pdh.generatePutniNalogPdf(1,DATA_DIRECTORY_PATH,"report.pdf");
        lbl.setText("PDF generiran.");
    }
}
