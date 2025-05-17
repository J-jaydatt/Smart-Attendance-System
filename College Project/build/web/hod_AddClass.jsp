<!DOCTYPE html>
<%@ page import="java.sql.*, db.database_Connection" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student Registration </title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: sans-serif;
                background: #bfbfbf;
                margin: 0;
                padding: 0;
                width: 100%;
                height: 100vh;
            }
            .formbody {
                width: 30%;
                margin: 1% auto;
                padding: 20px;
                background: whitesmoke;
                border-radius: 8px;
                border: 1px solid #5218fa;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }
            h2 {
                text-align: center;
                color: #5218fa;
            }
            label {
                display: block;
                margin: 15px 0 5px 10px;
                color: gray;
                font-weight: 300px;
            }
            input {
                width: calc(100% - 40px);
                margin: 0 5px 20px 10px;
                padding: 8px;
                border-radius: 5px;
                border: none;
                border: 1px solid silver;
                background: transparent;
                height: 30px;
            }
            select
            {
                width: 30%;
                margin: 0 5px 5px 5px;
                padding: 5px;
                border-radius: 5px;
                border: none;
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
        </style>


    </head>
    <%
       // int reFreshId = Integer.parseInt(request.getParameter("addId"));

        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;

        connection = database_Connection.getConnection();

        st = connection.createStatement();
        String sql = "Select * from teacher where verified='1'";
        rs = st.executeQuery(sql);
    %>


    <body>

        <button onclick="indexpage(1)" id="back">Back</button>

        <div class="formbody">
            <form onsubmit="return form_Validations()" action="hod_AddNewClass.jsp" method="post">
                <h2>New Class</h2>

                <label for="cName">Name:</label>
                <input type="text" name="class_Name" id="sName" placeholder="Enter your name">
                
                                                                                
                                                                 
                
                <label>Class Teacher<sup>*</sup>:</label>
                <select name="class_Teacher" id="sClass">
                    <option value="choose">Select Teacher</option>
                    <% while (rs.next()) {%>
                    <option value="<%= rs.getString("tName")%>"><%= rs.getString("tName")%></option>
                    <% } %>
                </select><br><br>

                <label>Class Type<sup>*</sup>:</label>
                <select name="class_Type" id="sGender">
                    <option value="choose">Choose</option>
                    <option value="Educational">Educational</option>
                    <option value="Special">Special</option>
                    <option value="Other">Other</option>
                </select><br><br>
                
                <label>Class Strength<sup>*</sup>:</label>
                <select name="class_Strength" id="sStrength">
                    <option value="choose">Choose</option>
                    
                    <%
                      int i=1;
                      for(i=1;i<=100;i++)
                      {
                    %>
                    <option value="<%= i %>"><%= i %></option>
                    <%
                        }
                    %>
                </select><br><br>

                <button type="submit">Submit</button>
            </form>
        </div>
        <script>
            function indexpage(reFreshID) {
                if (reFreshID === 1) {
                    window.location.href = "hod_Index.jsp";
                } else {
                    window.location.href = "index.html";
                }
            }

            function form_Validations() {
                var a = document.getElementById("sName");
                var b = document.getElementById("sClass");
                var c = document.getElementById("sGender");

                const mobilePattern = /^[0-9]{10}$/;
                const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

                // Reset borders before validation
                a.style.border = "1px solid silver";
                b.style.border = "1px solid silver";
                c.style.border = "1px solid silver";


                if (!a.value || !b.value || !c.value) {
                    if (!a.value)
                        a.style.border = "2px solid red";
                    if (!b.value)
                        b.style.border = "2px solid red";
                    if (!c.value)
                        c.style.border = "2px solid red";


                    alert("All fields are mandatory.");
                    return false;
                }

                if (!mobilePattern.test(d.value)) {
                    alert("Please enter a valid 10-digit mobile number.");
                    d.style.border = "2px solid red";
                    return false;
                }

                if (!emailPattern.test(e.value)) {
                    alert("Please enter a valid email address.");
                    e.style.border = "2px solid red";
                    return false;
                }

                return true;
            }

        </script>
        <%

            st.close();
            connection.close();
        %>
    </body>
</html> 

