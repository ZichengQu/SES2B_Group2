package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.saveRoom;
/**
 * Servlet implementation class roomServlet
 */
@WebServlet("/roomServlet")
public class roomServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public roomServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String[] chkBox = request.getParameterValues("roomId");
		String action = request.getParameter("action");
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		List<String> list = new LinkedList<String>();
		
		String jspCampus = request.getParameter("selectedCampus");
		String jspRoom = request.getParameter("selectedRoom");
		String jspLevel = request.getParameter("selectedLevel");
		String campus = new String("");
		String level = new String("");
		String dtbRoom = new String("");
		
		
		String id = request.getParameter("userID");
		String driName = "com.mysql.jdbc.Driver";
		String connectionURL = "jdbc:mysql://aagmqmvaq3h3zl.cvdpbjinsegf.us-east-2.rds.amazonaws.com:3306/";
		String dtbName = "uts_help";
		String dtbId = "root";
		String dtbPass = "rootroot";
		Boolean checkAddRoomInput = false;
		Boolean hasDuplicateRoom = false;
		
		try
		{
			Class.forName(driName);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		Statement statement = null;
		Connection connection = null;
		ResultSet rSet = null;
		
		try{
			connection = DriverManager.getConnection(connectionURL + dtbName, dtbId, dtbPass);
			statement = connection.createStatement();
			String dtb = "SELECT * FROM room where campus='"+jspCampus+"' AND level='"+jspLevel+"' AND roomNumber='"+jspRoom+"'";
			rSet = statement.executeQuery (dtb);
		
			while(rSet.next())
			{
				campus = rSet.getString("campus");
				level = rSet.getString("level");
				dtbRoom = rSet.getString("roomNumber");	
			}
			rSet.close();
			statement.close();
			
		} catch(Exception e)
		{
			System.out.println(e);
		}
		
		Boolean isResponseCorrect = Boolean.FALSE;
		
		if(action!= null && action.equalsIgnoreCase("Add")) {
			if(!jspCampus.equals("default")&& !jspLevel.equals("default") && !jspRoom.equals("default")) {
				
				checkAddRoomInput = true;
				
				if(jspCampus.equals(campus) && jspLevel.equals(level) && jspRoom.equals(dtbRoom)) {
					isResponseCorrect = true;
					hasDuplicateRoom = true;
				}
			}
			
			System.out.println(checkAddRoomInput);
			if(checkAddRoomInput) {
				if(!hasDuplicateRoom) {
					isResponseCorrect = false;
					try {
						saveRoom room = new saveRoom();
						room.addRoom(jspCampus, jspLevel, jspRoom);
						System.out.println("ADDED");
						response.sendRedirect("roomTab.jsp");
					}
					catch (Exception e){
						e.printStackTrace();
					}
				}
				else {
					list.add("This room has already existed");
				}
				
			}
			else {
				list.add("Please select all room's detail");
			}
		}
		else if(action != null && action.equalsIgnoreCase("Delete"))
		{
			if(chkBox != null)
			{
				for (int i = 0; i<chkBox.length; i++)
				{
					try {
						saveRoom room = new saveRoom();
						room.deleteRoom(Integer.valueOf(chkBox[i]));
						System.out.println("DELETED");
						response.sendRedirect("roomTab.jsp");	
					}
					catch (Exception e)
					{
						e.printStackTrace();
					}
					}
				}
			else
			{
					list.add("Please select room to delete");
					
			}
				
		}
		
		if(!list.isEmpty())
		{
			request.setAttribute("errorList", list);
			RequestDispatcher rd = request.getRequestDispatcher("roomTab.jsp");
			rd.forward(request, response);
		}
	}
}
	


			
	


