<%@ page import="java.sql.*" %>
<%@ include file="dbutil.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>EcoPlate - Register</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-image: url('background2.png'); /* replace with your actual image path */
            background-size: cover;      /* Make image cover the entire page */
            background-repeat: no-repeat; /* Prevent repeating */
            background-position: center; /* Center the image */
            background-attachment: fixed;;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            width: 350px;
            margin-left: auto;  /* pushes it to the right */
            margin-right: 150px;
        }
        .form-container h2 {
            text-align: center;
            color: #333;
        }
        input, select {
            width: 100%;
            padding: 10px;
            margin: 12px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
        button {
            width: 100%;
            padding: 12px;
            background: #CD9D0B;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }
        .error { color: red; font-size: 12px; }
    </style>
    <script>
        function validateForm() {
            let email = document.forms["regForm"]["email"].value;
            let phone = document.forms["regForm"]["phone"].value;
            let user = document.forms["regForm"]["username"].value;
            let pass = document.forms["regForm"]["password"].value;
            let role = document.forms["regForm"]["role"].value;
            let errMsg = "";

            if (!/^\S+@\S+\.\S+$/.test(email)) {
                errMsg += "Invalid email format.\\n";
            }
            if (!/^\d{10}$/.test(phone)) {
                errMsg += "Phone number must be 10 digits.\\n";
            }
            if (user.length < 3) {
                errMsg += "Username must be at least 3 characters.\\n";
            }
            if (pass.length < 6) {
                errMsg += "Password must be at least 6 characters.\\n";
            }
            if (role === "") {
                errMsg += "Please select a role.\\n";
            }

            if (errMsg !== "") {
                alert(errMsg);
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div class="form-container">
    <h2>Register to EcoPlate</h2>
    <form name="regForm" method="post" onsubmit="return validateForm();">
        <input type="text" name="email" placeholder="Email" required />
        <input type="text" name="phone" placeholder="Phone Number" required />
        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <select name="role" required>
            <option value="">Select Role</option>
            <option value="donor">Donor</option>
            <option value="recipient">Recipient</option>
            <option value="admin">Admin</option>
        </select>
        <button type="submit">Register</button>
    </form>

    <%
        if ("post".equalsIgnoreCase(request.getMethod())) {
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            try {
                String query = "INSERT INTO users (email, phone, username, password, role) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, email);
                stmt.setString(2, phone);
                stmt.setString(3, username);
                stmt.setString(4, password);
                stmt.setString(5, role);

                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    response.sendRedirect("login.jsp");
                } else {
                    response.sendRedirect("error.jsp");
                }
            } catch (Exception e) {
                out.println("<div class='error'>Error: " + e.getMessage() + "</div>");
            }
        }
    %>
</div>
</body>
</html>
