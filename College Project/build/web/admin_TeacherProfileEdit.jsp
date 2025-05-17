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

    String query = "SELECT * FROM teacher WHERE tId =" +sId;
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
            <form action="admin_TeacherStudent" method="post">
                <input type="hidden" name="sId" value="<%= rs.getInt("tId")%>">
                Name: <input type="text" name="sName" value="<%= rs.getString("tName")%>" required><br>
                Contact: <input type="text" name="sContact" value="<%= rs.getString("tContact")%>" required><br>
                Email: <input type="email" name="sEmail" value="<%= rs.getString("tEmail")%>" required><br>
                <button id="Upd" name="btn" value="0">Update</button>
                <button id="del" name="btn" value="1" onclick="return deletee()">Delete</button>
            </form>
        </div>
    </body>
    
    <script>
function deletee()
            {
                return confirm("Are you sure. This Record Will Delete Permenantly !!");
            }
</script>
    
</html>
<%
    }
%>