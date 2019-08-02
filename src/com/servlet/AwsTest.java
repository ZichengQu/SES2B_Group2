package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bean.Student;

/**
 * Servlet implementation class AwsTest
 */
@WebServlet("/AwsTest")
public class AwsTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AwsTest() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		com.dao.AwsTest aws = new com.dao.AwsTest();
		//Integer studentId = Integer.parseInt();
		Integer studentId = Integer.parseInt((String) request.getParameter("studentId"));
		System.out.println(studentId);
		Student student = aws.getStudent(studentId);
		if(student!=null) {
			String studentName = student.getFirstName();
			request.getSession().setAttribute("student", studentName);
			String description = student.getLastName();
			request.getSession().setAttribute("description", description);
			System.out.println("AWS Test Success");
			response.sendRedirect("../AwsTestSuccess.jsp");
		}else {
			response.sendRedirect("AwsTestFail.jsp");
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
