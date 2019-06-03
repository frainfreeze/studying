package com.kucar.learning.app;

import java.sql.SQLException;
import javax.swing.SwingUtilities;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Main {
	private static final Logger LOGGER = LoggerFactory.getLogger(Main.class);
	
	public static void main(String[] args) throws SQLException {
		DbHelper.getInstance().init();
		DbHelper.getInstance().registerShutdownHook(); //when vm detects it has to shutdown itll run shutdown hook
		
		SwingUtilities.invokeLater(new Runnable() {
			@Override
			public void run() {
				Application app = new Application();
				app.setTitle("Contacts Archive");
				app.setSize(500,300);
				app.setLocationRelativeTo(null);
				app.setDefaultCloseOperation(Application.EXIT_ON_CLOSE);
				app.setVisible(true);
				Main.LOGGER.debug("Running application...");
			}
		});
	}
}
