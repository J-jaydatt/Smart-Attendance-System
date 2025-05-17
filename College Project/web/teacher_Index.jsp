<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, db.database_Connection" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Teacher Index</title>
        <style>
            body {
                height: 100vh;
                width: 100%;
                font-family: Arial, sans-serif;
                padding: 0;
                background-color: #f8f9fa;
            }
            .navmain {
                height: 93vh;
                width: 17%;
                float: left;
                padding: 20px;
                background: #ffefe0; /* Soft Peach */
                border-radius: 12px;
                border: 3px solid #ffcaa6; /* Light Orange Border */
                box-shadow: 3px 5px 12px rgba(255, 180, 120, 0.3);
            }

            /* PROFILE SECTION (Solid Background) */
            .profile {
                height: 15vh;
                width: 85%;
                text-align: center;
                padding: 20px;
                border-radius: 10px;
            }
            

            /* PROFILE BUTTON */
            .profile button {
                background: #ff9f66; /* Soft Orange */
                color: white;
                height: 25px;
                width: 50%;
                border: none;
                border-radius: 20px;
                font-weight: bold;
                transition: all 0.3s ease-in-out;
                cursor: pointer;
            }

            .profile button:hover {
                background: #ff7b42; /* Slightly Darker Orange */
                box-shadow: 0px 4px 10px rgba(255, 120, 60, 0.3);
            }

            /* LOGO */
            #logo {
                height: 2cm;
                width: 2cm;
                background: white;
                padding: 5px;
                border-radius: 50%;
                border: 2px solid #ff9f66;
            }

            /* HORIZONTAL LINE */
            hr {
                border: none;
                height: 2px;
                background-color: #ffcc99;
                margin-top:40px;
            }

            /* NAVBAR OPTIONS */
            .navbaroption {
                margin-top: 5%;
                height: 70vh;
                width: 85%;
                padding: 20px;
                display: flex;
                flex-direction: column;
                align-items: flex-start;
            }

            /* NAVIGATION LINKS */
            .navbaroption a {
                text-decoration: none;
                color: #8a4f2b; /* Warm Brown */
                font-size: 20px;
                font-weight: bold;
                padding: 15px 0; /* Added space between links */
                display: flex;
                align-items: center;
                gap: 12px;
                position: relative;
                transition: color 0.3s ease-in-out;
                margin-top: 35px;
            }

            /* HOVER EFFECT - Underline */
            .navbaroption a::after {
                content: '';
                position: absolute;
                left: 0;
                bottom: 0;
                width: 0;
                height: 2px;
                background: #ff7b42; /* Soft Orange */
                transition: width 0.3s ease-in-out;
            }

            .navbaroption a:hover::after {
                width: 100%;
            }

            /* HOVER EFFECT - Color Change */
            .navbaroption a:hover {
                color: #ff7b42;
            }

            /* ICONS INSIDE NAVBAR */
            .navbaroption img {
                height: 24px;
                width: 24px;
            }

            /* ACTIVE DASHBOARD LINK */
            #Dashboard {
                color: #ff7b42;
                font-weight: bold;
            }

            .mainbody {
                background-color: #ececea;
                width: 80%;
                margin-left: 21%;
                padding: 10px;
                border-radius: 10px;
            }
            table {
                width: 95%;
                border-collapse: collapse;
                background: white;
                margin-top: 20px;
            }
            table, th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            th {
                background: #374785;
                color: white;
            }
            #tempbutton {
                background: #fdaac2;
                border: none;
                padding: 10px;
                border-radius: 8px;
                cursor: pointer;
                margin-top: 10px;
            }
            #tempbutton:disabled {
                background: #ccc;
                cursor: not-allowed;
            }
            /* FORM BUTTON STYLING */
form button {
    margin-top: 35%;
    align-items: center;
    background: none;
    border: none;
    cursor: pointer;
    transition: transform 0.2s ease-in-out;
}
form span {
    margin-top: 4%;
    font-size: 20px;
    margin-left: 5px;
    font-weight: bold;
    color: #374785; /* Dark Blue */
}
        </style>
        <script>
            function logout() {
                return confirm("Are you sure you want to logout?");
            }
        </script>
    </head>
    <body>
        <%
            response.setHeader("Cache-control", "no-cache,no-store,must-revalidate");

            if (session.getAttribute("id") == null) {
                response.sendRedirect("YouAreLogOut.jsp?logoutId=teacher");
            } else {
                Connection connection = null;
                Statement st = null;
                ResultSet rs = null;
                byte[] imgData;
                String tName = "", base64Image = "";

                int tId = Integer.parseInt(session.getAttribute("id").toString());

                try {
                    connection = database_Connection.getConnection();
                    if (connection == null) {
                        throw new Exception("Database connection failed!");
                    }

                    st = connection.createStatement();
                    String sql = "SELECT * FROM teacher WHERE tId = " + tId;
                    rs = st.executeQuery(sql);

                    if (rs.next()) {
                    
                    byte[] imageData = rs.getBytes("img");

                    if (imageData != null) {
                        base64Image = java.util.Base64.getEncoder().encodeToString(imageData);
                    } else {
                        base64Image = ""; // Or provide a default image
                    }
                    
                    
//                        byte[] imageData = rs.getBytes("img");
//                        base64Image = (imageData != null) ? java.util.Base64.getEncoder().encodeToString(imageData) : "";
                        
                        tName = rs.getString("tName");
                    } else {
                        throw new Exception("Teacher record not found!");
                    }
        %>

          <div class="navmain">
        <div class="profile">
            <%if(base64Image!=null){%>
            <img src="data:image/jpeg;base64,<%= base64Image %>" id="logo" alt="">
            <%}else{
            %>
            <img src="images/user.png" id="logo" alt="">
            <%}%>
            <h4><%= tName %></h4>
            <button>Edit</button>
        </div>


        <hr>
        <div class="navbaroption">
            <a href="teacher_Index.jsp" id="Dashboard" > <img src="images/dashboard.png" alt="">Home</a>
            
            <a href="teacher_MyClass.jsp" > <img src="images/user-check.png" alt="">My Class</a>
            <a href="teacher_EditProfile.jsp"> <img src="images/setting.png" alt="">Setting</a>
           

            <form onsubmit="return logout()" action="Logout">
                <button type="submit">
                    <img src="images/signout.png" alt="Sign Out">
                    <input type="hidden" value="3" name="Tea">
                    <span>Logout</span>
                </button>
            </form>
        </div>
    </div>

        <div class="mainbody">
            <h2>My Time Table</h2>

            <div class="tblmain">
                <%

                    String sql2 = "SELECT tt.clsId, c.className, tt.tId, tt.day, tt.startTime, tt.endTime, s.subName, s.subId "
                            + "FROM timetable tt "
                            + "JOIN subjects s ON tt.subId = s.subId "
                            + "JOIN classes c ON tt.clsId = c.classId "
                            + "WHERE tt.tId = " + tId
                            + " ORDER BY FIELD(tt.day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'), tt.startTime";

                    rs = st.executeQuery(sql2);

                    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
                    String currentTime = timeFormat.format(new java.util.Date());
                %>

                <table>
                    <tr>
                        <th>Day</th>
                        <th>Time Slot</th>
                        <th>Subject</th>
                        <th>Class</th>
                        <th>Status</th>
                    </tr>
                    <%
                        if (!rs.isBeforeFirst()) {
                            // No records found
                            out.println("<tr><td colspan='6' style='text-align: center;'><h2>No timetable is available</h2></td></tr>");
                        } else {

                            while (rs.next()) {
                                String day = rs.getString("day");
                                String startTime = rs.getTime("startTime").toString().substring(0, 5);
                                String endTime = rs.getTime("endTime").toString().substring(0, 5);
                                String subject = rs.getString("subName");
                                boolean isActive = (currentTime.compareTo(startTime) >= 0) && (currentTime.compareTo(endTime) <= 0);
                    %>
                    <tr>
                        <td><%= day%></td>
                        <td><%= startTime%> - <%= endTime%></td>
                        <td><%= subject%></td>
                        <td><%= rs.getString("className")%></td>
                        <td>
                            <form action="teacher_LiveClass.jsp" method="post">
                                <input type="hidden" name="classId" value="<%= rs.getInt("clsId")%>">
                                <input type="hidden" name="subjectId" value="<%= rs.getInt("subId")%>">
                                <input type="hidden" name="teacherId" value="<%= rs.getInt("tId")%>">
                                <input type="hidden" name="day" value="<%= rs.getString("day")%>">
                                <input type="hidden" name="st" value="<%= rs.getTime("startTime")%>">
                                <input type="hidden" name="et" value="<%= rs.getTime("endTime")%>">
                                <button type="submit" id="tempbutton" <%= isActive ? "" : "disabled"%>>Start Class</button>
                            </form>
                        </td>
                    </tr>
                    <% }
                        }%>

                </table>
            </div>
        </div>

        <%
                } catch (Exception e) {
                    out.println("<p style='color:red;'>" + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) {
                        rs.close();
                    }
                    if (st != null) {
                        st.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                }
            }
        %>
    </body>
</html>
