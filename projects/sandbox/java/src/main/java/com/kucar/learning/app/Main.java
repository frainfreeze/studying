package com.kucar.learning.app;

import java.sql.SQLException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Main {
	private static final Logger LOGGER = LoggerFactory.getLogger(Main.class);
	
	public static void main(String[] args) throws SQLException {
		DbHelper.getInstance().init();
		
		try {
			Contact c  = new Contact();
			c.setName("tom test");
			c.setContacts("tom@tom.com");
			c.save();
		
			
		
		} catch (SQLException e) {
			LOGGER.error("failed to save contact");
		}
		
		
		DbHelper.getInstance().close();
	}
}
