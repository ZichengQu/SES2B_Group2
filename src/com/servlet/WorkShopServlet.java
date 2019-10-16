package com.servlet;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.base.BaseServlet;
import com.base.Common;
import com.bean.Admin;
import com.bean.Attendance;
import com.bean.Room;
import com.bean.SkillSet;
import com.bean.Student;
import com.bean.StudentList;
import com.bean.WaitList;
import com.bean.WaitingList;
import com.bean.WorkShop;
import com.util.HibernateUtil;
import com.util.SendMail;

/**
 * Servlet implementation class WorkShopServlet
 */
@WebServlet("/workshop")
public class WorkShopServlet extends BaseServlet {
	Session session = HibernateUtil.getCurrentSession();
	
	public void toSkillSet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Transaction ts = session.beginTransaction();
		String hql="from SkillSet";
		List<SkillSet> skillSets = session.createQuery(hql).list();
		
		request.getSession().setAttribute("skillSets", skillSets);
		
		//加载 room
		String hql2="from Room";
		List<Room> rooms = session.createQuery(hql2).list();
		request.getSession().setAttribute("rooms", rooms);
		ts.commit();
		response.sendRedirect("setWorkshop.jsp");
	}
	
	public void archive(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Transaction ts = session.beginTransaction();
		try {
			String hql="from WorkShop";
			List<WorkShop> workShops = session.createQuery(hql).list();
			Date date = new Date();
			SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd hh:mm");
			DateFormat fmt = new SimpleDateFormat("yyyyMMdd hh:mm"); 
			Date tempTime = fmt.parse(dateFormat.format(date));
			System.out.println("tempTime"+tempTime);
			
			for(WorkShop workShop : workShops) {
				
				Date endTime = fmt.parse(dateFormat.format(workShop.getEndDate()));
				
				if(endTime.compareTo(tempTime)==-1 || endTime.compareTo(tempTime)==0) {
					session.delete(workShop);
				}
			}
			
			String hql1="from SkillSet";
			List<SkillSet> skillSets = session.createQuery(hql1).list();
			ts.commit();
			request.getSession().setAttribute("skillSets", skillSets);
			response.sendRedirect("setWorkshop.jsp");
		} catch (Exception e) {
			ts.rollback();
			e.printStackTrace();
		}
	}
	public void insertSkillSet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Transaction ts = session.beginTransaction();
		try {
			String name = request.getParameter("name");
			
			SkillSet skillSet = new SkillSet();
			skillSet.setName(name);
			/*替换登陆用户*/
//			Admin admin = new Admin();
//			admin.setAdminId(Common.admin);
//			skillSet.setAdmin(admin);
			/*替换登陆用户*/
			session.save(skillSet);
			
			
			String hql="from SkillSet";
			List<SkillSet> skillSets = session.createQuery(hql).list();
			ts.commit();
			request.getSession().setAttribute("skillSets", skillSets);
			response.sendRedirect("setWorkshop.jsp");
		} catch (Exception e) {
			ts.rollback();
			e.printStackTrace();
		}
	}
	
	public void updateSkillSet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Transaction ts = session.beginTransaction();
		try {
			String skillSetId = request.getParameter("skillSetId");
			String shortName = request.getParameter("shortName");
			
			SkillSet skillSet = session.get(SkillSet.class, Integer.parseInt(skillSetId));
			skillSet.setShortName(shortName);
			session.save(skillSet);
			
			//String hql="from SkillSet";
			//List<SkillSet> skillSets = session.createQuery(hql).list();
			ts.commit();
			//request.getSession().setAttribute("skillSets", skillSets);
			response.getWriter().print("success");
		} catch (NumberFormatException e) {
			ts.rollback();
			e.printStackTrace();
		}
	}
	
	public void changeSkillSet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Transaction ts = session.beginTransaction();
		try {
			String skillSetId = request.getParameter("skillSetId");
			String shortName = request.getParameter("shortName");
			
			SkillSet skillSet = session.get(SkillSet.class, Integer.parseInt(skillSetId));
			skillSet.setShortName(shortName);
			session.save(skillSet);
			
			//String hql="from SkillSet";
			//List<SkillSet> skillSets = session.createQuery(hql).list();
			ts.commit();
			//request.getSession().setAttribute("skillSets", skillSets);
			response.getWriter().print("success");
		} catch (NumberFormatException e) {
			ts.rollback();
			e.printStackTrace();
		}
	}
	
	
	public void addworkshop(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Transaction ts = session.beginTransaction();
		try {
			String ss = request.getParameter("ss");
			System.out.println(ss);
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
//			for(String s:arr){
			String s = ss;
				String[] fields = s.split(",");
				WorkShop workshop = new WorkShop();
				workshop.setName(fields[0]);//topic
				workshop.setStartDate(sdf.parse(fields[1]));
				workshop.setEndDate(sdf.parse(fields[2]));
				workshop.setMaximumPlace(fields[3]);//MAX
				workshop.setPlaceAvailable(fields[4]);//C/O
				
				int roomId = Integer.parseInt(fields[5]);
				String hql2="from Room where roomId=?";
				List<Room> rooms = session.createQuery(hql2).setParameter(0, roomId).list();
				System.out.println("房间列表为"+rooms);
				Room room = rooms.get(0);
				workshop.setRoom(room);
//				/*替换登陆用户*/
//				Admin admin = new Admin();
//				admin.setAdminId(Common.admin);
//				workshop.setAdmin(admin);
//				/*替换登陆用户*/
//				
				SkillSet skillSet = new SkillSet();
				skillSet.setSkillSetId(Integer.parseInt(fields[6]));
				workshop.setSkillSet(skillSet);
//				
				session.save(workshop);
//			}
			ts.commit();
			response.getWriter().print("success");
		} catch (NumberFormatException | ParseException e) {
			ts.rollback();
			e.printStackTrace();
		}
	}
	
	public void deleteworkshop(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Transaction ts = session.beginTransaction();
		try {
			String cks = request.getParameter("cks");
			String[] arr = cks.split(",");
			for(String s:arr){
				WorkShop workshop = new WorkShop();
				workshop.setWorkShopId(Integer.parseInt(s));
				session.delete(workshop);
			}
			ts.commit();
			response.getWriter().print("success");
		} catch (Exception e) {
			ts.rollback();
			e.printStackTrace();
		}
	}
	
	public void showWorkShop(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Transaction ts = session.beginTransaction();
		String skillSetId = request.getParameter("skillSetId");
		String hql="from WorkShop where skillSetId=?";
		List<WorkShop> workShops = session.createQuery(hql).setParameter(0, Integer.parseInt(skillSetId)).list();
		ts.commit();
		request.getSession().setAttribute("workShops", workShops);
		System.out.println(workShops);
		response.sendRedirect("createNewsession.jsp?skillSetId="+skillSetId);
	}
	
	public void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Transaction ts = session.beginTransaction();
		String workShopId = request.getParameter("workShopId");
		String hql="from WorkShop where workShopId=?";
		WorkShop workShop = (WorkShop)session.createQuery(hql).setParameter(0, Integer.parseInt(workShopId)).uniqueResult();
		
		String sql="from StudentList where workShopId=?";
		List<StudentList> studentList = session.createQuery(sql).setParameter(0, Integer.parseInt(workShopId)).list();
//		int total = Integer.parseInt(workShop.getMaximumPlace());
		
		Set<Student> students = workShop.getStudents();
		int total = Integer.parseInt(workShop.getMaximumPlace());
		
		try{
			if(students.size() > total){
				System.out.println("人多了");
				for(int temp = total ; temp < students.size() ;temp++ ){
					Iterator<Student> iterator = students.iterator();
					while(iterator.hasNext()) {
						Student student = iterator.next();
						WaitList waitList = new WaitList();
						waitList.setStudent(student);
						waitList.setWorkShop(workShop);
						session.save(waitList);
						iterator.remove();
						students.remove(student);
						if(students.size()==total) break;
					}
				}
			}else if(students.size() < total){
				System.out.println("人少了");
				String sql1="from WaitList where workShopId=?";
				List<WaitList> tempWait = session.createQuery(sql1).setParameter(0, Integer.parseInt(workShopId)).list();
				int avaiable = (Integer.parseInt(workShop.getMaximumPlace()) - students.size()) > tempWait.size() ? tempWait.size() : Integer.parseInt(workShop.getMaximumPlace()) - students.size(); 
				for(int i=0; i<avaiable;i++){
//					StudentList tempStuList = new StudentList();
//					tempStuList.setIsEmail("no");
//					tempStuList.setIsPresent("no");
//					tempStuList.setStudent(tempWait.get(i).getStudent());
//					tempStuList.setWorkShop(tempWait.get(i).getWorkShop());
//					session.save(tempStuList);
					Student student = tempWait.get(i).getStudent();
					students.add(student);
					session.delete(tempWait.get(i));
				}
			}
			
			workShop.setStudents(students);
			session.save(workShop);
			
			int flag = 0;
			
			//将t_student_workShop中的选课信息保存到studentList表中，因为studentList表中有isPresent和isEmail属性
			Iterator<Student> iterator = students.iterator();
			while(iterator.hasNext()) {
				Student tempStudent = iterator.next();
				
				//同一学生选同一课程只能选一次
				for(StudentList temp : studentList) {
					if(temp.getStudent().equals(tempStudent) && temp.getWorkShop().equals(workShop)) {
						flag = 1;
						break;
					}
				}
				
				if(flag == 0) {
					StudentList newStudentList = new StudentList();
					newStudentList.setIsEmail("no");
					newStudentList.setIsPresent("no");
					newStudentList.setStudent(tempStudent);
					newStudentList.setWorkShop(workShop);
					session.save(newStudentList);
				}
				flag = 0;
			}
			
			
			String sql1="from WaitList where workShopId=?";
			List<WaitList> waiting = session.createQuery(sql1).setParameter(0, Integer.parseInt(workShopId)).list();
			
			String sql2="from StudentList where workShopId=?";
			List<StudentList> studentList2 = session.createQuery(sql2).setParameter(0, Integer.parseInt(workShopId)).list();
			
			ts.commit();
			request.getSession().setAttribute("workShop", workShop);
			request.getSession().setAttribute("studentList", studentList2);
			request.getSession().setAttribute("waiting", waiting);
	//		String hql2="from WaitingList";
	//		List<WaitingList> waitingList = session.createQuery(hql2).list();
	//		
	//		Set waiting = new HashSet();
	//		for(WaitingList wait : waitingList){
	//			if(wait.getWorkShopId().equals(workShopId)){
	//				waiting.add(wait.getStudents().iterator().next());
	//			}
	//		}
	//		request.setAttribute("waiting", waiting);
			//ts.commit();
			//response.sendRedirect("detail.jsp");
			request.getRequestDispatcher("detail.jsp").forward(request,response);
		}catch (NumberFormatException e) {
				ts.rollback();
				e.printStackTrace();
		}
	}
	
	public void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Transaction ts = session.beginTransaction();
		
		String workShopId = request.getParameter("workShopId");
		WorkShop workshop = session.get(WorkShop.class, Integer.parseInt(workShopId));
//		String targetGroup = request.getParameter("targetGroup");
		String description = request.getParameter("description");
		String placeAvailable = request.getParameter("placeAvailable");
		String maximumPlace = request.getParameter("maximumPlace");
		String roomDropbtn = request.getParameter("roomDropbtn");
//		workshop.setTargetGroup(targetGroup);
		workshop.setDescription(description);
		workshop.setPlaceAvailable(placeAvailable);
		workshop.setMaximumPlace(maximumPlace);
		Room room = new Room();
		room.setRoomId(Integer.parseInt(roomDropbtn));
		workshop.setRoom(room);
		session.update(workshop);
		
		request.getSession().setAttribute("workShop", workshop);
		ts.commit();
		request.getRequestDispatcher("detail.jsp").forward(request, response);
	}
	
	public void bookAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Transaction ts = session.beginTransaction();
		
		String stuid = request.getParameter("stuid");
		String workShopId = request.getParameter("workShopId");
		
		WorkShop workshop = session.get(WorkShop.class, Integer.parseInt(workShopId));
		Student stu = session.get(Student.class, Integer.parseInt(stuid));
		
		stu.setStudentId(Integer.parseInt(stuid));
		Set<Student> set = workshop.getStudents();
		set.add(stu);
		if(set.size()>=35){
//			Set<WaitingList> waitset = stu.getWaitingLists();
//			WaitingList waiting = new WaitingList();
//			waiting.setFirstName(stu.getFirstName());
//			waiting.setLastName(stu.getLastName());
//			waiting.setWorkShopId(workShopId);
//			session.save(waiting);
//			waitset.add(waiting);
//			stu.setWaitingLists(waitset);
//			session.update(stu);
		}else{
			workshop.setStudents(set);
			Set<Attendance> attset = workshop.getAttendances();
			Attendance attendance = new Attendance();
			attendance.setLastName(stu.getLastName());
			attendance.setFirstName(stu.getFirstName());
			attendance.setDate(new Date());
			attendance.setStudent(stu);
			attendance.setWorkShop(workshop);
			attset.add(attendance);
			
			session.save(attendance);
			workshop.setAttendances(attset);
			
			session.save(workshop);
		}
		
		workshop = session.get(WorkShop.class, Integer.parseInt(workShopId));
		request.getSession().setAttribute("workShop", workshop);
		
		String hql="from WaitingList";
		List<WaitingList> waitingList = session.createQuery(hql).list();
		
		
//		for(WaitingList wait : waitingList){
//			if(wait.getWorkShopId().equals(workShopId)){
//				request.setAttribute("waiting", wait.getStudents());
//				break;
//			}
//		}
		
		ts.commit();
		request.getRequestDispatcher("detail.jsp").forward(request,response);
	}
	
	public void editAttendance(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Transaction ts = session.beginTransaction();
		try {
			String studentListId = request.getParameter("studentListId");
			String isPresent = request.getParameter("isPresent");
			System.out.println("学生表id"+studentListId);
			
			String hql="from StudentList where studentListId=?";
			StudentList student = (StudentList)session.createQuery(hql).setParameter(0, Integer.parseInt(studentListId)).uniqueResult();
			student.setIsPresent(isPresent);
			
			if(isPresent.compareTo("yes")==0) {
				String receiver = student.getStudent().getEmail();
				String title = "inform";
				String content = student.getStudent().getStudentId() + " attendent " + student.getWorkShop().getName();
			
				try {
					SendMail.Email(receiver, title, content);
					student.setIsEmail("yes");
				} catch (AddressException e) {
					e.printStackTrace();
				} catch (MessagingException e) {
					e.printStackTrace();
				}
			}
			
			session.update(student);
			ts.commit();
			response.getWriter().print("success");			
		}catch(Exception e) {
			ts.rollback();
			e.printStackTrace();
		}
		
	}
	
	//获取session
	public Session getSession(){
		//1.加载主配置文件
		Configuration cfg = new Configuration().configure();
		//2.获取sessionFactory
		SessionFactory factory = cfg.buildSessionFactory();
		//3.获取session对象
		session = factory.openSession();
		return session;
	}
}
