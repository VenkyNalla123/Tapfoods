package com.dao.interfaces;

import java.util.ArrayList;

import com.dao.model.OrderHistory;

public interface OrderHistoryDAO {
	
	int insert(OrderHistory o);
	ArrayList<OrderHistory> fetchAll();
	OrderHistory fetchOne(int id);
	int update(int id,String status);
	int delete(int id);
	
}
