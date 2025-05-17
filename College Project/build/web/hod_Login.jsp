<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, db.database_Connection" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>HOD Login</title>
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
            height: 40px;
            width: 70%;
            margin-left: 13%;
            border-radius: 5px;
            border: none;  
        }
        input::placeholder
        {
            font-size: 15px
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
    <div class="body">
        <div class="formBody">
            <form action="LoginServlet" method="post">
                <h2>HOD Login</h2>
                <input type="text" placeholder="User ID" name="hod_Id" required>
                <input type="password" placeholder="Password" name="hod_Password" required>
                <button type="submit">Login</button>
                
            </form>
                                    
        </div>
    </div>
</body>
</html>
