package com.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.dao.dbutil.DBConnection;
import com.dao.interfaces.RestaurantDAO;
import com.dao.model.Restaurant;

public class RestaurantDaoImpl implements RestaurantDAO {

	private static Connection con;

	static
	{
		con = DBConnection.connect();
	}

	private String INSERTQUERY="insert into restaurant(restaurant_id,restaurant_name,cuisine_type,delivery_time,address,ratings,isactive,image_path) values(?,?,?,?,?,?,?,?)";
	private PreparedStatement pstmt;
	private Statement statement;
	private String FETCHALL="select * from restaurant";
	private ResultSet result;
	private ArrayList<Restaurant> restaurantList=new ArrayList<Restaurant>();
	private String FETCHONE="select * from restaurant where restaurant_id=?";
	private Restaurant r;
	private String UPDATE="update restaurant set cuisine_type=? where restaurant_id=?";
	private String DELETE="delete from restaurant where restaurant_id=?";
	@Override
	public int insert(Restaurant r) {
		
		try {
			pstmt = con.prepareStatement(INSERTQUERY);
			pstmt.setInt(1, r.getRestaurantId());
			pstmt.setString(2, r.getRestaurantName());
			pstmt.setString(3, r.getCuisineType());
			pstmt.setInt(4, r.getDeliveryTime());
			pstmt.setString(5, r.getAddress());
			pstmt.setFloat(6, r.getRating());
			pstmt.setBoolean(7,r.isActive());
			pstmt.setString(8, r.getImagePath());
			
			return pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return 0;
	}

	@Override
	public ArrayList<Restaurant> fetchAll() {
		try {
			statement = con.createStatement();
			result = statement.executeQuery(FETCHALL);
			restaurantList=extractRestaurantListFromResultSet(result);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return restaurantList;
	}

	@Override
	public Restaurant fetchOne(int i) {
		try {
			pstmt=con.prepareStatement(FETCHONE);
			pstmt.setInt(1, i);
			result=pstmt.executeQuery();
			restaurantList=extractRestaurantListFromResultSet(result);
			r=restaurantList.get(0);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return r;
	}

	@Override
	public int update(int id, String cuisineType) {
		try {
			pstmt=con.prepareStatement(UPDATE);
			pstmt.setInt(2,id);
			pstmt.setString(1, cuisineType);
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
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		
	}
	
	ArrayList<Restaurant> extractRestaurantListFromResultSet(ResultSet result)
	{
		try {
			while(result.next())
			{
				
				Restaurant r=new Restaurant(result.getInt(1),
						result.getString(2),
						result.getString(3),
						result.getInt(4),
						result.getString(5),
						result.getFloat(6),
						result.getBoolean(7),
						result.getString(8));
				//System.out.println(r);
				restaurantList.add(r);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return restaurantList;
	}

}
