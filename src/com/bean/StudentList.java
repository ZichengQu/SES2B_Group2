package com.bean;

public class StudentList {
	private Integer studentListId;
	private WorkShop workShop;
	private Student student;
	private String isPresent;
	private String isEmail;
	public StudentList() {
		super();
		// TODO Auto-generated constructor stub
	}
	public StudentList(Integer studentListId, WorkShop workShop, Student student, String isPresent, String isEmail) {
		super();
		this.studentListId = studentListId;
		this.workShop = workShop;
		this.student = student;
		this.isPresent = isPresent;
		this.isEmail = isEmail;
	}
	public Integer getStudentListId() {
		return studentListId;
	}
	public void setStudentListId(Integer studentListId) {
		this.studentListId = studentListId;
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
