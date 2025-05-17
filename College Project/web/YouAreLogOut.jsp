<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Oops! Logged Out</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 500px;
            margin: 100px auto;
            background: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            font-size: 50px;
            color: #333;
        }
        .message {
            font-size: 20px;
            color: #666;
            margin-bottom: 20px;
        }
        .error-icon {
            font-size: 80px;
        }
        .subtext {
            font-size: 16px;
            color: #888;
        }
        .links {
            margin-top: 20px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px;
            text-decoration: none;
            color: #fff;
            background: #007BFF;
            border-radius: 5px;
        }
        .btn:hover {
            background: #0056b3;
        }
        .error-icon img{
            height: 5cm;
            width: 4cm;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Oops!</h1>
        <p class="message">You are logged out.</p>
        <div class="error-icon"><img src="images/emoji.jpeg" alt="">
        </div>
        <p class="subtext">It looks like your session has expired or you have logged out.</p>
        <div class="links">
            <%
                String suc = request.getParameter("logoutId");
            %>
            <a href="index.html" class="btn">Home Page</a>
            <a id="dynamicLink" class="btn">Login Again</a>

            <script>
                var value = "<%= suc %>";
                var link = document.getElementById("dynamicLink");

                function whichPage() {
                    if (value === "teacher") {
                        link.href = "teacher_Login.jsp";
                    } else if (value === "hod") {
                        link.href = "hod_Login.jsp";
                    } else if (value === "student") {
                        link.href = "student_Login.jsp";
                    } else {
                        link.href = "#"; // Default case to prevent broken links
                    }
                }

                // Call the function to set the correct link on page load
                whichPage();
            </script>
        </div>
    </div>
</body>
</html>
