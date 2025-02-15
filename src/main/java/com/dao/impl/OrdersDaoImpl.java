package com.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.dao.dbutil.DBConnection;
import com.dao.interfaces.OrdersDAO;
import com.dao.model.Orders;

public class OrdersDaoImpl implements OrdersDAO {

	private static final String INSERT = "insert into orders(user_id,restaurant_id,total_amount,status,payment_mode) values (?,?,?,?,?)";
	private static final String FETCHALL = "Select * from orders";
	private static final String FETCHONE = "Select * from Orders where order_id=?";
	private static final String UPDATE = "update orders set status=? where order_id=?";
	private static final String DELETE = "delete from orders where order_id=?";
	private static Connection con;
	private PreparedStatement pstmt;
	private ArrayList<Orders> orderList=new ArrayList<>();
	private Statement statement;
	private ResultSet result;
	private Orders o;

	static
	{
		con = DBConnection.connect();
	}
	@Override
	public int insert(Orders o) {
		
			int orderId=0;
		
		try {
			pstmt = con.prepareStatement(INSERT,Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, o.getUserId());
			pstmt.setInt(2, o.getRestaurantId());
			pstmt.setFloat(3, o.getTotalAmount());
			pstmt.setString(4, o.getStatus());
			pstmt.setString(5, o.getPaymentMode());
			
			int affectedRows = pstmt.executeUpdate();

	        if (affectedRows > 0) {
	            ResultSet res = pstmt.getGeneratedKeys();
	            if (res.next()) {
	                orderId = res.getInt(1); // Use column index 1 to fetch the generated key
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return orderId;
		
	}

	@Override
	public ArrayList<Orders> fetchAll() {
		
		try {
			statement = con.createStatement();
			result = statement.executeQuery(FETCHALL);
			orderList=extractUserListFromResultSet(result);
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return orderList;
		
	}

	@Override
	public Orders fetchOne(int id) {
		try {
			pstmt=con.prepareStatement(FETCHONE);
			pstmt.setInt(1, id);
			result=pstmt.executeQuery();
			orderList=extractUserListFromResultSet(result);
			o=orderList.get(0);
			
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
	
	ArrayList<Orders> extractUserListFromResultSet(ResultSet result)
	{
		try {
			while(result.next())
			{
				Orders orders = new Orders(
						result.getInt(2),
						result.getInt(3),
						result.getFloat(5),
						result.getString(6),
						result.getString(7));
				orderList.add(orders);
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return orderList;
		
	}

}
