<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
       <%@page import="java.sql.*"%>
    <%@page language="java"%>    
     <%@ page import="java.util.*" %>
    <%@ page import="com.login.util.DBConnection" %>
<%ResultSet resultset1 =null;%>
<%ResultSet resultset2 =null;%>
<%ResultSet resultset =null;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; ">
<title>UpdateProject</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/AdminDashboard.css">
 <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/> 
   <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script> 
   <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/JSFormValidation.css">
    
    <script>
           
            function validate() {
      
        if (document.frm.CustomerName.value == "")  {
            alert("Please Enter Customer Name.");
            document.frm.Description.focus();
            return false;
        }
      
         if (document.frm.ID.value == "") {
                alert("Please Enter Project ID.");
                document.frm.Description.focus();
                return false;
            }
          
        if (document.frm.Type.value == "") {
             alert("Please Select Project Type");
             document.frm.Description.focus();
             return false;
         }
        
        
         if (document.frm.ProductManager.value == "") {
             alert("Please Select Product Manager");
             document.frm.Description.focus();
             return false;
         }
        
        
         if (document.frm.StartDate.value == null) {
             alert("Please Enter Start Date");
             document.frm.Description.focus();
             return false;
         }
        
         if (document.frm.EndDate.value == null) {
             alert("Please Enter End Date");
             document.frm.Description.focus();
             return false;
         }
        
        
        
         return true;
        
        
        }
        </script>
    
    <style type="text/css">
    input[type=button]{
    background-color:  #007BC0;
    color: white;
    }
    input[type=submit]{
    background-color: #007BC0;
    color: white;
    }
    h1{
    font-family: Calibri;
    color: #106E9B;
    }
    body {
  font-family: Calibri;
}
#startdate
        {
             background:  url(https://i.imgur.com/u6upaAs.png) right no-repeat;
             
             padding-right: 10px;
            }
 #enddate
        {
           background:  url(https://i.imgur.com/u6upaAs.png) right no-repeat;
            
             padding-right: 10px;
            }
    </style>
    
   
</head>
<body>

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
				out.print("Welcome " + ename);

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
 <div style="align:center;height:100%;">
<center>
<article>
<form method="post" name="frm" action="<%=request.getContextPath()%>/AddProject" onsubmit="return validate(this);">
<table border="1" bordercolor="#C0C0C0" cellspacing="4" cellpadding="4" width="40%" align="center" >
<h1>Update Project </h1>
<tr bordercolor=" #C0C0C0"><th align="center" colspan="2" style="text-align: center;color: #106E9B; font-size: 20px !important;"><b>Customer</b></th></tr>
<tr bordercolor=" #C0C0C0"><td><b>Customer Name:<span class="required">*</span></b></td><td><input type="text" name="CustomerName" value="<%=request.getAttribute("custName")%>" onkeypress="return isAlfa(event)" style="width:200px"></td></tr>
<tr  bordercolor=" #C0C0C0"><th align="center" colspan="2" style="text-align: center;color: #106E9B; bordercolor:#E0E0E0;font-size: 20px !important;"><b>Project</b></th></tr>
<tr  bordercolor=" #C0C0C0"><td ><b>Project ID:<span class="required">*</span></b></td><td><input type="text" name="ID" value="<%=request.getAttribute("projId")%>" onkeypress="return isNumber2(event)" style="width:200px"></td></tr>
<tr  bordercolor=" #C0C0C0"><td><b>Project Name:<span class="required">*</span></b></td><td>
 <input type="text" name="ProjName"  value="<%=request.getAttribute("projName")%>" style="width:200px" readonly="readonly">
<tr  bordercolor=" #C0C0C0"><td style="width:200px"><b>Project Description:</b></td><td>
<input type="text" name="Description"  value="<%=request.getAttribute("tdes")%>" style="width:200px">
</textarea></td></tr>
<tr  bordercolor=" #C0C0C0"><td ><b>Project Type:<span class="required">*</span></b></td><td><select name="Type" style="width:202px"  >
 <OPTION value="<%=request.getAttribute("type")%>"><%=request.getAttribute("type")%></OPTION>
   <%
   Connection con = null;
 con = DBConnection.createConnection();
    try{
        
        response.setContentType("text/html");
   
//Class.forName("com.mysql.jdbc.Driver").newInstance();
//Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/customers?user=root&password=Datamato@123");
        Statement statement = con.createStatement() ;
        resultset =statement.executeQuery("select ProjectType from addprojecttype") ;
%>
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
   
%> </select></td></tr>
    <tr  bordercolor=" #C0C0C0"><td ><b>Product Managers:<span class="required">*</span></b></td><td><select name="Product Manager" style="width:202px">
    <OPTION value="<%=request.getAttribute("ProductMang")%>"><%=request.getAttribute("ProductMang")%></OPTION>
    <%
    try{
        
        response.setContentType("text/html");
    
//Class.forName("com.mysql.jdbc.Driver").newInstance();
//Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/customers?user=root&password=Datamato@123");
        Statement statement = con.createStatement() ;
        resultset =statement.executeQuery("select EmployeeName from users") ;
%>
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
    	System.out.println("Disconnected in UI");
    }
%>
    </select></td></tr>
      <tr bordercolor=" #C0C0C0"><td ><b>Planned Start Date:<span class="required">*</span></b></td><td><input type="text" name="StartDate" id="startdate" value="<%=request.getAttribute("startDate")%>"  style="width:190px"  required name="title";/>
 <tr bordercolor=" #C0C0C0"> <td><b>Planned End Date:<span class="required">*</span></b></td><td><input type="text" name="EndDate" id="enddate" value="<%=request.getAttribute("endDate")%>"  style="width:190px"  required name="title";/>
<script>
    src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
<!-- for date picker -->
<script>
    src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<!-- for date picker -->
<script>
$(document).ready(function() {

$( "#startdate,#enddate" ).datepicker({
changeMonth: true,
changeYear: true,
firstDay: 1,
dateFormat: 'mm/dd/yy',
})

$( "#startdate" ).datepicker({ dateFormat: 'mm/dd/yy' });
$( "#enddate" ).datepicker({ dateFormat: 'mm/dd/yy' });

$('#enddate').change(function() {
var start = $('#startdate').datepicker('getDate');
var end   = $('#enddate').datepicker('getDate');

if(start==null){
	alert("Please Enter the Start Date")
	$('#startdate').val("");
	$('#enddate').val("");
	$('#days').val("");}
	
   else if (start<end) {
 
	var days   = (end - start)/1000/60/60/24;
	$('#days').val(days)
	
}

 else {
	
alert ("End Date must be later than Start Date!");
$('#startdate').val("");
$('#enddate').val("");
$('#days').val("");
}
}
); //end change function
}); //end ready
 function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode< 48 || charCode>57) && (charCode > 32 && (charCode< 65 || charCode >95) && (charCode< 97 || charCode >122))) {
        alert("Please Enter valid ID");
          // document.getElementById('elementid').value = "";
        return false;
    }
    return true;
}
 function isNumber2(evt) {
	    evt = (evt) ? evt : window.event;
	    var charCode = (evt.which) ? evt.which : evt.keyCode;
	    if (charCode > 31 && (charCode< 48 || charCode>57) && (charCode > 31 && (charCode< 65 || charCode >95) && (charCode< 97 || charCode >122))) {
	        alert("Please Enter valid ID");
	          // document.getElementById('elementid').value = "";
	        return false;
	    }
	    return true;
	}
function isAlfa(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
   // if(!(inputValue >= 65 && inputValue <= 120) && (inputValue != 32 && inputValue != 0)){
    if (charCode > 31 && (charCode< 48 || charCode>57) && (charCode > 32 && (charCode< 65 || charCode >95) && (charCode< 97 || charCode >122))) {
        alert("Please Enter valid Name");
           //document.getElementById('elementid').value = "";
       return false;
         }
    return true;
} 
</script>
 <tr  bordercolor=" #C0C0C0"><td colspan=2 align="center"><input type="submit" name="submit" value="Update"  onclick="form.action='<%=request.getContextPath()%>/EditProject';" ></td>
</tr>
</table>
<br><br><br><br></form>
</article></center>
 </div>
</div>
</body>
</html>