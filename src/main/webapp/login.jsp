<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modern Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            background-attachment: fixed;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.15);
            border-radius: 16px;
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.125);
            padding: 40px;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }

        .login-title {
            color: white;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
            letter-spacing: -1px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            color: white;
            margin-bottom: 8px;
            opacity: 0.8;
        }

        .form-input {
            width: 100%;
            padding: 12px 15px;
            border: none;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.3);
            box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.3);
        }

        .submit-btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(to right, #6a11cb 0%, #2575fc 100%);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: bold;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 14px rgba(50, 50, 93, 0.1), 0 3px 6px rgba(0, 0, 0, 0.08);
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
            color: white;
            opacity: 0.7;
        }

        .register-link a {
            color: white;
            text-decoration: underline;
            transition: opacity 0.3s ease;
        }

        .register-link a:hover {
            opacity: 0.8;
        }

        .error-message {
            background: rgba(255, 0, 0, 0.2);
            color: white;
            text-align: center;
            padding: 10px;
            border-radius: 8px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2 class="login-title">Welcome Back</h2>
        
        <form action="login" method="post">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" class="form-input" required placeholder="Enter your email">
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-input" required placeholder="Enter your password">
            </div>
            
            <button type="submit" class="submit-btn">Login</button>
        </form>
        
        <div class="register-link">
            Don't have an account? <a href="register.jsp">Register here</a>
        </div>

        <%-- Display error messages if login fails --%>
        <% if ("invalid".equals(request.getParameter("msg"))) { %>
            <div class="error-message">
                Invalid email or password. Please try again.
            </div>
        <% } %>
    </div>
</body>
</html>