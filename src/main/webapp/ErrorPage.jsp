<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - TapFoods</title>
    <style>
        /* Basic Reset */
        body, h1, p, a {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .error-container {
            text-align: center;
            background: #ffffff;
            border-radius: 8px;
            padding: 20px 40px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
        }

        .error-container h1 {
            font-size: 48px;
            color: #ff4757;
            margin-bottom: 10px;
        }

        .error-container p {
            font-size: 18px;
            color: #555;
            margin-bottom: 20px;
        }

        .error-container a {
            display: inline-block;
            text-decoration: none;
            background: #ff4757;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            transition: background 0.3s ease;
        }

        .error-container a:hover {
            background: #ff6b81;
        }

        .error-container .icon {
            font-size: 100px;
            color: #ff4757;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="icon">⚠️</div>
        <h1>Error</h1>
        <p><%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "Something went wrong. Please try again later." %></p>
        <a href="index.jsp">Go Back to Home</a>
    </div>
</body>
</html>
