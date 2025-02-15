package com.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.dao.dbutil.DBConnection;
import com.dao.interfaces.OrderItemDAO;
import com.dao.model.OrderItem;

public class OrderItemDaoImpl implements OrderItemDAO{
	
	private static final String UPDATE = "update orderItem set quantity=? where orderItem_id=?";
	private static Connection con;
	private static String INSERT="insert into orderItem(orderitem_id,order_id,menu_id,quantity,item_total) values(?,?,?,?,?)";

	static
	{
		con = DBConnection.connect();
	}

	private PreparedStatement pstmt;
	private Statement statement;
	private String FETCHALL="Select * from orderItem";
	private ResultSet result;
	private ArrayList<OrderItem> orderList=new ArrayList<>();
	private String FETCHONE="Select * from orderItem where orderitem_id=?";
	private OrderItem m;
	private final static String DELETE="delete from orderitem where orderitem_id=?";

	@Override
	public int insert(OrderItem o) {
		
		try {
			pstmt=con.prepareStatement(INSERT);
			pstmt.setInt(1, o.getOrderItemId());
			pstmt.setInt(2, o.getOrderId());
			pstmt.setInt(3, o.getMenuId());
			pstmt.setInt(4, o.getQuantity());
			pstmt.setFloat(5, o.getItemTotal());
		
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public ArrayList<OrderItem> fetchAll() {
		try {
			statement = con.createStatement();
			result = statement.executeQuery(FETCHALL);
			orderList=extractMenuListfromResultSet(result);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return orderList;
	}

	@Override
	public OrderItem fetchOne(int id) {
		try {
			pstmt=con.prepareStatement(FETCHONE);
			pstmt.setInt(1, id);
			result=pstmt.executeQuery();
			orderList=extractMenuListfromResultSet(result);
			m=orderList.get(0);
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
	
	public ArrayList<OrderItem> extractMenuListfromResultSet(ResultSet result)
	{
		try {
			while(result.next())
			{
				OrderItem m=new OrderItem(result.getInt(1),
						result.getInt(2),
						result.getInt(3),
						result.getInt(4),
						result.getFloat(5));
				orderList.add(m);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return orderList;
	}

}
