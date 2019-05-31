package com.kucar.learning.app;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.commons.dbcp2.BasicDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.googlecode.flyway.core.Flyway;

public class Main {
	private static final Logger LOGGER = LoggerFactory.getLogger(Main.class);
	
	public static void main(String[] args) throws SQLException {
		
		LOGGER.debug("Creating the data source");
		BasicDataSource ds = new BasicDataSource();
		ds.setDriverClassName("org.h2.Driver");
		ds.setUrl("jdbc:h2:./target/db");
		ds.setUsername("sa");
		ds.setPassword("");
		
		
		try {
			LOGGER.debug("Executing flyway");
			Flyway flyway = new Flyway();
			flyway.setDataSource(ds);
			flyway.migrate();
			
			LOGGER.debug("Running queries");
			try (Connection conn = ds.getConnection();
					Statement stmt = conn.createStatement()){
				stmt.execute("INSERT INTO contacts(name, contacts) VALUES ('tomtom','tom@tom.com')");
				
				LOGGER.debug("Contacts:");
				try (ResultSet rs = stmt.executeQuery("SELECT * FROM contacts")){
					while(rs.next()) {
						LOGGER.debug("  >> [{}] {} ({})", new Object[]{ rs.getInt("id"), rs.getString("name"), rs.getString("contacts")});
					}
				}
			}
			
		} catch(SQLException e) {
			LOGGER.debug("Failed: ", e);
		} finally {
			ds.close();
		}
	}
}
