package com.kucar.learning.app;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.googlecode.flyway.core.Flyway;

//singleton pattern
public class DbHelper {
	public static Connection getConnection() throws SQLException {
		return DbHelper.getInstance().getDataSource().getConnection();
	}
	
	public static DbHelper getInstance() {
		return DbHelper.INSTANCE;
	}
			
	private static final Logger LOGGER = LoggerFactory.getLogger(DbHelper.class);

	private static final DbHelper INSTANCE = new DbHelper();
	
	private BasicDataSource ds;
	
	private DbHelper() {}
	
	public void close() {
		if(ds != null) {
			DbHelper.LOGGER.debug("Closing the datasource");
			// in this case only since we are just closing, 
			// we should warn user when something happens,
			// therefore use throws declaration
			try {
				ds.close();
			} catch (SQLException e) {
				DbHelper.LOGGER.debug("Error while closing db: ", e);
			}
		}
	}
	
	public DataSource getDataSource() {
		return ds;
	}

	public void init() {
		DbHelper.LOGGER.debug("Loading properties");
		final Properties properties = new Properties();
		//defaults
		properties.put("db.path", "./data/db");
		properties.put("db.username", "sa");
		properties.put("db.password", "");
		
		try {
			properties.load(getClass().getResourceAsStream("/app.properties"));
		} catch (final IOException e) {
			DbHelper.LOGGER.error("Failed to load the properties");
		}
		
		
		DbHelper.LOGGER.debug("Creating the data source");
		ds = new BasicDataSource();
		ds.setDriverClassName("org.h2.Driver");
		ds.setUrl("jdbc:h2:" + properties.getProperty("db.path"));
		ds.setUsername(properties.getProperty("db.username"));
		ds.setPassword(properties.getProperty("db.passwrod"));
		
		// we dont want code to use db before flyway is executed
		DbHelper.LOGGER.debug("Executing flyway");
		Flyway flyway = new Flyway();
		flyway.setDataSource(ds);
		flyway.migrate();
	}

	public void registerShutdownHook() {
		//could be done using finalizers but the are discouraged
		Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {
			@Override
			public void run() {
				close();
			}
		}, "DbHelper-thread")); //thread names have to be unique!
	}
}
