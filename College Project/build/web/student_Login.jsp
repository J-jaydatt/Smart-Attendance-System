<%-- 
    Document   : student_Login
    Created on : 24 Dec 2024, 1:29:55 pm
    Author     : jay
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, db.database_Connection" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Login</title>
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
                height: 40px;
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
                
                
                if(request.getParameter("student_Id")!=null && request.getParameter("student_Password")!=null)
                {
                    int student_Id=Integer.parseInt(request.getParameter("student_Id"));
                    String student_Password=request.getParameter("student_Password");
                    
                    String query = "SELECT * FROM student WHERE sId = ? AND password = ?";
                    preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setInt(1,student_Id);
                    preparedStatement.setString(2,student_Password);
                    
                    ResultSet rs= preparedStatement.executeQuery();
                     
                    if(rs.next())
                    {
                        HttpSession s1 = request.getSession(true);
                        s1.setAttribute("id",student_Id);
                        response.sendRedirect("student_Index.jsp");
                    }
                    else
                    {
                      out.println("<script> alert('Wrong Login Id or Password !! '); location.href='student_Login.jsp';</script>");  
                    }
                    
                    
            }
                
                }
            
            
        } catch (Exception e) {
            // Log the error and show a user-friendly message
            e.printStackTrace();
            out.println("<h3 color:red;>An error occurred. Please try again later.</h3>");
        } finally {
            // Close resources to avoid memory leaks
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                ex.printStackTrace(); // Log any errors during resource cleanup
            }
        }
    %>

        <a href="index.html"><button id="bt">Back</button></a>
        <div class="body">
            <div class="formBody">
                <div class="from"></div>
                <form action="">
                    <h2>Student Login</h2>
                    <div class="usrName">
                        <img src="images/id-card.png" id="id" alt="">
                        <input type="text" placeholder="User Id" name="student_Id" required>
                    </div>
                    <div class="usrPass">
                        <img src="images/padlock.png" alt="">
                        <input type="password" name="student_Password" placeholder="Password">
                    </div>
                    <button type="submit">Login</button><br>
                </form>
            </div>
        </div>

    </body>
</html>
