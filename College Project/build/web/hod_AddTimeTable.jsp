<%@ page import="java.sql.*, db.database_Connection" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add New Time Table</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: sans-serif;
                background: linear-gradient(115deg, #56d8e4 10%, #9f01ea 90%);
                margin: 0;
                padding: 0;
                width: 100%;
                height: 100vh;
            }
            .formbody {
                width: 30%;
                margin: 1% auto;
                padding: 10px;
                background: whitesmoke;
                border-radius: 8px;
                box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
            }
            h2 {
                text-align: center;
                color: #5218fa;
                margin-top: 5px;
            }
            label {
                display: block;
                margin: 5px 0 5px 10px;
                color: gray;
                font-weight: 300px;
            }
            input, select {
                width: calc(100% - 40px);
                margin: 0 5px 10px 10px;
                padding: 5px;
                border-radius: 5px;
                border: 1px solid silver;
                background: transparent;
                height: 30px;
            }
            button {
                display: block;
                width: calc(100% - 40px);
                margin: 20px auto;
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
            sup{
                color: orange;
            }
            #back{
                margin:20px;
                width: 10%;
            }
            #classTeacher {
                height: 0.4cm;
                width: 0.4cm;
                margin-top: 10px;
            }
            #teacheck {
                display: inline-block;
            }
            .time input
            {
                width: 30%;
            }
        </style>

        <script>


            function form_Validations() {
                var a = document.getElementById("sName");
                var b = document.getElementById("sClass");
                var c = document.getElementById("sGender");
                var d = document.getElementById("startTime");
                var e = document.getElementById("endTime");
                var f = document.getElementById("day");

                // Reset borders before validation
                a.style.border = "1px solid silver";
                b.style.border = "1px solid silver";
                c.style.border = "1px solid silver";
                d.style.border = "1px solid silver";
                e.style.border = "1px solid silver";
                f.style.border = "1px solid silver";

                if (!a.value || !b.value || !c.value || !d.value || !e.value || !f.value) {
                    if (!a.value)
                        a.style.border = "2px solid red";
                    if (!b.value)
                        b.style.border = "2px solid red";
                    if (!c.value)
                        c.style.border = "2px solid red";
                    if (!d.value)
                        e.style.border = "2px solid red";
                    if (!e.value)
                        d.style.border = "2px solid red";
                    if (!f.value)
                        f.style.border = "2px solid red";

                    alert("All fields are mandatory.");
                    return false;
                }
                return true;
            }
        </script>
    </head>

    <body>
        <%
            Connection connection = null;
            Statement st = null;
            ResultSet rs = null;
            PreparedStatement pstmt = null;
            int ClassId=0;
//            int reFreshId = Integer.parseInt(request.getParameter("addId"));
            String classname = request.getParameter("className");

            connection = database_Connection.getConnection();
            st = connection.createStatement();

            String suc = request.getParameter("success");
            String f = request.getParameter("fail");
            String aa = request.getParameter("already");

            if (suc != null && !suc.isEmpty()) {
        %>
        <script type="text/javascript">
            alert("<%= suc%>");
        </script>
        <% }
            if (f != null && !f.isEmpty()) {
        %>
        <script type="text/javascript">
            alert("<%= f%>");
        </script>
        <% }
            if (aa != null && !aa.isEmpty()) {
        %>
        <script type="text/javascript">
            alert("<%= aa%>");
        </script>
        <% }%>
        <button onclick="indexpage()" id="back">Back</button>

        <div class="formbody">
            <form onsubmit="return form_Validations()" action="addNewTimeTable" method="post">
                <h2>New Time Table</h2>



                <%
                    String query = "SELECT * FROM teacher WHERE verified = 1";
                    st = connection.createStatement();
                    rs = st.executeQuery(query);
                %>
                <label>Teacher Name<sup>*</sup>:</label>
                <select name="teacherId" id="sClass">
                    <option value="choose">Select Teacher</option>
                    <%while (rs.next()) {%>
                    <option value="<%= rs.getInt("tId")%>"><%= rs.getString("tName")%></option>
                    <%}%>
                </select><br><br>

                <%
                    String query2 = "SELECT * FROM subjects";

                    // Execute the query
                    st = connection.createStatement();
                    rs = st.executeQuery(query2);
                %>
                <label>Subject<sup>*</sup>:</label>
                <select name="subjectId" id="sClass">
                    <option value="choose">Select Subject</option>
                    <%while (rs.next()) {%>
                    <option value="<%= rs.getInt("subId")%>"><%= rs.getString("subName")%></option>
                    <%}%>
                </select><br><br>


                <%
                    String query3 = "SELECT * FROM classes where className='" + classname + "'";
                    st = connection.createStatement();
                    rs = st.executeQuery(query3);
                %>
                <label>Class<sup>*</sup>:</label>
                <select name="classId" id="sGender">
                    <%while (rs.next()) {
                         ClassId=rs.getInt("classId");
                    
                    %>
                    <option value="<%= ClassId %>"><%= classname%></option>
                    <%}%>
                </select><br><br>
                <%
                    String days[] = {"Monday", "Tuesday", "Wednesday", "Thurday", "Friday", "Saturday"};
                %>
                <label>Day<sup>*</sup>:</label>
                <select name="day" id="day">
                    <% for (String day : days) {%>
                    <option value="<%= day%>"><%= day%></option>
                    <%}%>
                </select><br><br>

                <div class="time">
                    <label for="startTime">Start Time: </label>
                    <input type="time" id="startTime" name="startTime" min="08:00" max="18:00" required><br><br>

                    <label for="endTime">End Time: </label>
                    <input type="time" id="endTime" name="endTime" min="08:00" max="18:00" required><br><br>
                </div>

                <label id="teacheck" for="newsletter">Class Teacher</label>
                <input type="checkbox" id="classTeacher" name="isClassTeacher"> <br><br>

                <button type="submit">Add</button>
            </form>
        </div>

        <script>
            function indexpage() {

                var className = "<%= ClassId %>"; // classId is passed as className
                var realClassName = "<%= classname %>"; // Real class name from database

                // Redirecting to hod_Index.jsp with parameters
                window.location.href = "hod_ClassTimeTable.jsp?className=" + encodeURIComponent(className) + "&realClassName=" + encodeURIComponent(realClassName);
            }
        </script>
        <%
            st.close();
            connection.close();
        %>
    </body>
</html>
