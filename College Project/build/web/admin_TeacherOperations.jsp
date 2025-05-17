<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Student Page</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: linear-gradient(to top, #a18cd1 0%, #fbc2eb 100%);
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        
        /* Main Container */
        .main {
            text-align: center;
            background: rgba(255, 255, 255, 0.15);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(12px);
            max-width: 800px;
            width: 98%;
        }

        /* Title */
        h1 {
            font-size: 32px;
            margin-bottom: 25px;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        /* Menu Box */
        .menu_box {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* Options Container */
        .option_main {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 40px;
            margin-top: 20px;
        }

        /* Individual Option */
        .option {
            background: rgba(0, 0, 0, 0.3);
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            transition: transform 0.3s ease, background 0.3s ease;
            cursor: pointer;
            width: 90%;
        }

        .option:hover {
            background: rgba(0, 0, 0, 0.5);
            transform: scale(1.08);
        }

        /* Option Links */
        .option a {
            text-decoration: none;
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* Option Icons */
        .option img {
            width: 70px;
            height: 70px;
            margin-bottom: 12px;
            filter: drop-shadow(3px 3px 6px rgba(0, 0, 0, 0.3));
        }

        /* Option Text */
        .option span {
            font-size: 18px;
            font-weight: bold;
            text-transform: uppercase;
        }

        /* Responsive Design */
        @media (max-width: 600px) {
            .option_main {
                grid-template-columns: 1fr;
            }

            .main {
                padding: 30px;
            }
        }
    </style>
</head>
<body>
    <div class="main">
        <h1>TEACHERS </h1>

        <!-- Display success message -->
        <div class="menu_box">
            <div class="option_main">
                <div class="option">
                    <a href="teacher_Registration.html">
                        <img src="images/man.png" alt="New Customer">
                        <span>Add Teacher</span>
                    </a>
                </div>
                <div class="option">
                    <a href="admin_TeacherList.jsp">
                        <img src="images/profile.png" alt="View Customer">
                        <span>View List</span>
                    </a>
                </div>
                
                <div class="option">
                    <a href="admin_Index.jsp">
                        <span>Back</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
