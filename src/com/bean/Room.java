package com.bean;

import java.util.HashSet;
import java.util.Set;


public class Room {
	private Integer roomId;
	private String campus;
	private String level;
	private String roomNumber;
	
	private Set<WorkShop> workShops = new HashSet<WorkShop>();//1:n
	private Set<Session> sessions = new HashSet<Session>();//1:n
	public Room() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Room(Integer roomId, String campus, String level, String roomNumber, Set<WorkShop> workShops,
			Set<Session> sessions) {
		super();
		this.roomId = roomId;
		this.campus = campus;
		this.level = level;
		this.roomNumber = roomNumber;
		this.workShops = workShops;
		this.sessions = sessions;
	}
	public Integer getRoomId() {
		return roomId;
	}
	public void setRoomId(Integer roomId) {
		this.roomId = roomId;
	}
	public String getCampus() {
		return campus;
	}
	public void setCampus(String campus) {
		this.campus = campus;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getRoomNumber() {
		return roomNumber;
	}
	public void setRoomNumber(String roomNumber) {
		this.roomNumber = roomNumber;
	}
	public Set<WorkShop> getWorkShops() {
		return workShops;
	}
	public void setWorkShops(Set<WorkShop> workShops) {
		this.workShops = workShops;
	}
	public Set<Session> getSessions() {
		return sessions;
	}
	public void setSessions(Set<Session> sessions) {
		this.sessions = sessions;
	}
	
	
	
}
