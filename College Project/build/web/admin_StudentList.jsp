 <%-- 
    Document   : teacher_MyClass
    Created on : 12 Mar 2025, 11:49:59 pm
    Author     : jay
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, db.database_Connection" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Teacher My Class</title>
        <style>

body{
                height: 100vh;
                width: 100%;
                overflow: hidden;
                font-family: 'Roboto', Arial, sans-serif;
                 background: linear-gradient(135deg, #4facfe, #00f2fe); 
                padding: 0px;
                
            }

            /* main interface ui css */

           
            h2{
                color: whitesmoke;
                justify-content: center;
                text-decoration: underline;
                text-align: center;
            }
            
            label
            {
                font-weight: bold;
                margin: 20px 38px 38px 35px;
                font-size: 25px;
            }



/* MAIN TABLE */
table {
    background: #ffffff; /* Plain White */
    color: #333; /* Dark Text */
    width: 99%;
    text-align: center;
    border-collapse: collapse;
    border-radius: 12px;
    height: auto;
    margin-top: 2%;
    overflow: hidden; /* Ensures rounded corners apply properly */
    border: 1px solid #d1d1d1; /* Light border */
}

/* TABLE HEADER */
table th {
    color: white;
    height: 50px;
    background: #374785; /* Dark Blue */
    font-size: 18px;
    font-weight: bold;
    text-transform: uppercase;
    padding: 12px;
}

/* ROW STYLING */
table tr:nth-child(odd) {
    background-color: #f8f9fc; /* Very Light Blue */
}

table tr:nth-child(even) {
    background-color: #e9efff; /* Slightly Darker Blue */
}

/* TABLE CELLS */
table td {
    padding: 15px;
    font-size: 16px;
    font-weight: 500;
    border: 1px solid #ddd; /* Subtle border for better structure */
}

/* IMAGE INSIDE TABLE */
table img {
    height: 40px;
    width: 40px;
    border-radius: 50%;
    border: 2px solid #374785;
    transition: transform 0.3s ease-in-out;
}

table img:hover {
    transform: scale(1.1); /* Slight zoom effect */
}

/* FORM BUTTON STYLING */
form button {
    margin-top: 35%;
    display: flex;
    align-items: center;
    background: none;
    border: none;
    cursor: pointer;
    transition: transform 0.2s ease-in-out;
}

form button:hover {
    transform: scale(1.05);
}

/* FORM ICON/TEXT */
form span {
    margin-top: 4%;
    font-size: 20px;
    margin-left: 5px;
    font-weight: bold;
    color: #374785; /* Dark Blue */
}

            #logoutMessage {
                display: none;
                color: red;
                font-size: 18px;
                margin: 20px;
            }
            button {
            display: block;
            width: calc(100% - 40px);
            margin: 30px auto;
            padding: 10px;
            background-color: #5218fa;
            color: whitesmoke;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #4a14e0;
        }
        #back{
            margin-left: 0px;
            width: 10%;
           
        }
        table button{
            margin: 7px;
        }
        #edit{
            background: orange;
            color:whitesmoke;
            width: 80%;
            height: 30px;
            font-weight: bold;
            padding: 5px;
        }
        .scrollable-table {
                height:80vh ;
                overflow-y: auto; 
                overflow-x: hidden; 
                border-radius: 10px; 
            }
            .proBar h4
            {
                margin: 5px;
                margin-top: 10px;
                font-style: italic;
            }
        </style>

    </head>
    <script>
        
             function indexpage()
    {
        window.location.href="admin_StudentOperations.jsp";
    }
        
        function logout()
        {
            return confirm("Are you sure You want to Logout ?");
        }
    </script>
    <body>
         <% 
        
             
             Connection connection = null;
             Statement st = null;
             PreparedStatement psmt=null;
             ResultSet rs= null;
            
             
             

            connection = database_Connection.getConnection();
           
                st = connection.createStatement();

    %>
        

       
  
        
    <h2 id="tdyses">Student Records</h2>
    <button onclick="indexpage()" id="back">Back</button></a>


        <div class="tblmain" id="tableId">
            <div class="scrollable-table">

            
            <table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Gender</th>
        <th>Class</th>
        <th>Email</th>
        <th>Address</th>
        <th>Edit</th>
    </tr>
    <%
        String sql4 = "SELECT sId, sName, sGender, sClass, sEmail, tAddress FROM student";
        rs = st.executeQuery(sql4);
        while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getInt("sId") %></td>
        <td><%= rs.getString("sName") %></td>
        <td><%= rs.getString("sGender") %></td>
        <td><%= rs.getString("sClass") %></td>
        <td><%= rs.getString("sEmail") %></td>
        <td><%= rs.getString("tAddress") %></td>
        <form action="admin_StudentProfileEdit.jsp">
            <input type="hidden" value="<%= rs.getInt("sId") %>" name="Sid">
            <td><button id="edit">Edit</button></td>
        </form>
    </tr>
    <% } %>
</table>
</div>
        </div>
    <%
         st.close();
        connection.close();
        
    %>
    </body>
</html>
