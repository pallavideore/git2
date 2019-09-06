package com.timesheet.Manager;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.login.util.DBConnection;

/**
 * Servlet implementation class ManagerTaskServlet
 */
@WebServlet("/ManagerTaskServlet")
public class ManagerTaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public ManagerTaskServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("inside task servlet");
		 Connection con = null;
    	 con = DBConnection.createConnection();
		try
	        {
	        	
	        	 Statement stt = con.createStatement();
	           
	            /**
	             * Query
	             **/
	        	 String employeeID  = (String) request.getSession().getAttribute("Manager");
	        	 PreparedStatement statement = con.prepareStatement("select * from task where EmployeeID = ?");    
	        	 statement.setString(1, employeeID);    
	        	 ResultSet res = statement.executeQuery();
	          //  ResultSet res = stt.executeQuery("SELECT * FROM task where EmployeeID=+employeeID");
	            
	            JSONArray array = new JSONArray();
	            
	            while (res.next())
	            {
	            	JSONObject jObj = new JSONObject();
	            	 
	                 String date_json = res.getString("date");
	                 String sum_json = "Hours:" + res.getString("hours");
	                 String msg = "Project Name:" + res.getString("ProjName") + "Task category:" + res.getString("TaskCat") + "Description:" +res.getString("description");
	                 
	                 jObj.put("title", sum_json);
	                 jObj.put("date", date_json);
	                 jObj.put("msg", msg);
	                 
	                 array.put(jObj);
	                 //System.out.println("print object");              
	            }
	            System.out.println(array);
	            //System.out.println(jObj);
	            
	            
	            JSONObject Ob = new JSONObject();
	            try {
	                Ob.put("result", array);
	            } catch (Exception e) {
	             
	            e.printStackTrace();
	            }
	            System.out.println(Ob);
	            response.setContentType("application/json");
	         // Get the printwriter object from response to write the required json object to the output stream      
	         PrintWriter out = response.getWriter();
	         // Assuming your json object is *jsonObject*, perform the following, it will return your json object  
	         out.print(array);
	         out.flush();
	            //PrintWriter pw = response.getWriter();
	            //pw.write(Ob.toString());
	            
	            
	         // Write JSON string.
	    		//response.setContentType("application/json");
	    		//response.setCharacterEncoding("UTF-8");
	    		//response.getWriter().pw(Ob);
	            
	            res.close();
	            stt.close();
	            
	        }
	        catch (Exception e)
	        {
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

	


