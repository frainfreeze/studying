/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tomislavkucar.omm;

/**
 *
 * @author frain
 */
import com.googlecode.lanterna.Symbols;
import com.googlecode.lanterna.TerminalPosition;
import com.googlecode.lanterna.TerminalSize;
import com.googlecode.lanterna.TextCharacter;
import com.googlecode.lanterna.TextColor;
import com.googlecode.lanterna.graphics.TextGraphics;
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
import com.googlecode.lanterna.gui2.Separator;
import com.googlecode.lanterna.gui2.TextBox;
import com.googlecode.lanterna.gui2.Window;
import com.googlecode.lanterna.gui2.WindowBasedTextGUI;
import com.googlecode.lanterna.gui2.dialogs.MessageDialog;
import com.googlecode.lanterna.gui2.dialogs.MessageDialogButton;
import com.googlecode.lanterna.input.KeyStroke;
import com.googlecode.lanterna.input.KeyType;
import com.googlecode.lanterna.screen.Screen;
import com.googlecode.lanterna.screen.TerminalScreen;
import com.googlecode.lanterna.terminal.DefaultTerminalFactory;
import com.googlecode.lanterna.terminal.Terminal;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.TimeZone;
import java.util.regex.Pattern;

public class Main {

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

      
            /////////////////
            // Reception executive
            Panel leftPanel = new Panel();
            mainPanel.addComponent(leftPanel.withBorder(Borders.singleLine("Reception Executive")));
            
            leftPanel.addComponent(new Button("Mini reg form", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "This is a message box", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            leftPanel.addComponent(new Button("Comprehensive reg form", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "This is a message box", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            leftPanel.addComponent(new Button("Appointments", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "This is a message box", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            /////////////////
            // Patient managment
            Panel middlePanel = new Panel();
            mainPanel.addComponent(middlePanel.withBorder(Borders.singleLine("Patient Managment")));
            
            middlePanel.addComponent(new Button("Access records", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "This is a message box", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            middlePanel.addComponent(new Button("Diagnosis notes", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "This is a message box", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            middlePanel.addComponent(new Button("Appointments", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "This is a message box", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            /////////////////
            // Sysytem
            Panel rightPanel = new Panel();
            mainPanel.addComponent(rightPanel.withBorder(Borders.singleLine("System")));
            
            rightPanel.addComponent(new Button("Medical personel", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "This is a message box", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            rightPanel.addComponent(new Button("Reports", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "This is a message box", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));

            rightPanel.addComponent(new Button("Help", new Runnable() {
                @Override
                public void run() {
                    MessageDialog.showMessageDialog(gui, "MessageBox", "Help file", MessageDialogButton.OK);
                }
            }).setLayoutData(GridLayout.createLayoutData(GridLayout.Alignment.CENTER, GridLayout.Alignment.CENTER)));
            
            ////
            // Close off with an empty row and a separator, then a button to close the window
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
