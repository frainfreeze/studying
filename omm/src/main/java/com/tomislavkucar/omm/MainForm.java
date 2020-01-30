package com.tomislavkucar.omm;

import java.awt.Dimension;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.IOException;
import javax.swing.JOptionPane;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.TableModel;

public class MainForm extends javax.swing.JFrame {

    /**
     * Creates new form mainForm
     */
    public MainForm() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        miniForm = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        comprehensiveForm = new javax.swing.JButton();
        appointments = new javax.swing.JButton();
        jLabel2 = new javax.swing.JLabel();
        accessRecords = new javax.swing.JButton();
        medicalPersonel = new javax.swing.JButton();
        reports = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        miniForm.setText("Minimal form");
        miniForm.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                miniFormActionPerformed(evt);
            }
        });

        jLabel1.setText("Reception executive");

        comprehensiveForm.setText("Comprehensive form");
        comprehensiveForm.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                comprehensiveFormActionPerformed(evt);
            }
        });

        appointments.setText("Appointments");
        appointments.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                appointmentsActionPerformed(evt);
            }
        });

        jLabel2.setText("System");

        accessRecords.setText("Access records");
        accessRecords.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                accessRecordsActionPerformed(evt);
            }
        });

        medicalPersonel.setText("Medical personel");
        medicalPersonel.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                medicalPersonelActionPerformed(evt);
            }
        });

        reports.setText("Reports");
        reports.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                reportsActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(comprehensiveForm, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(appointments, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(miniForm, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addGap(12, 12, 12)))
                .addGap(53, 53, 53)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(accessRecords, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(medicalPersonel, javax.swing.GroupLayout.DEFAULT_SIZE, 133, Short.MAX_VALUE)
                    .addComponent(reports, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(jLabel2)
                        .addGap(47, 47, 47)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(jLabel2))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(miniForm)
                    .addComponent(accessRecords))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(comprehensiveForm)
                    .addComponent(medicalPersonel))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(appointments)
                    .addComponent(reports))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void miniFormActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_miniFormActionPerformed
        MiniForm f = new MiniForm(this);
        f.setLocationRelativeTo(null);
        this.setVisible(false);
        f.setVisible(true);
        f.toFront();
    }//GEN-LAST:event_miniFormActionPerformed

    private void comprehensiveFormActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_comprehensiveFormActionPerformed
        JOptionPane.showMessageDialog(null, "Comprehensive form", "to-do", JOptionPane.WARNING_MESSAGE);
    }//GEN-LAST:event_comprehensiveFormActionPerformed

    private void appointmentsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_appointmentsActionPerformed
        JOptionPane.showMessageDialog(null, "Not in the project scope", "", JOptionPane.INFORMATION_MESSAGE);
    }//GEN-LAST:event_appointmentsActionPerformed

    private void accessRecordsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_accessRecordsActionPerformed
        PatientBean patient = new PatientBean();
        List<PatientBean> patients = new ArrayList<>();
        try {
            patients = DatabaseHandler.readWithCsvBeanReader(patient, Processors.patientsMiniFormProcessor(), Config.PATIENTS);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex, "Error", JOptionPane.WARNING_MESSAGE);
        }
        //https://www.codejava.net/java-se/swing/editable-jtable-example
        TableModel tableModel = TableModelCreator.createTableModel(PatientBean.class, patients);
        JTable table = new JTable(tableModel);
        table.setPreferredScrollableViewportSize(new Dimension(900, 400));

        JScrollPane pane = new JScrollPane(table);

        final JDialog frame = new JDialog(this, "Patient records", true);
        frame.getContentPane().add(pane);
        frame.pack();
        frame.setVisible(true);
    }//GEN-LAST:event_accessRecordsActionPerformed

    private void medicalPersonelActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_medicalPersonelActionPerformed
        JOptionPane.showMessageDialog(null, "To access medical personel use the console app", "", JOptionPane.INFORMATION_MESSAGE);
    }//GEN-LAST:event_medicalPersonelActionPerformed

    private void reportsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_reportsActionPerformed
        Report r = new Report();
        try {
            String s = r.GenerateReport();
            JOptionPane.showMessageDialog(null, "Saved report as " + s, "", JOptionPane.INFORMATION_MESSAGE);
        } catch (IOException ex) {
            JOptionPane.showMessageDialog(null, "Error generating report!", "Error", JOptionPane.WARNING_MESSAGE);
        }
    }//GEN-LAST:event_reportsActionPerformed

    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(MainForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(MainForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(MainForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(MainForm.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(() -> {
            MainForm f = new MainForm();
            f.setLocationRelativeTo(null);
            f.setVisible(true);
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton accessRecords;
    private javax.swing.JButton appointments;
    private javax.swing.JButton comprehensiveForm;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JButton medicalPersonel;
    private javax.swing.JButton miniForm;
    private javax.swing.JButton reports;
    // End of variables declaration//GEN-END:variables
}
