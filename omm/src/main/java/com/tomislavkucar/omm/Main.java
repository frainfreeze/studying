package com.tomislavkucar.omm;

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
import com.googlecode.lanterna.gui2.dialogs.MessageDialog;
import com.googlecode.lanterna.gui2.dialogs.MessageDialogButton;
import com.googlecode.lanterna.gui2.table.Table;
import com.googlecode.lanterna.screen.Screen;
import com.googlecode.lanterna.screen.TerminalScreen;
import com.googlecode.lanterna.terminal.DefaultTerminalFactory;
import com.googlecode.lanterna.terminal.Terminal;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Main { 
    public static void main(String[] args) throws IOException {
        Terminal terminal = new DefaultTerminalFactory().createTerminal();
        Screen screen = null;

        try {
            screen = new TerminalScreen(terminal);
            screen.startScreen();

            BasicWindow window = new BasicWindow("Outpatient Managment Module");

            MultiWindowTextGUI gui = new MultiWindowTextGUI(screen,
                    new DefaultWindowManager(), new EmptySpace(TextColor.ANSI.BLUE));

            Panel godPanel = new Panel();
            godPanel.setLayoutManager(new LinearLayout(Direction.VERTICAL));

            Panel mainPanel = new Panel();
            mainPanel.setLayoutManager(new LinearLayout(Direction.HORIZONTAL));
            godPanel.addComponent(mainPanel);

            Panel leftPanel = new Panel();
            mainPanel.addComponent(leftPanel.withBorder(Borders.singleLine("Reception Executive")));
            Panel rightPanel = new Panel();
            mainPanel.addComponent(rightPanel.withBorder(Borders.singleLine("System")));

            // <editor-fold defaultstate="collapsed" desc="Reception executive">
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
                    String sex = (gender.getSelectedIndex() == 0) ? "Male" : "Female";
                    PatientBean data = new PatientBean(txtName.getText(), txtMiddleName.getText(), txtMiddleName.getText(), sex, txtDob.getText(), txtStmt.getText(), txtNum1.getText(), txtNum2.getText(), txtKinName.getText(), txtKinRel.getText(), UUID.randomUUID().toString());
                    try {
                        if (data.checkEmpty()) {
                            MessageDialog.showMessageDialog(gui, "Error saving data", "Please fill all fields.", MessageDialogButton.OK); 
                            return;
                        }
                        DatabaseHandler.writeWithCsvBeanWriter(Processors.patientsMiniFormProcessor(), data, Config.patientHeader, Config.PATIENTS);
                        txtName.setText("");txtMiddleName.setText("");txtSurname.setText("");txtDob.setText("");txtStmt.setText("");txtNum1.setText("");txtNum2.setText("");txtKinName.setText("");txtKinRel.setText("");
                        miniFormWindow.close();
                        
                    } catch (Exception ex) {
                        MessageDialog.showMessageDialog(gui, "Error saving data", "Please check your inputs and try again.", MessageDialogButton.OK);
                    }
                }
            }).addTo(miniFormPanel);

            leftPanel.addComponent(new Button("Minimal form", new Runnable() {
                @Override
                public void run() {
                    miniFormWindow.setComponent(miniFormPanel);
                    gui.addWindowAndWait(miniFormWindow);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            leftPanel.addComponent(new Button("Comprehensive form", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "Implement me.", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            leftPanel.addComponent(new Button("Appointments", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "Implement me.", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            // </editor-fold>
            // <editor-fold defaultstate="collapsed" desc="System">
            rightPanel.addComponent(new Button("Access records", () -> {
                BasicWindow accessWindow = new BasicWindow();
                Panel accessPanel = new Panel();
                accessPanel.setLayoutManager(new LinearLayout(Direction.VERTICAL));
                
                Table<String> table = new Table<>("Name", "Middle Name", "Surname",
                        "Sex", "DOB", "Statement", "Num1", "Num2", "Kin Name", "Kin Rel", "OPID");
                
                try {
                    File csvFile = new File(Config.PATIENTS);
                    if (csvFile.isFile()) {
                        String row = null;
                        BufferedReader csvReader;
                        try {
                            csvReader = new BufferedReader(new FileReader(Config.PATIENTS));
                            csvReader.readLine();
                            while ((row = csvReader.readLine()) != null) {
                                table.getTableModel().addRow(row.split(","));
                            }
                            csvReader.close();
                        } catch (FileNotFoundException ex) {
                            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
                        } catch (IOException ex) {
                            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    
                    table.setSelectAction(() -> {
                        List<String> data = table.getTableModel().getRow(table.getSelectedRow());
                        MessageDialog.showMessageDialog(gui, "UUID", data.get(data.size() - 1), MessageDialogButton.OK);
                    });
                    accessPanel.addComponent(table);
                    new Button("Close", accessWindow::close).addTo(accessPanel);
                    accessWindow.setComponent(accessPanel);
                    gui.addWindowAndWait(accessWindow);
                } catch (Exception ex) {
                    
                    MessageDialog.showMessageDialog(gui, "Error!", ex.getMessage(), MessageDialogButton.OK);
                    Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            rightPanel.addComponent(new Button("Medical personel", () -> {
                BasicWindow workersWindow = new BasicWindow();
                Panel workersPanel = new Panel();
                workersPanel.setLayoutManager(new LinearLayout(Direction.VERTICAL));
                
                Table<String> table = new Table<>("Name", "Surname", "Work type", "Available", "Email", "Phone", "UUID");
                
                try {
                    File csvFile = new File(Config.STAFF);
                    if (csvFile.isFile()) {
                        String row = null;
                        BufferedReader csvReader;
                        try {
                            csvReader = new BufferedReader(new FileReader(Config.STAFF));
                            csvReader.readLine();
                            while ((row = csvReader.readLine()) != null) {
                                table.getTableModel().addRow(row.split(","));
                            }
                            csvReader.close();
                        } catch (FileNotFoundException ex) {
                            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
                        } catch (IOException ex) {
                            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    
                    table.setSelectAction(new Runnable() {
                        @Override
                        public void run() {
                            List<String> data = table.getTableModel().getRow(table.getSelectedRow());
                            MessageDialog.showMessageDialog(gui, "UUID", data.get(data.size() - 1), MessageDialogButton.OK);
                        }
                    });
                    workersPanel.addComponent(table);
                    
                    new Button("Close", workersWindow::close).addTo(workersPanel);
                    
                    new Button("Add new...", new Runnable() {
                        @Override
                        public void run() {
                            List<Object> data = Arrays.asList(new Object[]{"Ivo","Ivic","Consultant","Yes","ivic@virgo.com","091828283",UUID.randomUUID().toString()}); // = Arrays.asList(new Object[]{txtModalName.getText(), txtSurname.getText(), ..., UUID.randomUUID().toString()});
                            try {
                                DatabaseHandler.writeWithCsvListWriter(data, Processors.personelProcessor(), Config.STAFF);
                                workersWindow.close();
                            } catch (Exception ex) {
                                MessageDialog.showMessageDialog(gui, "Error saving data", "Please check your inputs and try again.", MessageDialogButton.OK);
                                Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }
                    }).addTo(workersPanel);
                    
                    workersWindow.setComponent(workersPanel);
                    gui.addWindowAndWait(workersWindow);
                } catch (Exception ex) {
                    MessageDialog.showMessageDialog(gui, "Error!", ex.getMessage(), MessageDialogButton.OK);
                    Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            rightPanel.addComponent(new Button("Reports", () -> {
                Report r = new Report();
                try {
                    r.GenerateReport();
                    MessageDialog.showMessageDialog(gui, "Outpatient managment module reports", "Report saved as " + Config.reportName, MessageDialogButton.OK);
                } catch (IOException ex) {
                    MessageDialog.showMessageDialog(gui, "Outpatient managment module reports", "Error generating report.", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));
            // </editor-fold>

            godPanel.addComponent(
                    new Button("Exit", window::close).setLayoutData(GridLayout.createHorizontallyFilledLayoutData(2)));
            
            window.setComponent(godPanel);
            gui.addWindowAndWait(window);

        } catch (IOException e) {
        } finally {
            if (screen != null) {
                try {
                    screen.stopScreen();
                } catch (IOException e) {
                }
            }
        }
    }
}
