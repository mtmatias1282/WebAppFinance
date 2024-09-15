<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="5; url=/WebAppFinance/AccountingController?ruta=showDashboard"/>
    <title>Bienvenidos</title>
    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: 'Arial', sans-serif;
            background: linear-gradient(45deg, #6e45e2, #88d3ce);
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }
        .container {
            text-align: center;
            color: white;
        }
        h1 {
            font-size: 4em;
            margin-bottom: 20px;
            animation: fadeInUp 1s ease-out;
        }
        p {
            font-size: 1.5em;
            animation: fadeInUp 1s ease-out 0.5s both;
        }
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .loader {
            width: 50px;
            height: 50px;
            border: 5px solid #f3f3f3;
            border-top: 5px solid #3498db;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 20px auto;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Bienvenidos</h1>
    <p>Cargando su dashboard...</p>
    <div class="loader"></div>
</div>
</body>
</html>