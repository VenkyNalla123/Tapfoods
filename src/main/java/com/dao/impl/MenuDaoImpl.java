package com.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.dao.dbutil.DBConnection;
import com.dao.interfaces.MenuDAO;
import com.dao.model.Menu;

public class MenuDaoImpl implements MenuDAO {

	private static final String UPDATE = "update menu set name=? where menu_id=?";
	private static Connection con;
	private static String INSERT="insert into menu(menu_id,restaurant_id,name,description,price,isavailable,imagepath) values(?,?,?,?,?,?,?)";

	static
	{
		con = DBConnection.connect();
	}

	private PreparedStatement pstmt;
	private Statement statement;
	private String FETCHALL="Select * from menu";
	private ResultSet result;
	private ArrayList<Menu> menuList=new ArrayList<>();
	private String FETCHONE="Select * from menu where menu_id=?";
	private Menu m;
	private final static String DELETE="delete from menu where menu_id=?";
	private static final String FETCHMENUBYRID = "select * from menu where restaurant_Id=?";

	@Override
	public int insert(Menu m) {
		
		try {
			pstmt=con.prepareStatement(INSERT);
			pstmt.setInt(1, m.getMenuId());
			pstmt.setInt(2, m.getRestaurantId());
			pstmt.setString(3, m.getName());
			pstmt.setString(4, m.getDescription());
			pstmt.setFloat(5, m.getPrice());
			pstmt.setBoolean(6, m.isAvailable());
			pstmt.setString(7, m.getImagePath());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public ArrayList<Menu> fetchAll() {
		try {
			statement = con.createStatement();
			result = statement.executeQuery(FETCHALL);
			menuList=extractMenuListfromResultSet(result);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return menuList;
	}

	@Override
	public Menu fetchOne(int id) {
		try {
			pstmt=con.prepareStatement(FETCHONE);
			pstmt.setInt(1, id);
			result=pstmt.executeQuery();
			menuList=extractMenuListfromResultSet(result);
			m=menuList.get(0);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return m;
	}

	@Override
	public int update(int id, String menu) {
		try {
			pstmt=con.prepareStatement(UPDATE);
			pstmt.setInt(2, id);
			pstmt.setString(1, menu);
			return pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int delete(int id) {
		try {
			pstmt=con.prepareStatement(DELETE);
			pstmt.setInt(1, id);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	public ArrayList<Menu> extractMenuListfromResultSet(ResultSet result)
	{
		try {
			while(result.next())
			{
				Menu m=new Menu(result.getInt(1),
						result.getInt(2),
						result.getString(3),
						result.getString(4),
						result.getFloat(5),
						result.getBoolean(6),
						result.getString(7));
				menuList.add(m);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return menuList;
	}

	@Override
	public ArrayList<Menu> fetchMenuByRestaurantId(int RestaurantId) {
		try {
			pstmt= con.prepareStatement(FETCHMENUBYRID);
			pstmt.setInt(1, RestaurantId);
			result = pstmt.executeQuery();
			menuList=extractMenuListfromResultSet(result);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return menuList;
	}

}
