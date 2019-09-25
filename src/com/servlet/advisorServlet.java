package com.servlet;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

import com.dao.advisorDao;

public class advisorServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		PrintWriter out = response.getWriter();
	    String connectionURL = "jdbc:mysql://localhost:3306/";
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet rs = null;

		String action = request.getParameter("action");
		String[] checkbx = request.getParameterValues("chk");

		
		
		// Servlet action to get unique advisorId with the corresponding data to Update when action with value "Add" is called
		// Loop through add text boxes
		if (action.equalsIgnoreCase("Add")) {
			try {
				Class.forName("com.mysql.jdbc.Driver"); connection = DriverManager.getConnection(connectionURL + "uts_help", "root", "rootroot");

	            

	            List list = new LinkedList();
	            List<String> liststaff = new ArrayList<>();

	            
				for (int i = 1; i < 4; i++) {
					String staffnumber = request.getParameter("staffnumberadd" + i);
					String firstname = request.getParameter("firstnameadd" + i);
					String lastname = request.getParameter("lastnameadd" + i);
					String email = request.getParameter("emailadd" + i);
		            String sql = "SELECT staffNumber FROM advisor WHERE staffNumber= '" + staffnumber +"'";
		            preparedStatement = connection.prepareStatement(sql);
		            
		            rs = preparedStatement.executeQuery();
		            if (rs.isBeforeFirst()) {
            			list.add("Staff number already exists. Please use a different ID.");
            			break;
		            }
		            // All boxes are not filled then the advisors will not be added
		            else if (!staffnumber.isEmpty()  && !firstname.isEmpty() && !lastname.isEmpty() && !email.isEmpty() ) {
			            	advisorDao AdvisorDAO = new advisorDao();
			            	AdvisorDAO.add(staffnumber, firstname, lastname, email);
			            	System.out.println("Advisors Added successfully.....!!");
			            	response.sendRedirect("AdvisorsTab.jsp");
			            	return;
			            	}
		            else if (staffnumber.isEmpty() || firstname.isEmpty() || lastname.isEmpty() || email.isEmpty()){
		            	// Display error message for missing information
		            	list.add("Please fill in all required fields* for staff " + i + " to add advisor.");
					}

	            }
				if( !list.isEmpty())
				{
					request.setAttribute("ErrorList", list);
					RequestDispatcher rd = request.getRequestDispatcher("AdvisorsTab.jsp");
					rd.forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

// Servlet action to get unique advisorId with the corresponding data to Update when action with value "Update" is called
		} else if (action.equalsIgnoreCase("Update")) {
			// Loop all ID that is checked using checkbox array
			for (int i = 0; i < checkbx.length; i++) {

				String staffnumberupdate = request.getParameter("staffno_" + checkbx[i]);
				String firstnameupdate = request.getParameter("fname_" + checkbx[i]);
				String lastnameupdate = request.getParameter("lname_" + checkbx[i]);
				String emailupdate = request.getParameter("staffemail_" + checkbx[i]);
				// Pass the data retrieved into UPDATE function in AdvisorDao
				try {
					advisorDao AdvisorDAO = new advisorDao();
					AdvisorDAO.update(Integer.valueOf(checkbx[i]), staffnumberupdate, firstnameupdate, lastnameupdate,
							emailupdate);
					System.out.println("Advisors Updated successfully.....!!");
					response.sendRedirect("AdvisorsTab.jsp");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

// Servlet action to get unique advisorId to Delete when action with value "Delete" is called
		} else if (action.equalsIgnoreCase("Delete")) {
			// Loop all ID that is checked using checkbox array
			for (int i = 0; i < checkbx.length; i++) {
				// Pass the data retrieved into DELETE function in AdvisorDao
				try {
					advisorDao AdvisorDao = new advisorDao();
					AdvisorDao.delete(Integer.valueOf(checkbx[i]));
					System.out.println("Advisors Deleted successfully.....!!");
					response.sendRedirect("AdvisorsTab.jsp");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

// Servlet action to get unique advisorId to Inactivate Advisors when action with value "Inactivate" is called			
		} else if (action.equalsIgnoreCase("Inactive")) {
			// Loop all ID that is checked using checkbox array
			for (int i = 0; i < checkbx.length; i++) {
				// Pass the data retrieved into INACTIVE function in AdvisorDao
				try {
					advisorDao AdvisorDao = new advisorDao();
					AdvisorDao.inactive(Integer.valueOf(checkbx[i]));
					System.out.println("Advisors Inactivated successfully.....!!");
					response.sendRedirect("AdvisorsTab.jsp");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

// Servlet action to get unique advisorId to Activate Advisors when action with value "Activate" is called			
		} else if (action.equalsIgnoreCase("Active")) {
			// Loop all ID that is checked using checkbox array
			for (int i = 0; i < checkbx.length; i++) {
				// Pass the data retrieved into ACTIVE function in AdvisorDao
				try {
					advisorDao AdvisorDao = new advisorDao();
					AdvisorDao.active(Integer.valueOf(checkbx[i]));
					System.out.println("Advisors Activated successfully.....!!");
					response.sendRedirect("AdvisorsTab.jsp");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}