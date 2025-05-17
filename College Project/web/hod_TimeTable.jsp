<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, db.database_Connection" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Time Table Tab Hod</title>
        <script>
            function logout()
            {
                return confirm("Are you sure You want to Logout ?")
            }
        </script>
        <style>
                  body{
                height: auto;
                width: 100%;
                overflow: hidden;
                padding: 0px;
                font-family: 'Roboto', Arial, sans-serif;
            }
         .navmain
            {
                height: 93vh;
                width: 17%;
                float: left;
                padding: 20px;
            }
            .profile
            {
                height: 15vh;
                width: 85%;
                text-align: center;
                padding: 15px;
                border-radius: 10px;
            }
            .profile button
            {
                background-color: #6bbbed;
                color: white;
                height:25px;
                width: 50%;
                border: none;
                border-radius: 20px;
                transition: 0.4s;
            }
            .profile button:hover{
                height: 28px;
                width: 55%;
            }
            #logo
            {
                height: 2cm;
                width: 2cm;
                background: white;
                padding: 5px;   
                border-radius: 50px;
                border: 1px solid #6bbbed;
            }
            hr
            {
                border: none;
                height: 3px;
                background-color: silver; /* Adjust to your color */
                margin-top:50px;
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
                color: #0d6efd;
                padding: 5px 0;


                text-decoration: none;
                color: black;
                font-size: 20px;
                display: flex; /* Makes the link a flex container */
                align-items: center; /* Centers the image and text vertically */
                margin-top: 25%;
                gap: 10px; /* Adds space between the image and text */
                transition: color 0.3s ease; /* Smooth transition for hover color */
            }
            .navbaroption a::after {
                content: '';
                position: absolute;
                left: 0;
                bottom: 0;
                width: 0;
                height: 2px;
                background: #007BFF;
                transition: width 0.3s ease;
            }

            .navbaroption a:hover::after {
                width: 100%;
            }

            .navbaroption a:hover {
                color: #0d6efd; /* Hover color */
            }

            .navbaroption img {
                height: 0.8cm;
                width: 0.8cm;
                display: block; /* Ensures the image behaves like a block element */
            }

            #Dashboard
            {
                color: #0d6efd;
            }
            #topOption{
                margin-top: 20px;
            }
            .header
            {
                display: flex;
                justify-content: space-between;
                justify-items: center;
            }
            #addimg
            {
                height: 1.5cm;
                width: 1.5cm;
            }
            #add
            {
                background: none;
                border: none;
                margin-top: 10%;
                margin-right: 60%;
            }

            /* main interface ui css */

            .mainbody
            {
                background-color: #f4f3ef;
                height: 100vh;
                width: 77%;
                margin-left:20%;
                padding: 20px;
                margin-top: 0px;
            }
            h2{
                color: #0d6efd;
            }

            /* TABLE MAIN CSS OUTLINE */
.tblmain {
    padding: 20px;
    background: white;
    border-radius: 10px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    max-height: 900px; /* Set a fixed height for the table container */
    overflow: hidden;
    height: 80vh;/* No scroll here */
}

.table-wrapper {
    max-height: 100%; /* Adjust the height as needed */
    overflow-y: auto; /* Allow vertical scrolling only for the body */
}

table {
    
    width: 100%;
    text-align: center;
    border-collapse: collapse;
    border-radius: 10px;
    table-layout: fixed; /* Ensures consistent column width */
    overflow: hidden;
}
table th {
    position: sticky;
    top: 0;
    background-color: #007848; /* Table header background color */
    color: white;
    font-size: 16px;
    font-weight: bold;
    z-index: 1; /* Ensure the header is above the table body */
    padding: 15px; /* Match padding of td for alignment */
}

table tr:nth-child(odd) {
    background-color: #f4f3ef;
}

table tr:nth-child(even) {
    background-color: #ffffff;
}

table td {
    padding: 15px; /* Match padding of th for alignment */
    font-size: 14px;
    border-bottom: 1px solid #ddd;
}

table tr:hover {
    /* Add transition or hover effects here */
    transition: 0.3s ease;
}

table button {
    background: #844421;    
    color: white;
    border: none;
    height: 35px;
    width: 90px;
    border-radius: 5px;
    font-size: 14px;
    cursor: pointer;
    transition: 0.3s;
}

table button:hover {
    background: #b36b43;
}

table img {
    height: 1.5cm;
    width: 1.5cm;
    border-radius: 50px;
    margin-top: 10%;
}
form button{
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


        </style>
    </head>
    <body>


        <%

            Connection connection = null;
            Statement st = null;
            ResultSet rs = null;
            String name = "",base64Image="";
            connection = database_Connection.getConnection();
            int addId=1;

            st = connection.createStatement();

            if (session.getAttribute("id") == null) {
            
            response.sendRedirect("YouAreLogOut.jsp?logoutId=hod");

            } else {
                int userId = Integer.parseInt(session.getAttribute("id").toString());

                String sql = "select * from teacher where tid=" + userId;
                rs = st.executeQuery(sql);
                while (rs.next()) {
                
                    byte[] imageData = rs.getBytes("img");
                    base64Image = java.util.Base64.getEncoder().encodeToString(imageData);
                
                    name = rs.getString("tname");

                }
            }


        %>
       <div class="navmain">
            <div class="profile">
                <%if (base64Image != null) {%>
                <img src="data:image/jpeg;base64,<%= base64Image%>" id="logo" alt="">
                <%} else {
                %>
                <img src="images/user.png" id="logo" alt="">
                <%}%>
                <h3><%= name%></h3>
                <a id="editbtn" href="hod_EditProfile.jsp"><button> Edit </button></a>
            </div>
            <hr>
            <div class="navbaroption">
                <a href="hod_Index.jsp" id="topOption" > <img src="images/dashboard.png" alt="">Dashboard</a>
                <a href="hod_Classes.jsp" > <img src="images/presentation.png" alt="">Classes</a>
                <a href="hod_Teacher.jsp"> <img src="images/training.png" alt="">Teachers</a>
                <a href="#" id="Dashboard"> <img src="images/calendar-clock.png" alt="">Time Tables</a>
                <a href="hod_EditProfile.jsp"> <img src="images/setting.png" alt="">Setting</a
                <div>
                    <form  onsubmit="return logout()" action="Logout">
                        <button type="submit">


                            <input type="hidden" value="0" name="hod" >
                            <img src="images/signout.png" alt="Sign Out">
                            <span>Logout</span>  
                        </button>
                    </form>
                </div>   
            </div>

        <div class="mainbody">
            <div class="header">
                    <h2>Time Table</h2>

<!--            <div class="adding">
                <form action="hod_AddTimeTable.jsp" method="POST">
                    <button id="add" type="submit"> <img id="addimg" src="images/newTimeTable.png" alt=""></button>
                <input type="hidden" name="addId" value="<%= addId %>">
                </form>
            </div>-->
            </div>
                <div class="tblmain">
    <table>
        <thead>
            <tr>
                <th>Class</th>
                <th>Class Teacher</th>
                <th>View</th>
            </tr>
        </thead>
    </table>

    <div class="table-wrapper">
        <table>
            <tbody>
                <%

        response.setHeader("Cache-Control", "no-cashe , no-store ,must-revalidate");
        if (session.getAttribute("id") == null) {
            response.sendRedirect("hod_Login.jsp");
        } else {

    %>

                <%
                    String sql2 = "select * from classes";
                    rs = st.executeQuery(sql2);
                    while (rs.next()) {
                        String className = rs.getString("className");
                        int clsId = rs.getInt("classId");
                %>
                <tr>
                    <td><%= rs.getString("className") %></td>
                    <td><%= rs.getString("classTeacher") %></td>
                      
                    <form method="post" action="hod_ClassTimeTable.jsp"> 
                        <td><button type="submit"> Time Table</button></td>
                        <input type="hidden" name="className" value="<%= clsId %>"> 
                        <input type="hidden" name="realClassName" value="<%= rs.getString("className") %>">
                    </form>
                </tr>
                <%
                    }

                    st.close();
                    connection.close();
                %>
            </tbody>
        </table>
    </div>
</div>


            


        </div>
            <%}%>
    </body>
</html>
