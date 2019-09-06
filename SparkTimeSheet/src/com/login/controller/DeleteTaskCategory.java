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


@WebServlet("/DeleteTaskCategory")
public class DeleteTaskCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;


	public DeleteTaskCategory() {
		super();
		// TODO Auto-generated constructor stub
	}



	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection con = null;
	
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String taskCategory  = request.getParameter("taskCategory");

		System.out.println("MySQL Connect Example.");
		con = DBConnection.createConnection();
		

		try
		{
		
			String deleteQuery = "DELETE FROM taskcatlist WHERE taskCategory = ?";
			PreparedStatement prpStat = con.prepareStatement(deleteQuery);
			
			prpStat.setString(1, taskCategory);
			
			System.out.println("prpStat :" + prpStat.toString());
			prpStat.executeUpdate();
			RequestDispatcher rd=request.getRequestDispatcher("/Admin/DeleteTaskCategory.jsp");
			rd.include(request, response);
			out.println("<h4 style='color:red;margin-left:400px;margin-top:-10px;'>" +taskCategory+ " Deleted Successfully!</h4>");
			
			prpStat.close();
			System.out.println("Disconnected from database");
		} catch (Exception e) {
			e.printStackTrace();
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
