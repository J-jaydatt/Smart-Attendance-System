<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, db.database_Connection" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hod Edit Profile</title>
        <script>
            function logout() {
                return confirm("Are you sure You want to Logout ?");
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
            form button {
    margin-top: 35%;
    display: flex;
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

            #topOption{
                margin-top: 20px;
            }
            .footer
            {
                display: flex;
            }

            /* Main Form UI */
            .mainbody {
                background-color: #f4f3ef;
                height: 100vh;
                width: 77%;
                margin-left: 20%;
                padding: 20px;
            }

            .formmain {
                width: 50%;
                height: 90vh;
                margin-left: 3%;
                border-radius: 10px;
                background: white;
                float: left;
            }

            .head {
                margin: -1px;
                background-color: #0d6efd;
                border-radius: 10px 10px 0px 0px;
                height: 15vh;
                display: flex;
            }

            .head img {
                height: 3cm;
                width: 3cm;
                border-radius: 60px;
                margin: 10% 38%;
                border: 1px solid white;
            }

            input[type="file"] {
                display: none;
                width: 100%;
            }

            #custom-file-upload {
                cursor: pointer;
                width: 100px;
                margin-top: -40px;
                margin-left: 60%;
                text-align: center;
                background-color: orange;
                padding: 5px;
                color: whitesmoke;
                border-radius: 5px;
            }

            .body {
                margin-top: 10%;
                display: flex;
                flex-direction: column;
                margin-left: 5%;
            }

            .body input {
                height: 30px;
                width: 70%;
                margin-bottom: 20px;
                border: 1px grey solid;
                border-radius: 5px;
            }

            .body label {
                margin: 20px 10px 5px 0px;
                font-size: 15px;
            }

            .footer button {
                margin: 4% 0% 0% 5%;
                height: 30px;
                width: 25%;
                background: #0d6efd;
                border: none;
                color: white;
                border-radius: 5px;
            }

            .themeImg {
                width: 45%;
                margin-left: 55%;
                height: 60vh;
            }

            .themeImg img {
                height: 60vh;
                width: 90%;
            }

            #lg {
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

            .passwordChange input {
                width: 80%;
            }

            /* Pop-up Styling */
            .popup {
                position: fixed;  /* Fixed on the screen */
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);  /* Semi-transparent background */
                display: none;  /* Hidden by default */
                justify-content: center;
                align-items: center;
                z-index: 9999;  /* Ensure it's on top of other content */
            }

            .popup-content {
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                text-align: center;
                width: 30%;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);

            }
            .popup-content input
            {
                height: 30px;
                border-radius: 10px;
                margin: 10px;
                border: 1px  solid slategray;
                width: 50%;
            }

            #submitPasswordForm {
                background-color: orange;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                width: 30%;
            }

            #submitPasswordForm:hover {
                background-color: #fdaa48;
            }
            #cancelButton {
                background-color: orange;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                width: 30%;
            }

            #cancelButton:hover {
                background-color: #fdaa48;
            }
            /* Remove default focus border only for password inputs */
            #newPassword, #confirmPassword {
                outline: none;
            }

            /* Green border when passwords match */
            .match {
                border: 2px solid green !important;
            }

            /* Red border when passwords don't match */
            .mismatch {
                border: 2px solid red !important;
            }

            /* Full-screen loader */
            #loader {
                position: fixed;
                width: 100%;
                height: 100%;
                background: white;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 24px;
                font-weight: bold;
            }

            /* Hide content initially */
            #content {
                display: none;
                text-align: center;
                margin-top: 50px;
                font-size: 24px;
            }
            .logoutform form button{
                margin-top: 35%;
                display: flex;
                background: none;
                border:none
            }
            .logoutform form span{
                margin-top: 4%;
                font-size: 20px;
                margin-left: 5px;
            }

        </style>
    </head>

    <body>
        <%

            response.setHeader("Cache-Control", "no-cashe , no-store ,must-revalidate");
            if (session.getAttribute("id") == null) {
                response.sendRedirect("YouAreLogOut.jsp?logoutId=hod");
            } else {

        %>

        <%            
            Connection connection = null;
            Statement st = null;
            ResultSet rs = null;
            int id = 0, userId = 0;
            String name = "", email = "", mob = "", password = "", base64Image = "";

            connection = database_Connection.getConnection();

            st = connection.createStatement();

            if (session.getAttribute("id") == null) {
                // Handle session if not available
            } else {
                userId = Integer.parseInt(session.getAttribute("id").toString());

                String sql = "select * from teacher where tId=" + userId;
                rs = st.executeQuery(sql);
                while (rs.next()) {

                
                byte[] imageData = rs.getBytes("img");

                if (imageData != null) {
                    base64Image = java.util.Base64.getEncoder().encodeToString(imageData);
                } else {
                    base64Image = ""; // Or provide a default image
                }
                    id = rs.getInt("tid");
                    name = rs.getString("tName");
                    email = rs.getString("tEmail");
                    mob = rs.getString("tContact");
                    password = rs.getString("tpassword");
                }
            }

            st.close();
            connection.close();

            String suc = request.getParameter("success");
            String f = request.getParameter("fail");
            String fe = request.getParameter("messagee");

            String message = request.getParameter("message");
            if (message != null && !message.isEmpty()) {
        %>
        <script type="text/javascript">
            alert("<%= message%>");
        </script>
        <%
            }
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
            if (f != null && !f.isEmpty()){
        %>
        <script type="text/javascript">
             alert("<%= f%>");
        </script>
        <%}%>


        <div class="navmain">
        <div class="profile">
            <%if(base64Image!=null){%>
            <img src="data:image/jpeg;base64,<%= base64Image %>" id="logo" alt="">
            <%}else{
            %>
            <img src="images/user.png" id="logo" alt="">
            <%}%>
            <h4><%= name %></h4>
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
        <div class="mainbody" id="mainbody">

            <div id="popup" class="popup">
                <div class="popup-content">
                    <h2>Change Password</h2>
                    <label id="red" style="display:none; color: red;">All fields are mandatory</label>
                    <form action="teacher_PasswordUpadate" id="passwordForm" method="POST">
                        <input type="hidden" name="passid" value="<%= id%>">
                        <input type="text" id="oldPassword" name="oldPassword" placeholder="Old Password" required><br>
                        <input type="text" id="newPassword" name="newPassword" placeholder="New Password" required><br>
                        <input type="text" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required><br>
                        <button type="button" id="cancelButton">Cancel</button>
                        <button type="submit" id="submitPasswordForm">Submit</button>  
                    </form>
                </div>
            </div>

            <div id="fm" class="formmain">
                <form action="teacher_Update" method="POST" enctype="multipart/form-data">
                    <div class="head">
                        <%if (base64Image != null) {%>
                        <img src="data:image/jpeg;base64,<%= base64Image%>" id="logo" alt="" name="photo">
                        <%} else 
                        {
                        %>
                        <img src="images/user.png" id="logo" alt="" photo="photo">
                        <%}%>
                        <input id="file-upload" name="photo" type="file" />
                    </div>
                    <div class="body">
                        <label for="file-upload" id="custom-file-upload">Choose Photo</label>
                        <label for=""> Id</label>
                        <input type="text" value="<%= id%>" name="id" readonly placeholder="Current Id">
                        <label for="">Name</label>
                        <input type="text" value="<%= name%>"  readonly name="name" placeholder="old name">
                        <label for="">Email</label>
                        <input type="email" value="<%= email%>" id="email" name="email" placeholder="Email">
                        <label for="">Mobile</label>
                        <input type="text" value="<%= mob%>"  readonly id="mob" name="mob" placeholder="Contact">
                        <label for="">Password</label>
                        <input type="password"  readonly name="password" id="pass" value="<%= password%>" />
                    </div>

                    <div class="footer">
                        <button id="sv">Save</button>
                        <button type="button" id="sh" onclick="showpass()">Show</button>
                        <button type="button" id="hi" onclick="showpass()" style="display: none">Hide</button>
                </form> 
                <button type="button" id="changePasswordBtn">Change Password</button>

            </div>

        </div>

    </div>

    <div class="themeImg">
        <img src="images/freepik__upload__28965-removebg-preview.png" alt="">
    </div>

    <script>
        // Show password logic
        var v1 = document.getElementById("pass");
        var v2 = document.getElementById("hi");
        var v3 = document.getElementById("sh");

        function showpass() {
            if (v1.type === "password") {
                v1.type = "text";
                v2.style.display = "inline-block";
                v3.style.display = "none";
            } else {
                v2.style.display = "none";
                v3.style.display = "inline-block";
                v1.type = "password";
            }
        }

        document.getElementById("passwordForm").addEventListener("submit", function (event) {
            event.preventDefault(); // Prevent default form submission

            var correctOldPassword = "<%= password%>";

            var oldPassword = document.getElementById("oldPassword").value.trim();
            var newPassword = document.getElementById("newPassword").value.trim();
            var confirmPassword = document.getElementById("confirmPassword").value.trim();
            var warning = document.getElementById("red");

            // Show error if any field is empty
            if (!oldPassword || !newPassword || !confirmPassword) {
                warning.style.display = "block";  // Show "All fields are mandatory" message
                return;  // Stop further execution
            } else {
                warning.style.display = "none";  // Hide error message if all fields are filled
            }
            if (oldPassword !== correctOldPassword) {
                alert("Old password is incorrect.");
                document.getElementById("oldPassword").style.border = "2px solid red"; // Make the field red
                return;  // Stop further execution
            } else {
                document.getElementById("oldPassword").style.border = "1px solid slategray"; // Reset border
            }

            // Check if new password and confirm password match
            if (newPassword !== confirmPassword) {
//                document.getElementById("newPassword").style.border = "2px solid red";
//                document.getElementById("confirmPassword").style.border = "2px solid red";
                alert("New password and confirm password do not match.");
                return;  // Stop further execution
            } else
            {
//             document.getElementById("newPassword").style.border = "2px solid green";
//                document.getElementById("confirmPassword").style.border = "2px solid green";   
            }


            // If all validations pass, submit the form
            this.submit();
        });

        document.addEventListener("DOMContentLoaded", function () {
            const newPassword = document.getElementById("newPassword");
            const confirmPassword = document.getElementById("confirmPassword");

            function validatePassword() {
                // Remove existing border styles
                confirmPassword.classList.remove("match", "mismatch");

                if (confirmPassword.value.trim() === "") {
                    return; // Don't apply styles if empty
                }

                if (newPassword.value === confirmPassword.value) {
                    confirmPassword.classList.add("match"); // Green border
                } else {
                    confirmPassword.classList.add("mismatch"); // Red border
                }
            }

            // Check while typing in both fields
            newPassword.addEventListener("input", validatePassword);
            confirmPassword.addEventListener("input", validatePassword);
        });



// Fix: Prevent popup from closing immediately
        const changePasswordBtn = document.getElementById('changePasswordBtn');
        const popup = document.getElementById('popup');
        //const closePopupButton = document.getElementById('closePopup');
        const cancelButton = document.getElementById('cancelButton');


        document.getElementById("changePasswordBtn").addEventListener("click", function () {
            document.getElementById("popup").style.display = "flex";
        });

        document.getElementById("cancelButton").addEventListener("click", function () {
            document.getElementById("popup").style.display = "none";
        });

// Ensure clicking outside the modal closes it
        document.getElementById("popup").addEventListener("click", function (event) {
            if (event.target === document.getElementById("popup")) {
                document.getElementById("popup").style.display = "none";
            }
        });


    </script>



    <!--window loading effect--> 

    <div id="loader">Loading...</div>

    <!-- Content -->
    <div id="content">
        Page Loaded Successfully!
    </div>

    <script>
        // Wait until the page fully loads
        window.onload = function () {
            document.getElementById("loader").style.display = "none"; // Hide loader
            document.getElementById("content").style.display = "block"; // Show content
        };
    </script>
    <%}%>
</body>
</html>
