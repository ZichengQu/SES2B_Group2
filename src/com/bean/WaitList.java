package com.bean;

public class WaitList {
	private Integer waitListId;
	private Integer workShopId;
	private Integer studentId;
	private String rank;
	public WaitList() {
		super();
		// TODO Auto-generated constructor stub
	}
	public WaitList(Integer waitListId, Integer workShopId, Integer studentId, String rank) {
		super();
		this.waitListId = waitListId;
		this.workShopId = workShopId;
		this.studentId = studentId;
		this.rank = rank;
	}
	public Integer getWaitListId() {
		return waitListId;
	}
	public void setWaitListId(Integer waitListId) {
		this.waitListId = waitListId;
	}
	public Integer getWorkShopId() {
		return workShopId;
	}
	public void setWorkShopId(Integer workShopId) {
		this.workShopId = workShopId;
	}
	public Integer getStudentId() {
		return studentId;
	}
	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
}
