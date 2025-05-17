<!DOCTYPE html>
<%@ page import="java.sql.*, db.database_Connection" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-image: linear-gradient(to right, #3c99dc, #3c99dc);
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
            height: 83vh;
        }
        h2 {
            text-align: center;
            color: #5218fa;
        }
        label {
            display: block;
            margin: 15px 0 5px 10px;
            color: gray;
            font-weight: 500;
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
        button:disabled {
            background-color: #999;
            cursor: not-allowed;
        }
        sup {
            color: orange;
        }
        .error-message {
            color: red;
            font-size: 12px;
            display: none;
            margin-left: 10px;
        }
    </style>

    <script>
        function indexpage() {
            window.location.href = "admin_StudentOperations.jsp";
        }

        function validateMobile() {
            var contact = document.getElementById("sContact");
            var mobileError = document.getElementById("mobileError");
            var mobilePattern = /^[0-9]{10}$/;

            contact.value = contact.value.replace(/\D/g, ''); // Allow only numbers
            if (contact.value.length > 10) {
                contact.value = contact.value.slice(0, 10);
            }

            if (!mobilePattern.test(contact.value)) {
                contact.style.border = "2px solid red";
                mobileError.style.display = "block";
            } else {
                contact.style.border = "1px solid silver";
                mobileError.style.display = "none";
            }
        }

        function form_Validations() {
            var name = document.getElementById("sName");
            var contact = document.getElementById("sContact");
            var email = document.getElementById("sEmail");
            var studentClass = document.getElementById("sClass");
            var gender = document.getElementById("sGender");
            var address = document.getElementById("sAddress");
            var submitBtn = document.getElementById("submitBtn");
            var mobilePattern = /^[0-9]{10}$/;
            var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

            if (!name.value || !contact.value || !email.value || studentClass.value === "choose" || gender.value === "choose" || !address.value) {
                alert("All fields are mandatory.");
                return false;
            }

            if (!mobilePattern.test(contact.value)) {
                alert("Please enter a valid 10-digit mobile number.");
                return false;
            }

            if (!emailPattern.test(email.value)) {
                alert("Please enter a valid email address.");
                return false;
            }
            
            submitBtn.disabled = true; // Disable submit button when form is submitted
            return true;
        }

        window.onload = function () {
            document.getElementById("submitBtn").disabled = false; // Enable submit button when page loads
        };
    </script>
</head>

<%
    int reFreshId = Integer.parseInt(request.getParameter("refreshId"));
    Connection connection = database_Connection.getConnection();
    Statement st = connection.createStatement();
    ResultSet rs;
%>

<body>
    <button onclick="indexpage()">Back</button>

    <div class="formbody">
        <form onsubmit="return form_Validations()" method="post" action="student_Register">
            <h2>Register</h2>
            <input type="hidden" name="rId" value="<%= reFreshId %>">
            
            <label for="sName">Name:</label>
            <input type="text" name="student_Name" id="sName" placeholder="Enter your name">
            
            <label for="sContact">Mobile:</label>
            <input type="text" name="student_Contact" id="sContact" placeholder="Enter your mobile number" maxlength="10" oninput="validateMobile()">
            <small id="mobileError" class="error-message">Invalid mobile number</small>
            
            <label for="sEmail">Email:</label>
            <input type="email" name="student_Email" id="sEmail" placeholder="example@gmail.com">

            <label>Class<sup>*</sup>:</label>
            <select name="student_Class" id="sClass">
                <option value="choose">Select Class</option>
                <%
                    String sql = "SELECT * FROM classes WHERE classType='Educational'";
                    rs = st.executeQuery(sql);
                    while (rs.next()) {
                %>
                <option value="<%= rs.getString("className") %>"><%= rs.getString("className") %></option>
                <% } %>
            </select>

            <label>Gender<sup>*</sup>:</label>
            <select name="student_Gender" id="sGender">
                <option value="choose">Choose</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
            </select>

            <label for="sAddress">Address:</label>
            <input type="text" id="sAddress" name="student_Address" placeholder="Enter your address">

            <button type="submit" id="submitBtn">Submit</button>
        </form>
    </div>

    <% st.close(); connection.close(); %>
</body>
</html>
