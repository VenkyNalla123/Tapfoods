package com.dao.interfaces;

import java.util.ArrayList;

import com.dao.model.Menu;

public interface MenuDAO {

	int insert(Menu m);
	ArrayList<Menu> fetchAll();
	Menu fetchOne(int id);
	int update(int id,String menu);
	int delete(int id);
	ArrayList<Menu> fetchMenuByRestaurantId(int RestaurantId);
}
