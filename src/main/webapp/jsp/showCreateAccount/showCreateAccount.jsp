<%@ page language="java" contentType="text/html; charset = UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Account</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://kit.fontawesome.com/1d2e493c85.js" crossorigin="anonymous"></script>
    <style>
        /* General Styles */
        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            background-color: white;
        }

        .income-container {
            height: 684px;
            background: white;
            border-radius: 14px;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .income-content {
            flex: 1;
            margin: 600px;
            padding: 48px 32px 56px;
            background: #FCFCFD;
            display: flex;
            align-content: center;
            flex-direction: column;
            gap: 32px;
            width: 50%;
        }

        .header {
            margin-bottom: 20px;
        }

        .header h1 {
            color: #101828;
            font-size: 30px;
            font-weight: 600;
            line-height: 38px;
            margin-bottom: 8px;
        }

        .header p {
            color: #475467;
            font-size: 16px;
            font-weight: 400;
            line-height: 24px;
            margin: 0;
        }

        .main-content {
            flex: 1;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .section-header h2 {
            color: #101828;
            font-size: 18px;
            font-weight: 600;
            line-height: 28px;
            margin: 0;
        }

        .form-group {
            display: flex;
            gap: 32px;
            margin-bottom: 20px;
        }

        .form-label {
            width: 280px;
        }

        .form-label h3 {
            color: #344054;
            font-size: 14px;
            font-weight: 500;
            line-height: 20px;
            margin: 0 0 8px;
        }

        .form-label p {
            color: #475467;
            font-size: 12px;
            font-weight: 400;
            line-height: 18px;
            margin: 0;
        }

        .form-input input {
            width: 100%;
            padding: 10px 20px;
            font-size: 16px;
            border: 2px solid #D0D5DD;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            width: 100%;
        }

        .form-actions {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }

        .submit-button {
            padding: 14px 16px;
            background: linear-gradient(90deg, #0179FE 0%, #4893FF 100%);
            box-shadow: 0px 1px 2px rgba(16, 24, 40, 0.05);
            border-radius: 8px;
            border: none;
            color: white;
            font-size: 14px;
            font-weight: 600;
            line-height: 20px;
            cursor: pointer;
        }

        .form-input{
            margin: 20px;
        }

        .exit-button {
            padding: 10px 16px;
            background: #F3F4F6; /* Fondo gris claro para diferenciarlo del botón de submit */
            border: none;
            border-radius: 8px;
            color: #475467; /* Color de texto oscuro para contrastar con el fondo */
            font-size: 14px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px; /* Espacio entre el icono y el texto */
            cursor: pointer;
            text-decoration: none; /* Elimina subrayado de enlaces */
            height: 20px;
            width: 50px;
        }

        .exit-button i {
            margin-right: 8px; /* Espacio entre el icono y el texto */
        }

        .head{
            display: flex;
            justify-content: space-between;
        }


    </style>
</head>
<body>
<div class="income-container">
    <div class="income-content">
        <header class="header">
            <div class="head">
                <h1>Add Account</h1>
                <a href="${pageContext.request.contextPath}/AccountingController?ruta=showAccount" class="exit-button">
                    <i class="fa-solid fa-arrow-left"></i> Exit
                </a>
            </div>
            <p>Enter the name of the new account below.</p>
        </header>

        <main class="main-content">
            <!-- Formulario ajustado para enviar datos al controlador -->
            <form class="income-form" action="${pageContext.request.contextPath}/AccountingController?ruta=createAccount" method="post">
                <div class="form-group">
                    <div class="form-label">
                        <h3>Account Name</h3>
                        <p>Please enter the name for the new account.</p>
                    </div>
                    <div class="form-input">
                        <input type="text" id="accountName" name="accountName" required>
                    </div>
                </div>
                <hr>
                <div class="form-actions">
                    <button type="submit" class="submit-button">Add Account</button>
                </div>
            </form>

        </main>
    </div>
</div>
</body>
</html>
