package com.dao;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.bean.Student;
import com.util.HibernateUtil;

public class AwsTest {
	public Student getStudent(Integer studentId){
		Session session = null;
		Transaction transaction = null;
		Student student = null;
		try {
			session = HibernateUtil.getCurrentSession();
			transaction = session.beginTransaction();
			student = session.get(Student.class, studentId);
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
			e.printStackTrace();
		}
		return student;
	}
}
