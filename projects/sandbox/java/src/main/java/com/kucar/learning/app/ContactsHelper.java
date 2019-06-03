package com.kucar.learning.app;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ContactsHelper {
	//singleton class, this is the only instance of this class
	private static final ContactsHelper INSTANCE = new ContactsHelper();

	//way to get access to class
	public static ContactsHelper getInstance() {
		return INSTANCE;
	}
	
	//private constructor so no one can create another instance
	private ContactsHelper() {}
	
	//creates empty list, fills it with contacts and returns
	public List<Contact> getContacts() throws SQLException{
		List<Contact> contacts = new ArrayList<>();
		
		String sql = "SELECT * FROM contacts ORDER BY id";
		try(Connection conn = DbHelper.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery()){
			while(rs.next()) {
				Contact contact = new Contact();
				contact.setId(rs.getLong("id"));
				contact.setName(rs.getString("name"));
				contact.setContacts(rs.getString("contacts"));
				contacts.add(contact);
			}
		}
		return contacts;
	}
}
