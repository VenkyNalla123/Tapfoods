package com.dao.interfaces;

import java.util.ArrayList;

import com.dao.model.Orders;

public interface OrdersDAO {
	
	int insert(Orders o);
	ArrayList<Orders> fetchAll();
	Orders fetchOne(int id);
	int update(int id,String status);
	int delete(int id);

}
