package com.bean;

public class WaitList {
	private Integer waitListId;
	private WorkShop workShop;
	private Student student;
	private String rank;
	public WaitList() {
		super();
		// TODO Auto-generated constructor stub
	}
	public WaitList(Integer waitListId, WorkShop workShop, Student student, String rank) {
		super();
		this.waitListId = waitListId;
		this.workShop = workShop;
		this.student = student;
		this.rank = rank;
	}
	public Integer getWaitListId() {
		return waitListId;
	}
	public void setWaitListId(Integer waitListId) {
		this.waitListId = waitListId;
	}
	public WorkShop getWorkShop() {
		return workShop;
	}
	public void setWorkShop(WorkShop workShop) {
		this.workShop = workShop;
	}
	public Student getStudent() {
		return student;
	}
	public void setStudent(Student student) {
		this.student = student;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	
	
}
