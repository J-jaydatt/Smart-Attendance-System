<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,java.sql.ResultSet,java.sql.Statement,java.sql.PreparedStatement,db.database_Connection" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Teacher Tab Hod Page</title>
    
    <script>
        function logout() {
            return confirm("Are you sure you want to logout?");
        }
    </script>
    
    <style>
        body {
            height: 100vh;
            width: 100%;
            overflow: hidden;
            font-family: 'Roboto', Arial, sans-serif;
        }
        .navmain {
            height: 93vh;
            width: 17%;
            float: left;
            padding: 20px;
        }
        .profile {
            height: 15vh;
            width: 85%;
            text-align: center;
            padding: 15px;
            border-radius: 10px;
        }
        .profile button {
            background-color: #6bbbed;
            color: white;
            height: 25px;
            width: 50%;
            border: none;
            border-radius: 20px;
            transition: 0.4s;
        }
        .profile button:hover {
            height: 28px;
            width: 55%;
        }
        #logo {
            height: 2cm;
            width: 2cm;
            background: white;
            padding: 5px;
            border-radius: 50px;
            border: 1px solid #6bbbed;
        }
        hr {
            border: none;
            height: 3px;
            background-color: silver;
            margin-top: 50px;
        }
        .navbaroption {
            margin-top: 5%;
            height: 70vh;
            width: 85%;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }
        .navbaroption a {
            text-decoration: none;
            position: relative;
            color: black;
            font-size: 20px;
            display: flex;
            align-items: center;
            margin-top: 25%;
            gap: 10px;
            transition: color 0.3s ease;
        }
        .navbaroption a:hover {
            color: #0d6efd;
        }
        .navbaroption img {
            height: 0.8cm;
            width: 0.8cm;
        }
        #Dashboard {
            color: #0d6efd;
        }
        #topOption {
            margin-top: 20px;
        }
        form button {
            margin-top: 35%;
            display: flex;
            background: none;
            border: none;
        }
        form span {
            margin-top: 4%;
            font-size: 20px;
            margin-left: 5px;
        }
        .mainbody {
            background-color: #f4f3ef;
            height: 100vh;
            width: 77%;
            margin-left: 20%; 
            padding: 20px;
            overflow-y: auto;
        }
        h2 {
            color: #0d6efd;
        }
        .card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin: 20px 0;
            text-align: center;
        }
        .card img {
            border-radius: 50%;
            width: 100px;
            height: 100px;
        }
        .back-button {
            background-color: #6bbbed;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }
        .back-button:hover {
            background-color: #5a9bd4;
        }
    </style>
</head>
<body>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if (session.getAttribute("id") == null) {
        response.sendRedirect("YouAreLogOut.jsp?logoutId=hod");
    } else {
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null, rs2 = null;
        String name = "", gender = "", contact = "", email = "", base64Image = "", Profile = "";

        try {
            connection = database_Connection.getConnection();
            st = connection.createStatement();
            int userId = Integer.parseInt(request.getParameter("tId"));
            String sql = "SELECT * FROM teacher WHERE tId = " + userId;
            rs = st.executeQuery(sql);

            while (rs.next()) {
                byte[] imageData = rs.getBytes("img");

                if (imageData != null) {
                    base64Image = java.util.Base64.getEncoder().encodeToString(imageData);
                } else {
                    base64Image = "";
                }
                name = rs.getString("tName");
                gender = rs.getString("tGender");
                contact = rs.getString("tContact");
                email = rs.getString("tEmail");
            }
            
            int hodId = Integer.parseInt(request.getParameter("hodId"));
            String sql2 = "SELECT * FROM teacher WHERE tId=" + hodId;
            rs2 = st.executeQuery(sql2);

            while (rs2.next()) {
                byte[] imageData = rs2.getBytes("img");

                if (imageData != null) {
                    Profile = java.util.Base64.getEncoder().encodeToString(imageData);
                } else {
                    Profile = "";
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp?msg=Invalid ID format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp?msg=An error occurred while fetching data");
        } finally {
            try {
                if (rs != null) rs.close();
                if (rs2 != null) rs2.close();
                if (st != null) st.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
%>

<div class="navmain">
    <div class="profile">
        <% if (!Profile.isEmpty()) { %>
        <img src="data:image/jpeg;base64,<%= Profile %>" id="logo" alt="">
        <% } else { %>
        <img src="images/user.png" id="logo" alt="">
        <% } %>
        <h3><%= name %></h3>
        <button>Edit</button>
    </div>
    <hr>
    <div class="navbaroption">
        <a href="hod_Index.jsp" id="topOption"> <img src="images/dashboard.png" alt="">Dashboard</a>
        <a href="hod_Classes.jsp"> <img src="images/presentation.png" alt="">Classes</a>
        <a href="#" id="Dashboard"> <img src="images/training.png" alt="">Teachers</a>
        <a href="hod_TimeTable.jsp"> <img src="images/calendar-clock.png" alt="">Time Tables</a>
        <a href="hod_EditProfile.jsp"> <img src="images/setting.png" alt="">Setting</a>
        <form onsubmit="return logout()" action="Logout">
            <button type="submit">
                <input type="hidden" value="0" name="hod">
                <img src="images/signout.png" alt="Sign Out">
                <span>Logout</span>  
            </button>
        </form>
    </div>
</div>

<div class="mainbody">
    <h2>Teacher Information</h2>
    <div class="card">
        
       <%if (base64Image != null) {%>
                <img src="data:image/jpeg;base64,<%= base64Image%>" id="logo" alt="">
                <%} else {
                %>
                <img src="images/user.png" id="logo" alt="">
                <%}%>
        <h3><%= name %></h3>
        <p><strong>Gender:</strong> <%= gender %></p>
        <p><strong>Contact:</strong> <%= contact %></p>
        <p><strong>Email:</strong> <%= email %></p>
    </div>
    <a href="hod_Teacher.jsp" class="back-button">Back to Teacher List</a>
</div>

<% } %>
</body>
</html>
