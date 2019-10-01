package com.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.eclipse.jdt.internal.compiler.classfmt.InnerClassInfo;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;

import com.bean.Comment;
import com.bean.Message;
import com.bean.Student;
import com.util.HibernateUtil;

public class CommentDatabase {
	
	private static final int INITIAL_COMMENT_ID = 1;


	@SuppressWarnings("unchecked")
	public static int getNextCommentId(Session session) {

		try{
			Criteria c = session.createCriteria(Comment.class);
			c.addOrder(Order.desc("commentId"));
			c.setMaxResults(1);
			
			List<Comment> comments = c.list();
			if (comments.isEmpty()) {
				return INITIAL_COMMENT_ID;
			}
			
			return comments.get(0).getCommentId() + 1;
			
		}
		catch (Exception e){
			System.out.println(e.getMessage());
			return INITIAL_COMMENT_ID;
		}			
	}
	
	
	
	//updates the given message object in the database
	public static boolean saveComment(String commentText, int student_id, int session_id){
		boolean updated = false;
		Session session = HibernateUtil.getCurrentSession();
		Transaction transaction = session.beginTransaction();
		
		Date now = new Date();
		
		try{
			Comment comment = new Comment();
			comment.setDescription(commentText);
			Student student = session.get(Student.class, student_id);
			comment.setStudent(student);
			com.bean.Session studentSession = session.get(com.bean.Session.class, session_id);
			comment.setSession(studentSession);
			comment.setDate(now);
			comment.setTime(now);
			comment.setAdmin(studentSession.getAdmin());
			comment.setCommentId(getNextCommentId(session));
			
			session.saveOrUpdate(comment);
			
			updated = true;
		}
		catch(Exception e){
			System.out.println("CAUGHT IN updateMessage: ERROR UPDATING THE DATABASE");
			throw e;
		}
		
		transaction.commit();
		return updated;
	}
	
	
	/************TESTING PURPOSE******************/
	public static void main(String[] agrs){
		try{
		
		}
		catch(NullPointerException e){
			System.out.println("CAUGHT IN MAIN: MESSAGE ID IS OUT OF BOUND!!!");
		}
	}
}
