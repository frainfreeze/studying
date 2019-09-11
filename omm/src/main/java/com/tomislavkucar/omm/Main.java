package com.tomislavkucar.omm;

import com.googlecode.lanterna.TerminalSize;
import com.googlecode.lanterna.TextColor;
import com.googlecode.lanterna.gui2.BasicWindow;
import com.googlecode.lanterna.gui2.Borders;
import com.googlecode.lanterna.gui2.Button;
import com.googlecode.lanterna.gui2.ComboBox;
import com.googlecode.lanterna.gui2.DefaultWindowManager;
import com.googlecode.lanterna.gui2.Direction;
import com.googlecode.lanterna.gui2.EmptySpace;
import com.googlecode.lanterna.gui2.GridLayout;
import com.googlecode.lanterna.gui2.Label;
import com.googlecode.lanterna.gui2.LinearLayout;
import com.googlecode.lanterna.gui2.MultiWindowTextGUI;
import com.googlecode.lanterna.gui2.Panel;
import com.googlecode.lanterna.gui2.TextBox;
import com.googlecode.lanterna.gui2.WindowBasedTextGUI;
import com.googlecode.lanterna.gui2.dialogs.MessageDialog;
import com.googlecode.lanterna.gui2.dialogs.MessageDialogButton;
import com.googlecode.lanterna.gui2.dialogs.TextInputDialogBuilder;
import com.googlecode.lanterna.gui2.table.Table;
import com.googlecode.lanterna.screen.Screen;
import com.googlecode.lanterna.screen.TerminalScreen;
import com.googlecode.lanterna.terminal.DefaultTerminalFactory;
import com.googlecode.lanterna.terminal.Terminal;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import org.supercsv.cellprocessor.FmtBool;
import org.supercsv.cellprocessor.FmtDate;
import org.supercsv.cellprocessor.Optional;
import org.supercsv.cellprocessor.constraint.LMinMax;
import org.supercsv.cellprocessor.constraint.NotNull;
import org.supercsv.cellprocessor.constraint.UniqueHashCode;
import org.supercsv.cellprocessor.ift.CellProcessor;
import org.supercsv.io.CsvListReader;
import org.supercsv.io.CsvListWriter;
import org.supercsv.io.ICsvListReader;
import org.supercsv.io.ICsvListWriter;
import org.supercsv.prefs.CsvPreference;

public class Main {

    public static String CSV_PATIENTS = "target/patients.csv";

    private static CellProcessor[] getProcessors() {
        final CellProcessor[] processors = new CellProcessor[]{
            new UniqueHashCode(), // Outpatient ID (OPID): (must be unique)
            new NotNull(), // txtName
            new NotNull(), // txtMiddleName
            new NotNull(), // txtSurname
            new NotNull(), // sex
            new NotNull(), //FmtDate("dd/MM/yyyy"), // txtDob
            new NotNull(), // txtStmt
            new NotNull(), // txtNum1
            new NotNull(), // txtNum2
            new NotNull(), // txtKinName
            new NotNull(), // txtKinRel
        //todo - extend with full form
        };

        return processors;
    }

    private static void writeWithCsvListWriter(List<Object> data) throws Exception {
        try (ICsvListWriter listWriter = new CsvListWriter(new FileWriter(CSV_PATIENTS),
                CsvPreference.STANDARD_PREFERENCE)) {

            final CellProcessor[] processors = getProcessors();
            final String[] header = new String[]{"OPID", "txtName", "txtMiddleName", "txtSurname",
                "sex", "txtDob", "txtStmt", "txtNum1", "txtNum2", "txtKinName", "txtKinRel"};

            listWriter.writeHeader(header);
            listWriter.write(data, processors);
        }
    }

    private static List<Object> getPatientFromCSV(String UUID) throws Exception {

        ICsvListReader listReader = null;
        try {
            listReader = new CsvListReader(new FileReader(CSV_PATIENTS), CsvPreference.STANDARD_PREFERENCE);

            listReader.getHeader(true); // skip the header (can't be used with CsvListReader)
            final CellProcessor[] processors = getProcessors();

            List<Object> customerList;
            while ((customerList = listReader.read(processors)) != null) {
                if (customerList.contains(UUID)) {
                    return customerList;
                }
            }

        } finally {
            if (listReader != null) {
                listReader.close();
            }
        }
        return null;
    }

    public static void main(String[] args) throws IOException {
        // Setup terminal and screen layers
        Terminal terminal = new DefaultTerminalFactory().createTerminal();
        Screen screen = null;

        try {
            screen = new TerminalScreen(terminal);
            screen.startScreen();

            BasicWindow window = new BasicWindow("Outpatient Managment Module");

            MultiWindowTextGUI gui = new MultiWindowTextGUI(screen,
                    new DefaultWindowManager(), new EmptySpace(TextColor.ANSI.BLUE));

            // Create god panel to hold main panel and exit button, vertical
            Panel godPanel = new Panel();
            godPanel.setLayoutManager(new LinearLayout(Direction.VERTICAL));

            //main panel to hold subpanels with options, horizontal
            Panel mainPanel = new Panel();
            mainPanel.setLayoutManager(new LinearLayout(Direction.HORIZONTAL));
            godPanel.addComponent(mainPanel);

            // mainpanel subpanels
            Panel leftPanel = new Panel();
            mainPanel.addComponent(leftPanel.withBorder(Borders.singleLine("Reception Executive")));
            Panel middlePanel = new Panel();
            mainPanel.addComponent(middlePanel.withBorder(Borders.singleLine("Patient Managment")));
            Panel rightPanel = new Panel();
            mainPanel.addComponent(rightPanel.withBorder(Borders.singleLine("System")));

            // <editor-fold defaultstate="collapsed" desc="Reception executive">
            // Mini reg form
            BasicWindow miniFormWindow = new BasicWindow();
            Panel miniFormPanel = new Panel();
            miniFormPanel.setLayoutManager(new GridLayout(2));

            miniFormPanel.addComponent(new Label("First Name"));
            final TextBox txtName = new TextBox().addTo(miniFormPanel);

            miniFormPanel.addComponent(new Label("Middle Name"));
            final TextBox txtMiddleName = new TextBox().addTo(miniFormPanel);

            miniFormPanel.addComponent(new Label("Surname"));
            final TextBox txtSurname = new TextBox().addTo(miniFormPanel);

            miniFormPanel.addComponent(new Label("Sex")); //todo: radio button instead of combobox
            final ComboBox<String> gender = new ComboBox<String>();
            gender.addItem("Male");
            gender.addItem("Female");
            miniFormPanel.addComponent(gender);

            miniFormPanel.addComponent(new Label("Date of birth (dd/mm/yyyy)"));
            final TextBox txtDob = new TextBox().addTo(miniFormPanel);

            miniFormPanel.addComponent(new Label("Brief statement or complaint"));
            final TextBox txtStmt = new TextBox().addTo(miniFormPanel);

            miniFormPanel.addComponent(new Label("Contact Telephone Number  1"));
            final TextBox txtNum1 = new TextBox().addTo(miniFormPanel); //setValidationPattern(Pattern.compile("^(?:(?:\\+?1\\s*(?:[.-]\\s*)?)?(?:\\(\\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\\s*\\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\\s*(?:[.-]\\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\\s*(?:[.-]\\s*)?([0-9]{4})(?:\\s*(?:#|x\\.?|ext\\.?|extension)\\s*(\\d+))?$")).addTo(miniFormPanel);

            miniFormPanel.addComponent(new Label("Contact Telephone Number  2"));
            final TextBox txtNum2 = new TextBox().addTo(miniFormPanel);

            miniFormPanel.addComponent(new Label("Next of Kin Full name"));
            final TextBox txtKinName = new TextBox().addTo(miniFormPanel);

            miniFormPanel.addComponent(new Label("Kins relationship to patient"));
            final TextBox txtKinRel = new TextBox().addTo(miniFormPanel);

            new Button("Cancel", miniFormWindow::close).addTo(miniFormPanel);

            new Button("Submit", new Runnable() {
                @Override
                public void run() {
                    //todo: use bean

                    String sex = (gender.getSelectedIndex() == 0) ? "Male" : "Female";
                    List<Object> data = Arrays.asList(new Object[]{UUID.randomUUID().toString(), txtName.getText(), txtMiddleName.getText(), txtSurname.getText(), sex, txtDob.getText(), txtStmt.getText(), txtNum1.getText(), txtNum2.getText(), txtKinName.getText(), txtKinRel.getText()});
                    try {
                        writeWithCsvListWriter(data);
                        miniFormWindow.close();
                        //save to file
                    } catch (Exception ex) {
                        MessageDialog.showMessageDialog(gui, "Error saving data", "Please check your inputs and try again.", MessageDialogButton.OK);
                        Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }).addTo(miniFormPanel);

            miniFormWindow.setComponent(miniFormPanel);

            leftPanel.addComponent(new Button("Mini reg form", new Runnable() {
                @Override
                public void run() {
                    miniFormWindow.setComponent(miniFormPanel);
                    gui.addWindowAndWait(miniFormWindow);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            
            // Comprehensive reg form
            leftPanel.addComponent(new Button("Comprehensive reg form", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "Implement me.", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            
            // Appointments
            leftPanel.addComponent(new Button("Appointments", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "Implement me.", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            // </editor-fold>
            
            // <editor-fold defaultstate="collapsed" desc="Patient managment">
            // Access records
            BasicWindow accessWindow = new BasicWindow();
            Panel accessPanel = new Panel();

            Table<String> table = new Table<String>("OPID", "txtName", "txtMiddleName", "txtSurname",
                    "sex", "txtDob", "txtStmt", "txtNum1", "txtNum2", "txtKinName", "txtKinRel");

            ICsvListReader listReader = null;
            try {
                listReader = new CsvListReader(new FileReader(CSV_PATIENTS), CsvPreference.STANDARD_PREFERENCE);
                listReader.getHeader(true); // skip the header (can't be used with CsvListReader)
                final CellProcessor[] processors = getProcessors();

                List<Object> customerList;
                while ((customerList = listReader.read(processors)) != null) {
                    table.getTableModel().addRow(customerList.toString());
                }
            } catch (FileNotFoundException ex) {
                Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IOException ex) {
                Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                if (listReader != null) {
                    try {
                        listReader.close();
                    } catch (IOException ex) {
                        Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
            accessPanel.addComponent(table);
            accessWindow.setComponent(accessPanel);
            
            middlePanel.addComponent(new Button("Access records", new Runnable() {
                @Override
                public void run() {
                    //new Button("Cancel", accessWindow::close).addTo(accessPanel);
                    gui.addWindowAndWait(accessWindow);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            
            // ?
            middlePanel.addComponent(new Button("Diagnosis notes", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "Implement me.", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            
            // ?
            middlePanel.addComponent(new Button("Appointments", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "Implement me.", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));
            // </editor-fold>
            
            // <editor-fold defaultstate="collapsed" desc="System">
            rightPanel.addComponent(new Button("Medical personel", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "Implement me.", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            rightPanel.addComponent(new Button("Reports", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "Implement me.", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            rightPanel.addComponent(new Button("Help", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "Help file", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));
            // </editor-fold>
            
            
            // Close off with an empty row then a button to close the window
            godPanel.addComponent(
                    new EmptySpace()
                            .setLayoutData(
                                    GridLayout.createHorizontallyFilledLayoutData(2)));
            godPanel.addComponent(
                    new Button("Exit", new Runnable() {
                        @Override
                        public void run() {
                            window.close();
                        }
                    }).setLayoutData(
                            GridLayout.createHorizontallyEndAlignedLayoutData(2)));

            /*We now have the content panel fully populated with components. A common mistake is to forget to attach it to
            the window, so let's make sure to do that.*/
            window.setComponent(godPanel);

            // start gui
            gui.addWindowAndWait(window);

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (screen != null) {
                try {
                    screen.stopScreen();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
