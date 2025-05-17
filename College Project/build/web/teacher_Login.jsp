<%-- 
    Document   : teacher_Login
    Created on : 24 Dec 2024, 1:29:28 pm
    Author     : jay
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection,java.sql.ResultSet,java.sql.Time, java.sql.PreparedStatement,db.database_Connection" %>
<%--<%@ page import="java.sql.*, db.database_Connection" %>--%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Teacher Login</title>
        <style>
        body
        {
        width: 100%;
        height: 100vh;
        font-family: sans-serif;
        background-image: linear-gradient(to left, grey,#8cbdbc);

        }
        .body{
        display: flex;
        justify-content: center;
        }
        img{
            width: 0.7cm;
            height: 0.7cm;
            margin-left: 30px;
            margin-top: 15px;
            margin-right: 12px;
        }
        .formBody
        {
            margin-top: 10%;
            height: 45vh;
            width: 30%;
            background: teal;
            border-radius: 10px;
        }
        h2{
            margin-left: 15px;
        }
        .usrName
        {
            display: flex;
            align-items: center;
        }
        .usrPass
        {
            display: flex;
            align-items: center;
            margin-top: 5%;
        }
        input
        {
            margin-top: 15px;
            height: 30px;
            width: 70%;
            border-radius: 5px;
            border: none;
        }
        button
        {
            margin-top: 15%;
            margin-left: 35%;
            width: 30%;
            height: 30px;
            font-weight:bold ;
            border-radius: 5px;
            border: none;
        }
        #id
        {
            height: 0.9cm;
            width: 0.9cm;
            margin-top: 15px;
            margin-right: 5px;
        }
        #bt
        {
            margin-top: 10px;
            margin-left: 20px;
            width: 10%;
        }
        a{
            text-decoration: none;
        }
        p{
            display: inline-block;
            color:whitesmoke;
            margin-left: 30%;
            margin-top: 9%;
            margin-right: 10px;
        }

    </style>
    </head>
    <body>
        
        <% 
        // Declare necessary resources
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Establish connection to the database
            connection = database_Connection.getConnection();
            
            // Check if the connection was successful
            if (connection != null) {
                // Create Statement object
                
                
                if(request.getParameter("teacher_Id")!=null && request.getParameter("teacher_Password")!=null)
                {
                    int teacher_Id=Integer.parseInt(request.getParameter("teacher_Id"));
                    String teacher_Password=request.getParameter("teacher_Password");
                    
                    String query = "SELECT * FROM teacher WHERE tId = ? AND tpassword = ?";
                    preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setInt(1, teacher_Id);
                    preparedStatement.setString(2, teacher_Password);
                    
                    ResultSet rs= preparedStatement.executeQuery();
                     
                    if(rs.next())
                    {
                        HttpSession s1 = request.getSession(true);
                        s1.setAttribute("id",teacher_Id);
                        response.sendRedirect("teacher_Index.jsp");
                    }
                    else
                    {
                      out.println("<script> alert('Wrong Login Id or Password !! '); location.href='teacher_Login.jsp';</script>");  
                    }    
            }
                
                }
            
            
        } catch (Exception e) {
            // Log the error and show a user-friendly message
            e.printStackTrace();
            out.println("<p>An error occurred. Please try again later.</p>");
        } finally {
            // Close resources to avoid memory leaks
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (Exception ex) {
                ex.printStackTrace(); // Log any errors during resource cleanup
            }
        }
    %>

    <a href="index.html"><button id="bt">Back</button></a>
    <div class="body">
    <div class="formBody">
        <div class="from"></div>
        <form action="teacher_Login" method="Post">
            <h2>Login</h2>
            <div class="usrName">
                <img src="images/id-card.png" id="id" alt="">
                <input type="text" placeholder="User Id" name="teacher_Id"  required>
            </div>
            <div class="usrPass">
                <img src="images/padlock.png" alt="">
                <input type="password"  name="teacher_Password" placeholder="Password">
            </div>
            <button type="submit">Login</button>
            <!--<p>Don't have an Acc ?</p><a href="verify_Teacher.jsp">SignUp </a>-->
        </form>
    </div>
</div>
    </body>
</html>
