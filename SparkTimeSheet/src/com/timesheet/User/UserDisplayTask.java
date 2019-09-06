package com.timesheet.User;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.login.controller.AdminAddTask;
import com.login.util.DBConnection;

/**
 * Servlet implementation class UserDisplayTask
 */
@WebServlet("/UserDisplayTask")
public class UserDisplayTask extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String mydate = null;
	public float  sum = 0;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserDisplayTask() {
        super();
        // TODO Auto-generated constructor stub
    }

	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		Connection con = null;
   	 con = DBConnection.createConnection();
   	 System.out.println("connected!.....");
        
          try {
        	 System.out.println("inside User display");
        	 Statement st=null;
        	 
        	 String employeeID  = (String) request.getSession().getAttribute("User");
             String date = request.getParameter("date");
             mydate = date;
             if(mydate!= null){
            	 AdminAddTask.mydate = mydate;
            	 System.out.println( "mydate is " + mydate );
            	String Test = null;
     			request.setAttribute(mydate, Test);
     			System.out.println(Test + "/" + mydate);
             }
             SimpleDateFormat fromUser = new SimpleDateFormat("MM/dd/yyyy");
				SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
				String reformattedStr = null;
				try {

				    reformattedStr = myFormat.format(fromUser.parse(date));
				} catch (ParseException e) {
				    e.printStackTrace();
				}
				request.setAttribute("date",date);
             System.out.println(date);
            
             ArrayList al = null;
             ArrayList pid_list = new ArrayList();
            
           
          
             String query = "select taskId,date,ProjName,proid,TaskCat,description,hours from task where date='" + reformattedStr + "' AND EmployeeID='" + employeeID + "' AND approval='Pending'";
             System.out.println("query " + query); 
              st = con.createStatement();
             ResultSet rs = st.executeQuery(query);
             System.out.println(rs);
             sum = 0;
             while (rs.next()) {
                 al = new ArrayList();
                 al.add(rs.getString(1));
                 al.add(rs.getString(2));
                 al.add(rs.getString(3));
                 al.add(rs.getString(4));
                 al.add(rs.getString(5));
                 al.add(rs.getString(6));
                 al.add(rs.getString(7));
                 System.out.println("al :: " + al);
                 pid_list.add(al);
                 
            
                 sum = sum + Float.parseFloat(rs.getString(7));
                
             }
             
             
             request.setAttribute("piList", pid_list);
             request.setAttribute("AgencyRating", sum);
             
             System.out.println("Summation of hours is --===>" + sum);
             Statement stt =con.createStatement();
				//stt.executeUpdate("Update task set sum='" + sum + "'where date='" + reformattedStr + "' AND EmployeeID='" + employeeID + "' ");
				System.out.println("Updated successfully");
             RequestDispatcher view = request.getRequestDispatcher("/JSP/emp_event.jsp");
             view.include(request, response);
             rs.close();
             st.close();
            
           
         } catch (Exception e) {
             e.printStackTrace();
         }
          finally{
        	  try {
				con.close();
				System.out.println("Disconnected!");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
              
          }
     }

     @Override
     public String getServletInfo() {
         return "getting records from database through servlet controller";
     }// </editor-fold>
	}


