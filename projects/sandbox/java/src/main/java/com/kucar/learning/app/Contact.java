package com.kucar.learning.app;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Contact {
	
	private long id;
	private String name;
	private String contacts;
	
	public long getId() {
		return id;
	}
	
	public void setId(long id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getContacts() {
		return contacts;
	}
	
	public void setContacts(String contacts) {
		this.contacts = contacts;
	}
	
	
	public void save() throws SQLException {
		final String sql = "INSERT INTO contacts (name, contacts) VALUES (?, ?)";
		
		//its recommended to use prepared statements when having fixed queries.
		//"try with resources", it ll do the closing.
		try(Connection conn = DbHelper.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, name);
			pstmt.setString(2, contacts);
			pstmt.execute();
		}
	}
	
}