package com.dao.interfaces;

import java.util.ArrayList;

import com.dao.model.OrderItem;

public interface OrderItemDAO {
	
	int insert(OrderItem u);
	ArrayList<OrderItem> fetchAll();
	OrderItem fetchOne(int i);
	int update(int id,String password);
	int delete(int id);

}
