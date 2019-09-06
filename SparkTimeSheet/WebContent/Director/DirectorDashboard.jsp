<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.login.util.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>DirectorDashboard</title>
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/AdminDashboard.css">
	
	 <link href='${pageContext.request.contextPath }/css/fullcalendar.min.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath }/css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<link href='${pageContext.request.contextPath }/css/bootstrap-combined.min.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath }/js/moment.min.js'></script>
<script src='${pageContext.request.contextPath }/js/lib/jquery.min.js'></script>
<script src='${pageContext.request.contextPath }/js/fullcalendar.min.js'></script>
<script src='${pageContext.request.contextPath }/js/bootstrap.min.js'></script>
<script src='${pageContext.request.contextPath }/js/gcal.js'></script>
	 
<script type="text/javascript">
$(document).ready(function() {
	  $('#calendar').fullCalendar({
	    header: {
	      left: 'prev,next today',
	      center: 'title',
	      right: 'month,basicWeek,basicDay',
	      defaultAllDay: true,
	    },
	    dayClick: function(date, jsEvent, view) {
	        var clickeddate = date.format();
	    	//alert(clickeddate);
	        window.location.href="${pageContext.request.contextPath}/Director/DirectorTask.jsp";

	    },
	    eventSources: [
	             {
	            	 url: '<%=request.getContextPath()%>/CalendarServlet',
	            	 color: 'green',
	            	 textColor:'white',
	             },
	             {
	            	 url: '<%=request.getContextPath()%>/TaskDirectorServlet',
	            	 color: '#007BC0',
	            	 textColor:'white',
	             }
	             ],
	    	
	             eventRender: function (event, element) { 
		            	
		             	element.popover({
		             		
		             		title:event.title,
		             		placement: event.start.day()>3?'left':'right',
		             		html:true,
		             		trigger: 'hover',
		             		content: event.msg
		             	});
		          },
		    	
	     
	  });
	});
</script>
<style>

  .fc-sun {
  	color: #190502;
  	background-color: #D17D6F;
  }
  .fc-sat{
  	color: #190502;
  	background-color: #D17D6F;
  }
  body {
    margin: 40px 10px;
    padding: 0;
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 900px;
    margin: 0 auto;
  }

</style>


</head>
<body>

<form name="form" action="<%=request.getContextPath()%>/DirectorDashboard" method="post">
<div class="container">
<header><img src="${pageContext.request.contextPath}/images/logo.png" alt="Avatar" class="avatar">
<tm style="font-family:calibri">TimeSheet Management System</tm>
  <user><%
		if (session != null) {
			if (session.getAttribute("Director") != null) {
				String name = (String) session.getAttribute("Director");
				session.setAttribute("Director",name);
				Connection con = null;
				con = DBConnection.createConnection();
				System.out.println("connected!.....");
				PreparedStatement pst=con.prepareStatement("SELECT employeename FROM users where employeeid=?");
				pst.setString(1, name);
				ResultSet rs=pst.executeQuery();
				rs.next();
				String ename=rs.getString(1);
				out.print("Welcome " + ename );
				//out.print("Welcome " + name +"   Director" );
				con.close();
				System.out.println("Connection closed");
			} else {
				response.sendRedirect("/TimeSheet/"); 
			}
		}
	%></user>
  </header>
  <div class="HorizontalNav">
<ul><li>
<a class="active" href="${pageContext.request.contextPath}/DirectorDashboard">Home</a></li>
  <li class="dropdown">
    <a href="${pageContext.request.contextPath}/Director/DirectorTask.jsp" class="dropbtn">Task</a>
    <div class="dropdown-content">
      <a href="${pageContext.request.contextPath}/Director/DirectorTask.jsp">Create Task</a>
      <a href="${pageContext.request.contextPath}/Director/ViewDirTask.jsp">Display Task </a>
                  <a href="${pageContext.request.contextPath}/Director/DirectorResubmit.jsp">Resubmit </a>
      
      </div>
  </li>
   <li><a href="${pageContext.request.contextPath}/Director/Approval.jsp">Approval</a></li>
    <li><a  href="${pageContext.request.contextPath}/Director/DirectorReport.jsp">Reports</a></li>
     <li style="float:right"><a href="<%=request.getContextPath()%>/LogoutServlet">Logout</a></li>
</ul>
</div>
 <div style="padding:1px 16px;height:100%;margin-top:30px;">
<center>
<article>
<div id="calendar"></div>
<table align="left" cellpadding="3" cellspacing="3" width="100%" border="0">
<tr>
<td><div class="box red"></td><td>Weekly Off</div></article></center></td>&nbsp;
<td><div class="box darkGreen"></td><td>Paid Holiday</td></div>&nbsp;
<td><div class="box blue"></td><td>Current date</td></div>&nbsp;
<td><div class="box white"></td><td>Working Days</td></div>&nbsp;

</tr>
</table>
</article></center>
 </div>
</div>
</form>
</body>
</html>