<%-- 
    Document   : hod_AddNewClass
    Created on : 19 Feb 2025, 7:55:13 pm
    Author     : jay
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.sql.PreparedStatement, db.database_Connection" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <% 
        
        Connection connection = null;
        Statement st = null;
        PreparedStatement psmt=null;
        ResultSet rs=null;
        int maxId=0,strength=0;
        
        connection = database_Connection.getConnection();
        
            String className=request.getParameter("class_Name");
            String classTeacher=request.getParameter("class_Teacher");
            String classType=request.getParameter("class_Type");
            strength=Integer.parseInt(request.getParameter("class_Strength"));
           
              st = connection.createStatement();
                
              String sql="select MAX(classId) from classes";
              rs=st.executeQuery(sql);
              
              while(rs.next())
              {
                    maxId=rs.getInt(1);
                    maxId+=1;
                    
              }
              
              String sql2="insert into classes (classId,className,classTeacher,strength,classType) values(?,?,?,?,?)";
              psmt=connection.prepareStatement(sql2);
              psmt.setInt(1, maxId);
              psmt.setString(2,className);
              psmt.setString(3, classTeacher);
              psmt.setInt(4,strength);
              psmt.setString(5,classType);
              int exe=psmt.executeUpdate();
              
              if(exe>0)
              {
                    out.println("<script> alert('New Batch Added Succefully !! '); location.href='hod_Classes.jsp';</script>");  
              }
              else
              {
                    out.println("<script> alert('Failed to Add new Class Try Again!! '); location.href='hod_AddClass.jsp';</script>");  
               }
              st.close();
              connection.close();
                
    %>
    </body>
</html>
