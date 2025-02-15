<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed - TapFoods</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f2f5;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .confirmation-container {
            text-align: center;
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 90%;
        }

        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 28px;
        }

        .checkmark-circle {
            width: 100px;
            height: 100px;
            position: relative;
            display: inline-block;
            vertical-align: top;
            margin-bottom: 20px;
        }

        .checkmark-circle .background {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: #2ecc71;
            position: absolute;
        }

        .checkmark-circle .checkmark {
            border-radius: 5px;
        }

        .checkmark-circle .checkmark.draw:after {
            animation-delay: 100ms;
            animation-duration: 1s;
            animation-timing-function: ease;
            animation-name: checkmark;
            transform: scaleX(-1) rotate(135deg);
            animation-fill-mode: forwards;
        }

        .checkmark-circle .checkmark:after {
            opacity: 1;
            height: 50px;
            width: 25px;
            transform-origin: left top;
            border-right: 7px solid #fff;
            border-top: 7px solid #fff;
            content: '';
            left: 25px;
            top: 50px;
            position: absolute;
        }

        @keyframes checkmark {
            0% {
                height: 0;
                width: 0;
                opacity: 1;
            }
            20% {
                height: 0;
                width: 25px;
                opacity: 1;
            }
            40% {
                height: 50px;
                width: 25px;
                opacity: 1;
            }
            100% {
                height: 50px;
                width: 25px;
                opacity: 1;
            }
        }

        .message {
            font-size: 18px;
            margin-bottom: 30px;
            color: #555;
            line-height: 1.6;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            font-size: 16px;
            font-weight: 600;
            color: #fff;
            background-color: #2ecc71;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.1s ease;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .btn:hover {
            background-color: #27ae60;
        }

        .btn:active {
            transform: translateY(1px);
        }
    </style>
</head>
<body>
    <div class="confirmation-container">
        <div class="checkmark-circle">
            <div class="background"></div>
            <div class="checkmark draw"></div>
        </div>
        <h1>Order Confirmed!</h1>
        <p class="message">Thank you for choosing TapFoods. Your delicious meal is on its way! We hope you enjoy your food.</p>
        <a href="index.jsp" class="btn">Back to Menu</a>
    </div>
</body>
</html>

