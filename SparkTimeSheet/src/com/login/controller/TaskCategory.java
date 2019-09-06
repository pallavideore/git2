package com.login.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;


import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.login.util.DBConnection;


@WebServlet("/TaskCategory")
public class TaskCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public TaskCategory() {
        super();
        // TODO Auto-generated constructor stub
    }

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection con = null;
		con = DBConnection.createConnection();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String  taskCategory  = request.getParameter("taskCategory");
		
		System.out.println("MySQL Connect Example.");
		// validate given input
		
				if (taskCategory.isEmpty()) {
		     	   RequestDispatcher rd=request.getRequestDispatcher("/Admin/TaskCategory.jsp");
						rd.include(request, response);
						//out.println("<font color=red>Please fill all the fields</font>");
						
					} else {
				


			try
			{
				
				 String query = "insert into taskCatList values(?)";
				 PreparedStatement ps = con.prepareStatement(query); // generates sql query
				 ps.setString(1, taskCategory);
				 int i= ps.executeUpdate();
		           if(i!=0)    {
		        	   RequestDispatcher rd=request.getRequestDispatcher("/Admin/TaskCategory.jsp");
						rd.include(request, response);
						out.println("<h4 style='color:red;margin-left:400px;margin-top:-70px;'>Added " + taskCategory + " Successfully...</h4>");
	            }
	            else    {
	            	 RequestDispatcher rd=request.getRequestDispatcher("/Admin/TaskCategory.jsp");
						rd.include(request, response);
	                out.println("<h4 style='color:red;margin-left:400px;margin-top:-70px;'>Saved " + taskCategory+ " Data failed</h4>");
	            }
				 System.out.println("query " + query);
				//out.println("query " + query);
				 
				ps.close();
				System.out.println("Disconnected from database");
			} catch (Exception e) {
				e.printStackTrace();
				 RequestDispatcher rd=request.getRequestDispatcher("/Admin/TaskCategory.jsp");
					rd.include(request, response);
					out.println("<h4 style='color:red;margin-left:400px;margin-top:-70px;'>" + taskCategory+ " Already Exist</h4>");
			}
			finally{
				try {
					con.close();
					System.out.println("Connection close------------->");
					System.out.println("In Finally Block------------>");
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
		}
	}

	}


