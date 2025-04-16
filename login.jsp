<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ include file="dbutil.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcoPlate - Login</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url('background2.png'); /* replace with your actual image path */
            background-size: cover;      /* Make image cover the entire page */
            background-repeat: no-repeat; /* Prevent repeating */
            background-position: center; /* Center the image */
            background-attachment: fixed;
            min-height: 100vh;
        }

        .login-container {
            background: #fff;
            padding: 50px 40px;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
            margin-left: auto;  /* pushes it to the right */
            margin-right: 150px; /* optional: spacing from the right edge */
        }


        .login-container h2 {
            font-size: 32px;
            color: #333;
            margin-bottom: 30px;
        }

        input[type="text"], input[type="password"], button {
            width: 100%;
            padding: 15px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #ff7e5f;
            outline: none;
        }

        button {
            background-color: #CD9D0B;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #dcba53;
        }

        .error {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }

        .footer-text {
            font-size: 14px;
            color: #aaa;
            margin-top: 20px;
        }

        .footer-text a {
            color: #6E5405;
            text-decoration: none;
        }

        .footer-text a:hover {
            text-decoration: underline;
        }

        @media screen and (max-width: 500px) {
            .login-container {
                padding: 30px 25px;
            }
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Login to EcoPlate</h2>
    <form method="post">
        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <button type="submit">Login</button>
    </form>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // SQL query to authenticate user
            String sql = "SELECT role FROM users WHERE username=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");

                // Set session attributes
                session.setAttribute("username", username);
                session.setAttribute("role", role);
                session.setAttribute("visitCount", 0);  // Initialize visit count

                // Create a cookie to store the username for 1 hour
                Cookie userCookie = new Cookie("user", username);
                userCookie.setMaxAge(60 * 60);  // 1 hour
                response.addCookie(userCookie);

                // Redirect based on the user's role
                if ("donor".equalsIgnoreCase(role)) {
                    response.sendRedirect("http://localhost/EcoPlate/donordashboard.html");  // Redirect to donor dashboard
                } else if ("recipient".equalsIgnoreCase(role)) {
                    response.sendRedirect("http://localhost/EcoPlate/recipientDashboard.html");  // Redirect to recipient dashboard
                } else if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect("adminDashboard.jsp");  // Redirect to admin dashboard
                } else {
%>
                    <div class="error">Unknown role detected in database.</div>
<%
                }
            } else {
%>
                <div class="error">Invalid username or password!</div>
<%
            }
        } catch (SQLException e) {
%>
            <div class="error">Database error: <%= e.getMessage() %></div>
<%
        }
    }
%>

    <div class="footer-text">
        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>
</div>
</body>
</html>
