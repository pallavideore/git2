package com.login.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.login.util.DBConnection;


@WebServlet("/AdminDeleteTask")
public class AdminDeleteTask extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String taskID;
	public static String Date; 

    public AdminDeleteTask() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String employeeID  = (String) request.getSession().getAttribute("Admin");

		Connection con = null;
		taskID = request.getParameter("taskid");
		Date = request.getParameter("date");
		System.out.println("Here task id is>>>"+taskID);
		System.out.println("Here task id is>>>"+Date);
		System.out.println("Here employee id is>>>"+employeeID);


		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		// String TaskID = request.getParameter("taskId");
		//System.out.println(TaskID);
		System.out.println("MySQL Connect Example.");

		con = DBConnection.createConnection();

		try
		{
			double hours = 0;
			double result1 = 0;

			double sum= 0;
			Statement st=con.createStatement();

			String query= "select hours,sum from task where taskId ="+taskID+"";
			System.out.println("Retreive hours from database...."+query);
			
			
			ResultSet r2= st.executeQuery(query);
			

			while(r2.next()){
				
				System.out.println(r2.getString("hours"));
				System.out.println(r2.getString("sum"));
				hours = Double.parseDouble(r2.getString("hours"));
				
				
				
				sum =Double.parseDouble(r2.getString("sum"));
				System.out.println("hours....>"+hours);
				
				System.out.println("Toatl hours....>"+sum);
				
				
				//double result1 = 0;
				result1=sum-hours;
				
			}
			System.out.println("Here the Substraction  is...>>"+result1);
			
			request.setAttribute("Totalhour",+result1);
			System.out.println(" Substraction..."+result1 );
			
			
			
			Statement supdate = con.createStatement();
			
			
			
			supdate.executeUpdate("Update task set sum="+result1+" where date='"+Date+"' and EmployeeID="+employeeID+"");
			
			request.setAttribute("Totalhour",result1);
			
			
			
			
				System.out.println("Updated successfully");
		

			String deleteQuery = "DELETE FROM task WHERE taskId = ?";
			PreparedStatement prpStat = con.prepareStatement(deleteQuery);
			
			prpStat.setString(1, taskID);
			
			System.out.println("prpStat :" + prpStat.toString());
			prpStat.executeUpdate();
			RequestDispatcher rd=request.getRequestDispatcher("/Admin/AddTask.jsp");
			rd.include(request, response);
			out.println("<h4 style='color:red;margin-left:400px;margin-top:-190px;'>" +taskID+ " Deleted Successfully!</h4>");
			
			prpStat.close();
			
			System.out.println("Disconnected from database");
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			try {
				System.out.println("In finally block");
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}



	}
