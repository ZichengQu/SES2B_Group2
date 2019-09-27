package com.bean;

public class StudentList {
	private Integer studentListId;
	private Integer workShopId;
	private Integer studentId;
	private String isPresent;
	private String isEmail;
	public StudentList() {
		super();
		// TODO Auto-generated constructor stub
	}
	public StudentList(Integer studentListId, Integer workShopId, Integer studentId, String isPresent, String isEmail) {
		super();
		this.studentListId = studentListId;
		this.workShopId = workShopId;
		this.studentId = studentId;
		this.isPresent = isPresent;
		this.isEmail = isEmail;
	}
	public Integer getStudentListId() {
		return studentListId;
	}
	public void setStudentListId(Integer studentListId) {
		this.studentListId = studentListId;
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
	public String getIsPresent() {
		return isPresent;
	}
	public void setIsPresent(String isPresent) {
		this.isPresent = isPresent;
	}
	public String getIsEmail() {
		return isEmail;
	}
	public void setIsEmail(String isEmail) {
		this.isEmail = isEmail;
	}
}
