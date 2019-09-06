<%@page import="com.login.controller.AdminDisplayTask"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
 <%@ page import="com.login.util.DBConnection" %>
<%ResultSet resultset1 =null;%>
<%ResultSet resultset2 =null;%>
<%ResultSet resultset =null;%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "DTD/xhtml1-strict.dtd">
<html>
<head>
<meta charset="utf-8">

<title>AddTask</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/AdminDashboard.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/JSFormValidation.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<script src='http://code.jquery.com/jquery.min.js'></script>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<TITLE>Add/Remove dynamic rows in HTML table</TITLE>
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
             background-repeat: no-repeat;
             padding-right: 10px;
            }
    </style>
<%
Connection con = null;
con = DBConnection.createConnection();
try{
	 
    Statement statement1 = con.createStatement() ;
    Statement statement2 = con.createStatement() ;
    Statement statement = con.createStatement() ;
    
   
    resultset1 =statement1.executeQuery("select * from myproject order by ProjName") ;   
    resultset2 =statement2.executeQuery("select * from myproject order by ProjName") ;  
LinkedHashMap<String,String> resultMap = new LinkedHashMap<String,String>();
while(resultset1.next()){
	resultMap.put(resultset1.getString(2),resultset1.getString(3));
}
Set<String> keys = resultMap.keySet();
%>
<SCRIPT language="javascript">


//////////////////////////////////////
function validatehours(){
    var x = document.getElementById("v1").value;
  var inputs = document.getElementsByTagName('input');
  var stat=0;
  if(x>24)
  	{
  alert("Total hours should not be greater than 24 hours");
  stat=1;
  return false;
  }else{
   for(var i = 0; i < inputs.length; ++i)
      if(inputs[i].type === 'text')
   	   {
   	   if(inputs[i].value == ""||inputs[i].value ==null ||inputs[i].value=="0" ) 
         {
            alert("Please Fill All the Manadotory Fields"); 
            stat=1;
           return false;
           }
           }
       }
  if(stat==0){
	   return true;
  }
}
 


 function calculateSum() {

        var sum = 0;

        //iterate through each textboxes and add the values

        $(".code").each(function() {

            //add only if the value is number

            if (!isNaN(this.value) && this.value.length != 0) {

                sum += parseFloat(this.value);

            }

        });

        //.toFixed() method will roundoff the final sum to 2 decimal places

        $("#sum").html(sum.toFixed(2));
        (document.getElementById('v1').value=sum).toFixed(2);
    }

/////////////////////////////////////
    var date = new Date();

    document.getElementById("demo").value = (date.getMonth() + 1) + '/'
            + date.getDate() + '/' + date.getFullYear();

    function addRow(tableID) {

    	var table = document.getElementById(tableID);
        var rowCount = table.rows.length;
        var row = table.insertRow(rowCount);
        var colCount = table.rows[0].cells.length;
       

        for (var i = 0; i < colCount; i++) {
        	
            var newcell = row.insertCell(i);

            newcell.innerHTML = table.rows[0].cells[i].innerHTML;
           
        }
        
        $(".slt_prod").on("change",function(){  
			$(this).closest('tr').find('.txt_prod').val($(this).val());
		});  
		$(".slt_prod").trigger("change");
    }   

    function deleteRow(tableID) {

        try {

            var table = document.getElementById(tableID);
           

            var rowCount = table.rows.length;

            for (var i = 0; i < rowCount; i++) {

                var row = table.rows[i];

                var chkbox = row.cells[0].childNodes[0];

                if (null != chkbox && true == chkbox.checked) {

                    if (rowCount <= 1) {

                        alert("Cannot delete all the Task.");

                        break;

                    }

                    table.deleteRow(i);

                    rowCount--;

                    i--;
                 
                }
                
            }
            
            var sum = 0;

            //iterate through each textboxes and add the values

            $(".code").each(function() {

                //add only if the value is number

                if (!isNaN(this.value) && this.value.length != 0) {

                    sum += parseFloat(this.value);

                }

            });
            $("#sum").html(sum.toFixed(2));
            (document.getElementById('v1').value=sum).toFixed(2);

        } catch (e) {

            alert(e);

        }

    }

    //Calender Date

    $('#cmd')
            .click(
                    function() {

                        $('#content')
                                .append(
                                        '<br>a datepicker <input class="datepicker_recurring_start"/>');

                    });

    $('body').on('focus', ".datepicker_recurring_start", function() {

        $(this).datepicker();

    });

    //cal sum

    $(document).ready(function() {

        //iterate through each textboxes and add keyup

        //handler to trigger sum event

        $(".code").each(function() {
            $(this).keyup(function() {
                calculateSum();

            });

        });
        
        $(".code").each(function() {
            $(this).keyup(function() {
                calculateSum();

            });

        });
        

    });
   
    //set date

    function myFunction() {

        var d = new Date();

        var n = d.getDate();

        document.getElementById("demo").innerHTML = n;

    }
    //Check all checkboxes
function toggle(source) {
    var checkboxes = document.querySelectorAll('input[type="checkbox"]');
    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i] != source)
            checkboxes[i].checked = source.checked;
    }
}

    // enable button
    
 function handleChange(input) {
        var x = document.getElementById("hours").value;
        if (x <8 || x == null) {
            alert("Total Hours should be greater than or equal to 8");
            return false;
        }
        
        
        
        
        return true;
    }
 function validate(form) {

	   var x = document.getElementById("v1").value;
        if (x >8) {
	        return confirm('Are you sure to add more than 8 hours for this task?');
	    }
	}

 function populateCustomerId(){
	    var selectBox = document.getElementById('selectBox');

	    /* selected value of dropdown */
	    var selectedCustomerId = selectBox.options[selectBox.selectedIndex].value;

	    /* selected value set to input field */
	    document.getElementById('proId').value = selectedCustomerId; 
	} 
 
  // Current Date in textbox
 function addDate(){
	 date = new Date();
	 var month = date.getMonth()+1;
	 var day = date.getDate();
	 var year = date.getFullYear();

	 if (document.getElementById('startdate').value == ''){
	// document.getElementById('startdate').value = day + '-' + month + '-' + year;
		 document.getElementById('startdate').value = month + '/' + day + '/' + year;
	 }
	 }
  
  
  </script>
  

</head>
<body onload="addDate();">
<form name="frm"  method="post">
    <div class="container">
<header><img src="${pageContext.request.contextPath}/images/logo.png" alt="Avatar" class="avatar">
<tm style="font-family:calibri">TimeSheet Management System</tm>
  <user><%
		if (session != null) {
			if (session.getAttribute("Manager") != null) {
				String name = (String) session.getAttribute("Manager");
				session.setAttribute("Manager",name);

			
				con = DBConnection.createConnection();
				System.out.println("connected!.....");
				PreparedStatement pst=con.prepareStatement("SELECT employeename FROM users where employeeid=?");
				pst.setString(1, name);
				ResultSet rs=pst.executeQuery();
				rs.next();
				String ename=rs.getString(1);
				out.print("Welcome " + ename);
				//con1.close();
			} else {
				response.sendRedirect("/TimeSheet/");  			}
		}
	%></user>
  </header>
  <div class="HorizontalNav">
<ul><li>
<a class="active" href="${pageContext.request.contextPath}/ManagerDashboard">Home</a></li>
  <li class="dropdown">
    <a href="${pageContext.request.contextPath}/ProjMag/CreateTask.jsp" class="dropbtn">Task</a>
    <div class="dropdown-content">
      <a href="${pageContext.request.contextPath}/ProjMag/CreateTask.jsp">Create Task</a>
      <a href="${pageContext.request.contextPath}/ProjMag/PmViewTask.jsp">Display Task </a>
      <a href="${pageContext.request.contextPath}/ProjMag/ManagerResubmit.jsp">Resubmit</a>
      </div>
  </li>
  <li><a href="${pageContext.request.contextPath}/ProjMag/Approval.jsp">Approval</a></li>
 <li><a href="${pageContext.request.contextPath}/ProjMag/ManagerReport.jsp">Report</a></li>
 <li style="float:right"><a href="<%=request.getContextPath()%>/LogoutServlet">Logout</a></li>
</ul>
</div>
            <div  style="  height: 100%; margin-top: 40px;">
           <span style=" margin-left:5px;margin-top:80px;width:222px;fontfamily:Calibri;color:#007BC0;bordercolor:rgb(211,211,211)">Date:</span> <input type="text" id="startdate" value="<%=request.getAttribute("date")%>" name="date" required name="title"/>
           <span><input type="submit" value="Display" style="margin-left: 0%;width:80px;height:32px;background-color:#007BC0;color:white" onclick="form.action='<%=request.getContextPath()%>/ManagerDisplayTask';" /></span> 

   <script type="text/javascript" src='${pageContext.request.contextPath }/js/jquery-1.8.3.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath }/js/jquery-ui-1.10.2.custom.js'></script>
<link type="text/css" href='${pageContext.request.contextPath}/css/jquery-ui-1.10.2.custom.css' rel='stylesheet' />

                       
                        <!-- date time piv -->
                        <script type="text/javascript">
                            $(document).ready(
                                    function() {
                                        $("#startdate").datepicker({
                                            maxDate : "0",
                                            changeMonth : true,
                                            changeYear : true,
                                            firstDay : 1,
                                            dateFormat : 'mm/dd/yy',
                                        })
                                        var x=document.getElementById("startdate").value;
                                        //alert(x);
                                        if(x == "null"){
                                        	$( "#startdate" ).datepicker( "setDate", new Date());	
                                        } 
                                    });
                            function validation2(){
                                var x = document.getElementById("v1").value;
                                   if (x<8 || x == "") {
                                       alert ('Total hours must be more than 8 Hours');
                                       return false;
                                   }
                                   else if(x=="null"){
                                   	
                                   	alert ('Please Select date and Display Record then click on Submit');
                                       return false;
                                   }
                                   else if(x>=10){
                       	        	
                       	        	alert ('Are you sure to add more than 10 Hours');
                       	        	 return true;
                       	        }
                       	           
                                      
                             
                                   return true;
                                  
                           }

                        </script>
                <center>
                    <article>
                 
                  
                    <INPUT type="button" id="cmd" value="Create Task" style="width:100px;height:26px;background-color:#007BC0;color:white" onclick="addRow('dataTable')" />

                    <INPUT type="button" value="Delete Task" style="width:100px;height:26px;background-color:#007BC0;color:white" onclick="deleteRow('dataTable')" />
                   
                         <br><br><br>
 	<TABLE id="dataTable11" width="1100px" border="1" bordercolor="#DCDCDC" style="height:40px"  >
	<TR>
	<TH id="select-all"style="width:47px ;color:#007BC0;bordercolor:rgb(211,211,211)"><INPUT type="checkbox" name="select-all" onclick="toggle(this);"/></TH>
	<th id="pn" style="width:200px;fontfamily:Calibri;color:#007BC0;bordercolor:rgb(211,211,211)">Project Name : <span title= "This field is mandatory" style="color:red">*</span></th>
    <th id="pi" style="width:111px;fontfamily:Calibri;color:#007BC0;bordercolor:rgb(211,211,211)">Project ID :</th>
    <th id="tc"style="fontfamily:Calibri;width:159px;color:#007BC0;bordercolor:rgb(211,211,211)">Task Category :<span style="color:red">*</span></th>
    <th id="td"style="fontfamily:Calibri;width:200px;color:#007BC0;bordercolor:rgb(211,211,211)">Task Description :</th>
    <th id="h"style="color:#007BC0;bordercolor:#007BC0;width:120px">Hours :<span title= "This field is mandatory" style="color:red">*</span></th>
  </tr>
	</TABLE>
 <br>
 
	<TABLE id="dataTable" width="1100px" border="1" bordercolor="#DCDCDC"  >
	
		<TR>
			<TD><INPUT type="checkbox" name="chk[]" style="width:22px"/></TD>
			
			<TD><select id="selectBox" class="slt_prod" name="proname" onchange="populateCustomerId();"style="width:200px;fontfamily:Calibri"required name="title">
		      <OPTION value="0">Select Project</OPTION>
		      	<% for (String key : keys){ %>
		      			<OPTION value=<%=key %>><%=resultMap.get(key) %></OPTION>
		      	<% } %>
   			 </select></TD>
			
			<TD><input id="proId" class="txt_prod" type="text" value="" name="proid" style="width:90px;fontfamily:Calibri; background-color:#F5F5F5" readonly="readonly"/></TD>
			
			<TD>
				 <SELECT name="TaskCat"  style="fontfamily:Calibri;width:155px">
				<%
				
				
    try{
    	 
		response.setContentType("text/html");
	
//Class.forName("com.mysql.jdbc.Driver").newInstance();
//Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/customers?user=root&password=Datamato@123");
       
        resultset =statement.executeQuery("SELECT taskCategory FROM taskcatlist order by taskCategory;") ;
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
  
 

%>
</select></td>		
			
			<TD> <textarea rows="1" cols="20" maxlength="200" name="taskDescription" style="width:200px;fontfamily:Calibri"></textarea></TD>
			<TD><input type="text" name="hours" pattern="[0-9]+([\.,][0-9]+)?" title="Enter only numeric or decimal value" step="0.01"  style="fontfamily:Calibri;width:120px"class="code" id="code" onKeyUp = "calculateSum()"/></TD>
		</TR>
	</TABLE>
	<br>
<table >
  <tr>
 
    <td style='font-family:"Calibri"; '><B>Total Hours :</B></td>  <td><b><div class="textcenter">
   
        <input name="AgencyRating" id="v1" type="text" value="<%=request.getAttribute("AgencyRating")%>" autocomplete="off" class="forceNumeric" onchange="handleChange(this)"style="width:90px;height:20px;fontfamily:Calibri; color:black;font-size:16px; background-color:#F5F5F5" readonly="readonly"/>
        
    </div></b>
            </td>
    <td ><div id='sum' style="fontfamily:Calibri; padding-right: 150px;display:none" ><B>0 </B></div></td>
    
  </tr>
</table>

<br><br>
   <input type="submit" value="Save" style="margin-left: 0%;width:80px;height:32px;background-color:#007BC0;color:white" onclick="if(validatehours()){form.action='<%=request.getContextPath()%>/ManagerAddTask'}else{return false;};" / >

<br><br><br><br><br><br>
<table align="center" cellpadding="6" cellspacing="6" width="1100px" border="1">
<tr>
</tr>
	<tr style="color:#090C9B">
	<td><b>Task ID</b></td>
		<td><b>Date</b></td>
		<td><b>Project Name</b></td>
		<td><b>Project ID</b></td>
		<td><b>Task Category</b></td>
		<td><b>Task Description</b></td>
		<td><b>Hours</b></td>
		<td><b>Edit</b></td>
		<td><b>Delete</b></td>
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
                <td><%=pList.get(2)%></td>
                 <td><%=pList.get(3)%></td>
                  <td><%=pList.get(4)%></td>
                   <td><%=pList.get(5)%></td>
                      <td><%=pList.get(6)%></td>
                       <td><a href="<%=request.getContextPath()%>/ManagerUpdateTask?taskid=<%=pList.get(0)%>"><input type="button" value="Update" style="margin-left: 0%;width:80px;height:32px;background-color:#007BC0;color:white" /></a></td>
                    <td><a href="<%=request.getContextPath()%>/ManagerDeleteTask?taskid=<%=pList.get(0)%>&date=<%=pList.get(1)%>"><input  type="button" value="Delete" style="margin-left: 0%;width:80px;height:32px;background-color:#007BC0;color:white" onclick="if (confirm('Are you sure you want to delete?')){form.action='<%=request.getContextPath()%>/ManagerDeleteTask'}else { return false; };"/></td> 
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
            
            
           </table><br><br>
	<input type="submit" id="submitt" value="Submit" style="margin-left: 0%;width:80px;height:32px;background-color:#007BC0;color:white" onclick="form.action='<%=request.getContextPath()%>/MngSendMailApproval';return validation2(this);"/ >
	</article>
                </center>
            </div>
        </div>
    </form>
            
            
            
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
</body>
</html>
