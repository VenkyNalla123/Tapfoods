package com.dao.main;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.dao.dbutil.DBConnection;
import com.dao.impl.MenuDaoImpl;
import com.dao.impl.OrderHistoryDaoimpl;
import com.dao.impl.OrderItemDaoImpl;
import com.dao.impl.OrdersDaoImpl;
import com.dao.impl.RestaurantDaoImpl;
import com.dao.impl.UserDaoImpl;
import com.dao.model.Menu;
import com.dao.model.OrderHistory;
import com.dao.model.OrderItem;
import com.dao.model.Orders;
import com.dao.model.Restaurant;
import com.dao.model.User;

public class Launch {

	private static OrderHistory orderHistory;

	public static void main(String[] args) {
		
//		orderHistory = new OrderHistory(1,1,200,"Delivered");
		OrderHistoryDaoimpl ohsd=new OrderHistoryDaoimpl();
//		if(ohsd.insert(orderHistory)!=0)
//		{
//			System.out.println("Data inserted");
//		}
//		else
//		{
//			System.out.println("Data not Inserted");
//		}
		
//		ArrayList<OrderHistory> fetchAll = ohsd.fetchAll();
//		System.out.println(fetchAll);
//		System.out.println(ohsd.fetchOne(1));
//		System.out.println(ohsd.update(1, "Not Delivered"));
//		System.out.println(ohsd.delete(1));
//		MenuDaoImpl menuDaoImpl = new MenuDaoImpl();
//		
//		ArrayList<Menu> list = menuDaoImpl.fetchMenuByRestaurantId(1);
//		System.out.println(list);
		
		
		
		
		
		
		
		
		
		
		
//		OrderItem orderItem = new OrderItem(1,1,1,2,1233);
//		OrderItemDaoImpl oidi = new OrderItemDaoImpl();
//		oidi.insert(orderItem);
//		ArrayList<OrderItem> fetchAll = oidi.fetchAll();
//		System.out.println(fetchAll);
//		System.out.println(oidi.fetchOne(1));
//		oidi.delete(1);
		
		
//		Orders o=new Orders(1,1,120.0f,"Delivered","online");
//		OrdersDaoImpl odi = new OrdersDaoImpl();
//		System.out.println(odi.insert(o));
//		ArrayList<Orders> fetchAll = odi.fetchAll();
//		System.out.println(fetchAll);
//		System.out.println(odi.fetchOne(1));
//		System.out.println(odi.update(1, "pending"));
		
//		odi.delete(1);
		
		
		
//		Menu M = new Menu(1,1,"Biryani","very good taste",120.50f,true,"imagePath");
//		MenuDaoImpl mdi = new MenuDaoImpl();
//		System.out.println(mdi.insert(M));
//		
//		ArrayList<Menu> fetchAll = mdi.fetchAll();
//		System.out.println(fetchAll);
//		Menu fetchOne = mdi.fetchOne(1);
//		System.out.println(fetchOne);
//		int i = mdi.update(1, "MuttonBiryani");
//		System.out.println(i);
//		System.out.println(mdi.delete(1));
		
		
		
		
			
		
		
		//Connection con = DBConnection.connect();
		//User user = new User(4,"ram","1111","ram@123","sklm");
//		UserDaoImpl daoImpl = new UserDaoImpl();
//		int i = daoImpl.insert(user);
//		if(i!=0)
//		{
//			System.out.println("Data Inserted Successfully");
//		}
//		else
//		{
//			System.out.println("Data Not Inserted");
//		}
//		User fetchOne = daoImpl.fetchOne(2);
//		System.out.println(fetchOne);
//		System.out.println(daoImpl.update(2, "Reddy@123"));
		
//		Restaurant rr=new Restaurant(1,"SVG","Biryani",20,"Vizianagaram",4.5f,true,"gfvghfhfhg");
//		RestaurantDaoImpl rdi=new RestaurantDaoImpl();
//		if(rdi.insert(rr)!=0)
//		{
//			System.out.println("Inserted");
//		}
//		else
//		{
//			System.out.println("Not inserted");
//		}
		
//		ArrayList<Restaurant> fetchAll = rdi.fetchAll();
//		System.out.println(fetchAll);
//		System.out.println(rdi.fetchOne(1));
//		System.out.println(rdi.update(1,"Chicken Biryani"));
//		System.out.println(rdi.fetchOne(1));
		//System.out.println(rdi.delete(1));

	}

}
