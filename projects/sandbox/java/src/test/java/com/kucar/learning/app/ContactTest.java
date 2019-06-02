package com.kucar.learning.app;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import org.junit.Assert;

public class ContactTest {
	@Before //executed before each test
	public void init() throws SQLException {
		DbHelper.getInstance().init();
		
		try(Connection conn = DbHelper.getConnection();
				Statement stmt = conn.createStatement()){
			stmt.execute("TRUNCATE TABLE contacts");
			stmt.execute("ALTER TABLE contacts ALTER COLUMN id RESTART WITH 1");
		}
	}
	
	@After //always executed, even if test fails
	public void close() {
		DbHelper.getInstance().close();
	}
	
	@Test
	public void testSave() throws SQLException {
		Contact c  = new Contact();
		c.setName("tom test");
		c.setContacts("tom@tom.com");
		c.save();
		
		try(Connection conn = DbHelper.getConnection();
				Statement stmt = conn.createStatement()){
			
			try(ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM contacts")){
				Assert.assertTrue("Count sould return at least one row", rs.next());
				Assert.assertEquals(1L, rs.getLong(1)); // we are expecting one row
				Assert.assertFalse("Count sould return only one row", rs.next());
			}
			
			try(ResultSet rs = stmt.executeQuery("SELECT * FROM contacts")){
				Assert.assertTrue("Count sould return at least one row", rs.next());
				Assert.assertEquals(1L, rs.getLong("id"));
				Assert.assertEquals("tom test", rs.getString("name"));
				Assert.assertFalse("Count sould return only one row", rs.next());
			}
		}
	}
	
}
