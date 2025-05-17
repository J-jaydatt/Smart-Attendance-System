<%@ page import="java.sql.*" %>
<%@ page import="java.sql.*, db.database_Connection" %>
<%
    Connection connection = null;
    Statement st = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    int sId = Integer.parseInt(request.getParameter("Sid"));

    connection = database_Connection.getConnection();

    st = connection.createStatement();

    String query = "SELECT * FROM student WHERE sId =" + sId;
    rs = st.executeQuery(query);

    while(rs.next()) {
%>
<html>
    <head>
        <title>Edit Student</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                text-align: center;
                padding: 20px;
            }
            .container {
                width: 50%;
                margin: auto;
                background: white;
                padding: 20px;
                box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }
            input[type="text"], input[type="email"] {
                width: 70%;
                padding: 15px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            input[type="submit"] {
                background-color: #28a745;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            input[type="submit"]:hover {
                background-color: #218838;
            }
            #del {
                background-color: red;
                color: white; 
                border: none;
                padding: 10px 15px;
                cursor: pointer;
                border-radius: 5px;
                font-size: 16px;
            }
            #del:hover {
                background-color: darkred;
            }
            #Upd {
                background-color: green;
                color: white; 
                border: none;
                padding: 10px 15px;
                cursor: pointer;
                border-radius: 5px;
                font-size: 16px;
            }
            #Upd:hover {
                background-color: darkgreen;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Edit Student Details</h2>
            <form name="studentForm" action="admin_UpdateStudent" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="sId" value="<%= rs.getInt("sId")%>">
                Name: <input type="text" name="sName" value="<%= rs.getString("sName")%>" required><br>
                Class: <input type="text" name="sClass" value="<%= rs.getString("sClass")%>" required><br>
                Contact: <input type="text" name="sContact" value="<%= rs.getString("sContact")%>" required><br>
                Email: <input type="email" name="sEmail" value="<%= rs.getString("sEmail")%>" required><br>
                Address: <input type="text" name="sAddress" value="<%= rs.getString("tAddress")%>" required><br>
                <button id="Upd" name="btn" value="0">Update</button>
                <button id="del" name="btn" value="1" onclick="return deletee()">Delete</button>
            </form>
        </div>
    </body>
    
    <script>
        function deletee() {
            return confirm("Are you sure? This record will be deleted permanently!");
        }

        function validateForm() {
            var name = document.forms["studentForm"]["sName"].value;
            var studentClass = document.forms["studentForm"]["sClass"].value;
            var contact = document.forms["studentForm"]["sContact"].value;
            var email = document.forms["studentForm"]["sEmail"].value;
            var address = document.forms["studentForm"]["sAddress"].value;
            var nameRegex = /^[A-Za-z ]{2,50}$/;
            var classRegex = /^[A-Za-z0-9 ]{1,20}$/;
            var contactRegex = /^[0-9]{10}$/;
            var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            
            if (!nameRegex.test(name)) {
                alert("Invalid Name. Only alphabets and spaces are allowed (2-50 characters). ");
                return false;
            }
            if (!classRegex.test(studentClass)) {
                alert("Invalid Class. Only alphanumeric characters and spaces allowed (1-20 characters).");
                return false;
            }
            if (!contactRegex.test(contact)) {
                alert("Invalid Contact Number. It should be exactly 10 digits.");
                return false;
            }
            if (!emailRegex.test(email)) {
                alert("Invalid Email Format.");
                return false;
            }
            if (address.length < 5) {
                alert("Address must be at least 5 characters long.");
                return false;
            }
            return true;
        }
    </script>
</html>
<%
    }
%>
