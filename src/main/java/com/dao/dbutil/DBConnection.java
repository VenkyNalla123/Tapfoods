package com.dao.dbutil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	private static Connection con;
	private static String url="jdbc:mysql://sql12.freesqldatabase.com/sql12762835";
	private static String username="sql12762835";
	private static String password="iZRtTkjffS";
			

	public static Connection connect()
	{
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("Class is Loaded");
			con=DriverManager.getConnection(url,username,password);
			System.out.println("Connection Established");
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
	}
}
