package com.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.dao.dbutil.DBConnection;
import com.dao.interfaces.OrderHistoryDAO;
import com.dao.model.OrderHistory;
import com.dao.model.User;

public class OrderHistoryDaoimpl implements OrderHistoryDAO {
	
	private static final String INSERT = "insert into orderhistory(order_id,user_id,total_amount,status) values (?,?,?,?)";
	private static final String FETCHALL = "select * from orderHistory";
	private static final String FETCHONE = "select * from orderHistory where orderHistory_id=?";
	private static final String UPDATE = "update orderhistory set status=? where orderhistory_id=?";
	private static final String DELETE = "delete from orderhistory where orderhistory_id=?";
	private static Connection con;
	private PreparedStatement pstmt;
	private Statement statement;
	private ResultSet result;
	private ArrayList<OrderHistory> orderHistoryList=new ArrayList<>();
	private ArrayList<OrderHistory> orderHistoryListFromResultSet;
	private OrderHistory o;

	static
	{
		con = DBConnection.connect();
	}
	@Override
	public int insert(OrderHistory o) {
		try {
			pstmt = con.prepareStatement(INSERT);
			pstmt.setInt(1, o.getOrderId());
			pstmt.setInt(2, o.getUserId());
			pstmt.setFloat(3, o.getTotalAmount());
			pstmt.setString(4, o.getStatus());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public ArrayList<OrderHistory> fetchAll() {
		try {
			statement = con.createStatement();
			result = statement.executeQuery(FETCHALL);
			orderHistoryList = extractOrderHistoryListFromResultSet(result);
			
			return orderHistoryList;
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public OrderHistory fetchOne(int id) {
		
		try {
			pstmt=con.prepareStatement(FETCHONE);
			pstmt.setInt(1, id);
			result = pstmt.executeQuery();
			orderHistoryListFromResultSet = extractOrderHistoryListFromResultSet(result);
			o=orderHistoryListFromResultSet.get(0);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return o;
		
	}

	@Override
	public int update(int id, String status) {
		try {
			pstmt=con.prepareStatement(UPDATE);
			pstmt.setInt(2, id);
			pstmt.setString(1, status);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int delete(int id) {
		try {
			pstmt=con.prepareStatement(DELETE);
			pstmt.setInt(1, id);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	ArrayList<OrderHistory> extractOrderHistoryListFromResultSet(ResultSet result)
	{
		try {
			while(result.next())
			{
				OrderHistory order  = new OrderHistory(
						result.getInt(2),
						result.getInt(3),
						result.getFloat(4),
						result.getString(5)
						);
				orderHistoryList.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return orderHistoryList;
	}

}
