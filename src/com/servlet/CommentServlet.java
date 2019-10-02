package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bean.Comment;
import com.bean.Student;
import com.dao.CommentDatabase;
import com.dao.sessionDao;


/**
 * Servlet implementation class CommentServlet
 */
@WebServlet(urlPatterns= {"/CommentServlet"})
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String commentText = request.getParameter("comment_text");
		int student_id = Integer.parseInt(request.getParameter("student_id"), 10);
		int session_id = Integer.parseInt(request.getParameter("session_id"), 10); //currently returns null
		CommentDatabase.saveComment(commentText, student_id, session_id);
		// save comment to database
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
