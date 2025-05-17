<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, db.database_Connection" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Teacher Verification</title>
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
            height: 40vh;
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
            height: 30px;
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
        </style>
</head>
<body>
    <%
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;

        try {
            connection = database_Connection.getConnection();

            if (connection != null) {
                if (request.getParameter("verification_Id") != null && request.getParameter("verification_Password") != null) {
                    String verification_Id = request.getParameter("verification_Id");
                    String verification_Password = request.getParameter("verification_Password");

                    // Use PreparedStatement to prevent SQL injection
                    String query = "SELECT * FROM verification WHERE id = ? AND password = ?";
                    preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setString(1, verification_Id);
                    preparedStatement.setString(2, verification_Password);

                    rs = preparedStatement.executeQuery();

                    // Check if any record is returned
                    if (rs.next()) {
                        out.println("<script>alert('Verification Successful!!'); location.href='teacher_Registration.html';</script>");
                    } else {
                        out.println("<script>alert('Verification Failed. Retry!!'); location.href='verify_Teacher.jsp';</script>");
                    }
                }
            }
        } catch (Exception e) {
            // Log the error to the server log and show a generic message
            e.printStackTrace(); // Log the error
            out.println("<script>alert('An error occurred. Please try again later.'); location.href='verify_Teacher.jsp';</script>");
        } finally {
            // Close resources to avoid memory leaks
            try {
                if (rs != null) rs.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                ex.printStackTrace(); // Log the exception
            }
        }
    %>

     <a href="index.html"><button id="bt">Back</button></a>
    <div class="body">
    <div class="formBody">
        <div class="from"></div>
        <form action="">
            <h2>Login</h2>
            <div class="usrName">
                <img src="images/id-card.png" id="id" alt="">
                <input type="text" name="verification_Id" placeholder="verification_Id" required>
            </div>
            <div class="usrPass">
                <img src="images/padlock.png" alt="">
                <input type="password" name="verification_Password" placeholder="Password">
            </div>
            <button type="submit">Verify</button><br>
        </form>
    </div>
</div>
    
</body>
</html>