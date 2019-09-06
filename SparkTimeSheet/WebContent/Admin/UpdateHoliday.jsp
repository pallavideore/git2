<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.login.util.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*" %>
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>UpdateHoliday</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/AdminDashboard.css">
 
 <script type="text/javascript" src='${pageContext.request.contextPath }/js/jquery-1.8.3.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath }/js/jquery-ui-1.10.2.custom.js'></script>
<link type="text/css" href='${pageContext.request.contextPath}/css/jquery-ui-1.10.2.custom.css' rel='stylesheet' />
   <style type="text/css">
 input[type=button]{
    background-color:  #007BC0;
    color: white;
    }
    input[type=submit]{
    background-color: #007BC0;
    color: white;
    }
#startdate
        {
          background:  url(https://i.imgur.com/u6upaAs.png) right no-repeat;
             padding-right: 10px;
            
            }
h1 {
	font-family: Calibri;
	color: #106E9B;
}

body {
	font-family: Calibri;
}
</style>




<script type="text/javascript">


$(document).ready(
        function() {
            $("#startdate").datepicker({
        
                changeMonth : true,
                changeYear : true,
                firstDay : 1,
                dateFormat : 'mm/dd/yy',
            })
           
        });



function validation2(){
var start = $('#startdate').datepicker('getDate');

 	        if(start == null){
 	        	alert("Please Enter the Start Date")
	            return false;
 	        }   
 	        else if(confirm("Are you sure you want to delete?"))  {
 	       	
 	       		return true;
 	        }else{
 	        	return false;
 	        }
      
	        	}
  
 




//////////////////////


//      
       
//        function validate()
//        {
//        	 var  sdate = document.frm.date.value;
//        	 var sdateAr=sdate.split("/");
//        	if(document.frm.date.value=="")
//        	{
       		
//        		alert("Please enter the date.");
//        		document.frm.date.focus();
//        		return false;
//        	}
//        	if(sdateAr.length!=3)
//        	{
//        		alert("Please enter valid Date in  mm/dd/yy format.");
//        		document.frm.date.value="";
//        		document.frm.date.focus();
//        		return false;
//        	}
       
//        }
      
   </script>
</head>
<body>
<form name="form"  method="post">
<div class="container">
<header><img src="${pageContext.request.contextPath}/images/logo.png" alt="Avatar" class="avatar">
<tm style="font-family:calibri">TimeSheet Management System</tm>
  <user><%
		if (session != null) {
			if (session.getAttribute("Admin") != null) {
				String name = (String) session.getAttribute("Admin");
				session.setAttribute("Admin",name);
				Connection con = null;
				con = DBConnection.createConnection();
				System.out.println("connected!.....");
				PreparedStatement pst=con.prepareStatement("SELECT employeename FROM users where employeeid=?");
				pst.setString(1, name);
				ResultSet rs=pst.executeQuery();
				rs.next();
				String ename=rs.getString(1);
				out.print("Welcome " + ename );

				con.close();
				System.out.println("Connection closed");
				//out.print("Welcome " + name +"   Admin" );
			} else {
				response.sendRedirect("/TimeSheet/");  			}
		}
	%></user>
  </header>
  <div class="HorizontalNav">
<ul>
<li><a class="active" href="${pageContext.request.contextPath}/AdminDashboard">Home</a></li>
  <li class="dropdown">
    <a href="${pageContext.request.contextPath}/Admin/AddTask.jsp" class="dropbtn">Task</a>
    <div class="dropdown-content">
      <a href="${pageContext.request.contextPath}/Admin/AddTask.jsp">Create Task</a>
      <a href="${pageContext.request.contextPath}/Admin/ViewTask.jsp">Display Task </a>
     <a href="${pageContext.request.contextPath}/Admin/TaskCategory.jsp">Add Task Category</a>
       <a href="${pageContext.request.contextPath}/Admin/DeleteTaskCategory.jsp">Delete Task Category</a>
      </div>
  </li>
   <li class="dropdown">
    <a href="${pageContext.request.contextPath}/Admin/AddProjects.jsp" class="dropbtn">Project</a>
    <div class="dropdown-content">
      <a href="${pageContext.request.contextPath}/Admin/AddProjects.jsp">Add Project</a>
      <a href="${pageContext.request.contextPath}/Admin/UpdateProjects.jsp">Update Project</a>
       <a href="${pageContext.request.contextPath}/Admin/ProjectType.jsp">Add Project Type</a>
        <a href="${pageContext.request.contextPath}/Admin/DeleteProjectType.jsp">Delete Project Type</a>
       
     </div>
  </li>
   <li class="dropdown">
    <a href="${pageContext.request.contextPath}/Admin/AddUsers.jsp" class="dropbtn">User</a>
    <div class="dropdown-content">
      <a href="${pageContext.request.contextPath}/Admin/AddUsers.jsp">Add User</a>
     <a href="<%=request.getContextPath()%>/Admin/UpdateUsers.jsp">Display User</a>
      
     </div>
  </li>
   <li class="dropdown">
    <a href="${pageContext.request.contextPath}/Admin/AddDepartment.jsp" class="dropbtn">Department</a>
    <div class="dropdown-content">
       <a href="${pageContext.request.contextPath}/Admin/AddDepartment.jsp">Add Department</a>
      <a href="${pageContext.request.contextPath}/Admin/DeleteDepartment.jsp">Delete Department</a>
     </div></li>
     <li class="dropdown">
    <a href="${pageContext.request.contextPath}/Admin/AddHolidays.jsp" class="dropbtn">Holiday</a>
    <div class="dropdown-content">
      <a href="${pageContext.request.contextPath}/Admin/AddHolidays.jsp">Add Holiday</a>
      <a href="${pageContext.request.contextPath}/Admin/UpdateHoliday.jsp">Display Holiday</a>
     </div></li>
     <li><a href="${pageContext.request.contextPath}/Admin/AdminReport.jsp">Report</a></li>
     
       <li style="float:right"><a href="<%=request.getContextPath()%>/LogoutServlet">Logout</a></li>
</ul>
</div>
 <div style="padding:1px 16px;height:100%;margin-top:50px;">
<center>
<article>

<label style="font-size:20px;align:left"><b>Select Date:</b></label>&nbsp;&nbsp;<input type="text" name="date" id="startdate" placeholder=" mm/dd/yy"  style="width:100px"; />&nbsp;&nbsp;&nbsp;&nbsp;


<span><input type="submit" value="Display" style="margin-left: 0%;width:80px;height:32px;background-color:#007BC0;color:white" onclick="form.action='<%=request.getContextPath()%>/UpdateHoliday';" />&nbsp;&nbsp;



<input type="submit" value="Delete" style="margin-left: 0%;width:80px;height:32px;background-color:#007BC0;color:white" onclick=" if( validation2(this)){form.action='<%=request.getContextPath()%>/DeleteHoliday' }else {return false;} " /></span>














<br><br><br><br>



<table align="center" cellpadding="6" cellspacing="6" width="50%" border="1">
<tr>
</tr>
	<tr style="color:#090C9B">
		<td><b>Date</b></td>
		<td><b>Description</b></td>
		</tr>
		 <%
                int count = 0;
                String color = "#F9EBB3";
                if (request.getAttribute("piList") != null) {
                    ArrayList al = (ArrayList) request.getAttribute("piList");
                    System.out.println(al);
                    Iterator itr = al.iterator();
                    while (itr.hasNext()) {

                        if ((count % 2) == 0) {
                            color = "#eeffee";
                        }
                        count++;
                        ArrayList pList = (ArrayList) itr.next();
            %>
            <tr style="background-color:<%=color%>;">
                <td><%=pList.get(0)%></td>
                <td><%=pList.get(1)%></td>
                 </tr>
            <%
                    }
                }
                if (count == 0) {
            %>
            <tr>
                <td colspan=4 align="center"
                    style="background-color:#eeffee"><b>No Record Found..</b></td>
            </tr>
            <%            }
            %>
	</table><br><br><br><br><br>
</article></center>
 </div>
</div>
</form>
</body>
</html>
</html>