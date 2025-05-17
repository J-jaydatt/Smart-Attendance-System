<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, db.database_Connection" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Class Tab Hod</title>
        <script>
            function logout()
            {
                return confirm("Are you sure You want to Logout ?")
            }
        </script>
        <style>
            body{
                width: 100%;

                font-family: 'Roboto', Arial, sans-serif;
            }
            /* side navigation bar css */
            #Dashboard
            {
                color: #0d6efd;
            }

            /* main interface ui css */
            .mainbody
            {
                background-color: #f4f3ef;
                width: 100%;
                padding: 20px;
            }
            h2{
                color: #0d6efd;
            }

            /* TABLE MAIN CSS OUTLINE */
            .tblmain
            {
                padding: 20px;
                background: white;
                border-radius: 10px;
                width: 95%;
            }
            .tblmain img
            {
                height: 1cm;
                width: 1cm;
                font-size: 30px;
                margin: 10px;
                color: #0d6efd;
            }

            table th
            {
                height: 40px;
                background:#00B4CC;
            }

            /* MAIN TABLE */
            table
            {
                width: 100%;
                text-align: center;
                border-collapse: collapse;
                border-radius:10px;
                height: auto;

            }
            table  tr:nth-child(odd) {
                background-color: #f4f3ef;
            }
            table tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            table td
            {
                padding: 10px;
                height: 35px;
            }
            table img{
                height: 1.5cm;
                width: 1.5cm;
                border-radius: 50px;
                margin-top: 10%;
            }
            table button
            {
                background-color: orange;
                color: whites;
                border: none;
                height: 30px;
                border-radius: 10px;
                width: 40%;
            }
            #lg{
                margin-top: 35%;
                display: flex;
                background: none;
                border:none
            }
            form span{
                margin-top: 4%;
                font-size: 20px;
                margin-left: 5px;
            }
            #addClass
            {
                margin-top: 15px;
                display: inline-block;
                color: orange;
                background: linear-gradient(to right, #fa4649, #e9007f);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                font-size: 20px;
                font-weight: bold;
            }
            #add
            {
                background: none;
                border: none;
            }
            .adding
            {
                display: flex;
                align-items: center;
            }
            #error
            {
                margin-top: 15px;
                display: inline-block;
                color: orange;
                background: linear-gradient(to right, #ff0fof, #e9007f);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                font-size: 20px;
                font-weight: bold;
            }
            .heading
            {              
                width: 95%;
                display: flex;
                padding: 3px;
            }
            .heading h2{
                width: 50%;
            }
            .search {
                width: 50%;
                position: relative;
                display: flex;
                margin-top: 0%;
                margin-left: 5%;
            }
            .searchTerm {
                width: 50%;
                border: 3px solid #00B4CC;
                border-right: none;
                padding: 5px;
                height: 20px;
                border-radius: 5px 0 0 5px;
                outline: none;
                color: #9DBFAF;
            }

            .searchTerm:focus{
                color: #00B4CC;
            }

            .searchButton {
                width: 40px;
                height: 36px;
                border: 1px solid #00B4CC;
                background: #00B4CC;
                text-align: center;
                color: #fff;
                border-radius: 0 5px 5px 0;
                cursor: pointer;
                font-size: 20px;
                margin-bottom: 1%;
            }
            .classData
            {
                width: 50%;
            }
             .classData h4
            {
               margin: 4px;
            }
           
        </style>
    </head>
    <body>
        <%
            Connection connection = null;
            Statement st = null;
            ResultSet rs = null;
            PreparedStatement pstmt = null;
            String verfied = "0";
            connection = database_Connection.getConnection();
            int addId = 1;

            st = connection.createStatement();
        %>

        <div class="mainbody">
            <div class="heading">
                <div class="search">
                    <input type="text" class="searchTerm" placeholder="Search Student">
                    <button type="submit" class="searchButton">
                        <i class="fa fa-search"></i>
                    </button>
                   
                </div>
            </div>
            <div class="tblmain">
                <table>
                    <tr>

                        <th>Teacher Name</th>
                        <th>Email</th>
                        <th>Contact</th>
                        <th>Gender</th>
                        <th>Requests</th>
                    </tr>
                    <tr>
                        <%                           
                            String sql = "SELECT * FROM teacher where verified= ?";
                            pstmt = connection.prepareStatement(sql);
                            pstmt.setString(1, verfied);
                            rs = pstmt.executeQuery();
                            while (rs.next()) {
                        %>
                        <td><%= rs.getString("tName")%></td>
                        <td><%= rs.getString("tEmail")%></td>
                        <td><%= rs.getString("tContact")%></td>
                         <td><%= rs.getString("tGender")%></td>
                   <form action="verifyteacher" method="POST"> 
    <input type="hidden" value="<%= rs.getInt("tId")%>" name="verficationId">  <!-- Corrected name -->
    <td><button>Verify</button></td>
</form>

                    </tr>
                    <%
                                
                            }

                            st.close();
                            connection.close();
                        
                    %>
                </table>
            </div>


        </div>
    </body>
</html>
