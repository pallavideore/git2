<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page import="java.sql.*" %>
    <%@ page import="com.login.util.DBConnection" %>
<%ResultSet resultset =null;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DeleteDepartment</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/AdminDashboard.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/JSFormValidation.css">
<style type="text/css">
input[type=button] {
	background-color: #007BC0;
	color: white;
}

input[type=submit] {
	background-color: #007BC0;
	color: white;
}

h1 {
	font-family: Calibri;
	color: #106E9B;
}

body {
	font-family: Calibri;
}
</style>
<!-- date picker -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://cdn.jsdelivr.net/webshim/1.12.4/extras/modernizr-custom.js"></script>
<script src="http://cdn.jsdelivr.net/webshim/1.12.4/polyfiller.js"></script>
<script>
    webshims.setOptions('waitReady', false);
    webshims.setOptions('forms-ext', {
        type : 'date'
    });
    webshims.setOptions('forms-ext', {
        type : 'time'
    });
    webshims.polyfill('forms forms-ext');
  
</script>
</head>
<body>
<%
Connection con = null;
con = DBConnection.createConnection();
    try{
    	
		response.setContentType("text/html");
	
 Statement statement = con.createStatement() ;
        resultset =statement.executeQuery("select Department from department order by Department") ;
%>
	<div class="container">
<header><img src="${pageContext.request.contextPath}/images/logo.png" alt="Avatar" class="avatar">
<tm style="font-family:calibri">TimeSheet Management System</tm>
  <user><%
		if (session != null) {
			if (session.getAttribute("Admin") != null) {
				String name = (String) session.getAttribute("Admin");
				session.setAttribute("Admin",name);
				//Connection con1 = null;
				con = DBConnection.createConnection();
				System.out.println("connected!.....");
				PreparedStatement pst=con.prepareStatement("SELECT employeename FROM users where employeeid=?");
				pst.setString(1, name);
				ResultSet rs=pst.executeQuery();
				rs.next();
				String ename=rs.getString(1);
				out.print("Welcome " + ename );
				
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
		<div style="align: center; height: 100%;">
			<center>
				<article>
				
			  	<form method="post" name="frm" action="<%=request.getContextPath()%>/DeleteDepartment" onsubmit="return validate();">
					<h1>Delete Department</h1>
						<br>
						<br>
					
					<table border="1" bordercolor="#C0C0C0" align="centre" cellpadding="4" cellspacing="4" width="25%">
						<tr>
							<td ><b>Department:<span class="required">*</span></b></td><td><select name="Department" placeholder="select department" style="width:205px">
							 <%  while(resultset.next()){ %>
							
            <option><%= resultset.getString(1)%></option>
           
        <% } %>
        <%
//**Should I input the codes here?**
        }
        catch(Exception e)
        {
             out.println("wrong entry"+e);
        }
    finally{
    	con.close();
    	System.out.println("Db disconnected in UI");
    }
%>
    </select></td>
							
					</table>
					<br>
					<span><input type="submit" value="Delete" style="width:80px;height:32px;background-color:#007BC0;color:white"  align="middle" onclick="if (confirm('Are you sure you want to delete?')){form.action='<%=request.getContextPath()%>/DeleteDepartment'}else { return false; };" /></span>
					
					<br> <br>
					
				</form>
				
				</article>
			</center>
		</div>
	</div>
</body>
</html>