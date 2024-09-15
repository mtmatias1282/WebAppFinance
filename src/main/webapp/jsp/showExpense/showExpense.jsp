<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Expense Form</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://kit.fontawesome.com/1d2e493c85.js" crossorigin="anonymous"></script>
    <style>
        /* General Styles */
        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            background-color: white;
            align-content: center;
            display: flex;
        }

        .income-container {
            width: 100%;
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
            align-items: center;
            padding: 48px 32px 56px;
            background: #FCFCFD;
            display: flex;
            flex-direction: column;
            gap: 32px;

        }

        .header {
            display: flex;
            align-items: center;
            flex-direction: column;
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

        .income-details{
            width: 100%;
        }

        .main-content {
            flex: 1;
            width: 50%;
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

        .icon {
            width: 1.67px;
            height: 13.33px;
            border: 1.67px #98A2B3 solid;
        }

        hr {
            border: none;
            height: 1px;
            background-color: #EAECF0;
            margin: 20px 0;
        }

        .income-form .form-group {
            display: flex;
            gap: 32px;
            margin-bottom: 20px;
            width: 100%;
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

        .form-input {
            width: 512px;
        }

        .select-wrapper,
        .note-input,
        .amount-input {
            width: 100%;
            padding: 10px 16px;
            background: white;
            box-shadow: 0px 1px 2px rgba(16, 24, 40, 0.05);
            border-radius: 8px;
            border: 1px #D0D5DD solid;
        }

        .select-wrapper {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .select-icon {
            width: 20px;
            height: 14px;
            border: 2px #0179FE solid;
        }

        .dropdown-icon {
            width: 10px;
            height: 5px;
            border: 1.67px #344054 solid;
        }

        .note-input {
            height: 140px;
            font-size: 16px;
            font-weight: 400;
            line-height: 24px;
            color: #101828;
            resize: none;
        }

        .amount-input {
            font-size: 16px;
            color: #475467;
            font-weight: 400;
            line-height: 24px;
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

        .select-category{
            width: 100%;
            padding: 10px 16px;
            background: white;
            border-radius: 8px;
            border: 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
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
        }

        .exit-button i {
            margin-right: 8px; /* Espacio entre el icono y el texto */
        }

    </style>
</head>

<body>
<div class="income-container">
    <div class="income-content">
        <header class="header">
            <h1>Expense</h1>

            <p>Please provide any specific details or notes related to the expense</p>
        </header>
        <main class="main-content">
            <section class="income-details">
                <div class="section-header">
                    <h2>Expense Details</h2>
                    <a href="${pageContext.request.contextPath}/AccountingController?ruta=showAccount" class="exit-button">
                        <i class="fa-solid fa-arrow-left"></i> Exit
                    </a>
                </div>
                <hr>
            </section>
            <!-- Actualización del formulario -->
            <form class="income-form" action="${pageContext.request.contextPath}/AccountingController?ruta=addExpense" method="post"
            onsubmit="return validarFormulario()">
                <input type="hidden" name="accountId" value="${account.id}">
                <div class="form-group">
                    <div class="form-label">
                        <h3>Select Category</h3>
                        <p>Select the category related to the expense</p>
                    </div>
                    <div class="form-input">
                        <div class="amount-input">
                            <select class="select-category" name="expenseCategoryId" required>
                                <c:forEach items="${expenseCategories}" var="category">
                                    <option value="${category.id}">${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="form-group">
                    <div class="form-label">
                        <h3>Concept</h3>
                        <p>Please provide any additional information or instructions related to the expense</p>
                    </div>
                    <div class="form-input">
                        <input class="note-input" type="text" name="concept" required/>
                    </div>
                </div>
                <hr>
                <div class="form-group">
                    <div class="form-label">
                        <h3>Amount</h3>
                    </div>
                    <div class="form-input">
                        <input type="number" class="amount-input" name="amount" step="0.01" required>
                    </div>
                </div>
                <div class="form-actions">
                    <hr>
                    <button class="submit-button" type="submit">Add Expense</button>
                </div>
            </form>
        </main>
    </div>
</div>
<script>
    function validarFormulario() {
        var categoria = document.getElementById('expenseCategoryId').value;
        var concepto = document.getElementById('concepto').value;
        var valor = document.getElementById('valor').value;

        if (categoria === "") {
            alert("Por favor, seleccione una categoría.");
            return false;
        }

        if (concepto.trim() === "") {
            alert("Por favor, ingrese un concepto.");
            return false;
        }

        if (valor === "" || isNaN(valor) || parseFloat(valor) <= 0) {
            alert("Por favor, ingrese un valor válido mayor que cero.");
            return false;
        }
        return true;
    }
</script>
</body>
</html>
