package com.dao;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.Metadata;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

import com.bean.Room;
import com.util.HibernateUtil;

public class saveRoom {
	public void addRoom(String campus, String level, String room )
	{
		 try {
			 Configuration con = new Configuration().configure();
	 		 SessionFactory factory = con.buildSessionFactory(); 
	 		 Session session =  factory.openSession();
	 		 Transaction transaction = session.beginTransaction();
	 		 
	 		 Room addedRoom = new Room();
	 		 addedRoom.setCampus(campus);
	 		 addedRoom.setLevel(level);
	 		 addedRoom.setRoomNumber(room);
	        	 session.save(addedRoom);
	         	 transaction.commit();
	         	 System.out.println("\n Added \n");
	         
		 } catch (HibernateException e)
		 {
			System.out.println(e.getMessage());
	         	System.out.println("ERROR");
		 }
	}
	
	public void deleteRoom (int roomId){
		 Configuration con = new Configuration();
 		 con.configure("hibernate.cfg.xml");
 		 SessionFactory factory = con.buildSessionFactory(); 
 		 Session session =  factory.openSession();
 	  
 		 Object obj= session.load(Room.class, roomId);
 		 
 		 Room deletedRoom =(Room)obj;
 	  
 		 Transaction transaction = session.beginTransaction();
        	 session.delete(deletedRoom);
         	 transaction.commit();
         	 System.out.println("\n Deleted \n");
	}
	
	public static Room getCurrentRoom(int i) {
	
		Session session = HibernateUtil.getCurrentSession();
		Transaction transaction  = session.beginTransaction();
		
		Room room = null;
		
		try {
			
			room = session.get(Room.class, i);
			
			transaction.commit();
			return room;
		}
		catch (Exception e){
			System.out.println("Error");
			throw e;
		}	
	}
}

