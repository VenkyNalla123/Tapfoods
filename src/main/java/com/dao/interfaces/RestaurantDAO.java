package com.dao.interfaces;

import java.util.ArrayList;

import com.dao.model.Restaurant;

public interface RestaurantDAO {
	

		int insert(Restaurant r3);
		ArrayList<Restaurant> fetchAll();
		Restaurant fetchOne(int i);
		int update(int id,String cuisineType);
		int delete(int id);
	

}
