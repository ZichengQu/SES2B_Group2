package com.dao;

import java.awt.Component;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import javax.swing.JFileChooser;
import javax.swing.JPanel;
import javax.swing.filechooser.FileNameExtensionFilter;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.bean.Student;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;
import com.util.HibernateUtil;

public class FromDbToExcel extends JPanel{
	public final static String url="jdbc:mysql://utshelpdb.cvdpbjinsegf.us-east-2.rds.amazonaws.com:3306/uts_help";
	public final static String user="admin";
	public final static String password="thisadmin";
	
	
	
    public static void download(String table,String sql) throws Exception {
    	
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=(Connection) DriverManager.getConnection(url,user,password);
            
            Workbook book = new HSSFWorkbook();
            //String Table_Name="Report";
            Sheet sheet=book.createSheet(table);
            
            Statement st = (Statement) con.createStatement();
           // Integer id = 111;
           // sql="select studentId,sessionId from session where studentId="+id;
            //System.out.println("Testttttttttttttt");
            ResultSet rs=st.executeQuery(sql);
            Row row1=sheet.createRow(0);
            ResultSetMetaData rsmd=rs.getMetaData();
            int colnum = rsmd.getColumnCount();
            
            for (int i = 1; i <= colnum; i++) {
                String name = rsmd.getColumnName(i);
                Cell cell=row1.createCell(i-1);
                cell.setCellValue(name);
            }
            int idx=1;
            while(rs.next()) {
            	Row row=sheet.createRow(idx++);
            	for(int i=1;i<=colnum;i++) {
            		String str=rs.getString(i);
            		Cell cell=row.createCell(i-1);
            		cell.setCellValue(str);
            	}
            }
           
               
            
            
            String filePath = "";
            //System.out.println("fileChooser");
        	JFileChooser fileChooser = new JFileChooser(new File("C:\\"));
        	fileChooser.setSelectedFile(new File(table));
        	fileChooser.setDialogTitle("Save Report");
        	
        	//System.out.println("AfterFileChooser");
            FileNameExtensionFilter filter = new FileNameExtensionFilter("Excel", "xls");
            fileChooser.setFileFilter(filter);
            int returnVal = fileChooser.showSaveDialog(null);
            if(returnVal == JFileChooser.APPROVE_OPTION) {
            	
            	filePath = fileChooser.getSelectedFile().getPath();
            	System.out.println("You chose to save this file: " + filePath );
            }
            else if(returnVal == JFileChooser.CANCEL_OPTION){
            	System.out.println("CANCEL OPTION CHOSEN");
            }
            
            book.write( new FileOutputStream(filePath + ".xls"));
    	}
    
    
    public  static Student getStudent(String id) {
    	Session session = HibernateUtil.getCurrentSession();
    	Transaction transaction = session.beginTransaction();
    	Student student=session.get(Student.class, id);
    	transaction.commit();
    	return student;
    	
    }
    
}
