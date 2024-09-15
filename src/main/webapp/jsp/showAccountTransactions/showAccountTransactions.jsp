<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Transactions</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://kit.fontawesome.com/1d2e493c85.js" crossorigin="anonymous"></script>
    <style>
        /* General Styles */
        body {
            font-family: 'Inter', sans-serif;
            background-color: #FCFCFD;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1160px;
            margin: 0 auto;
            padding: 48px 32px;
            background-color: white;
            border-radius: 14px;
            overflow: hidden;
        }

        .header {
            margin-bottom: 32px;
            display: flex;
            justify-content: space-between;
        }

        .category-name {
            font-size: 30px;
            font-weight: 600;
            color: #101828;
            line-height: 38px;
        }

        .filter-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .category-type h2 {
            font-size: 18px;
            font-weight: 600;
            color: #101828;
            line-height: 28px;
        }

        .filter-button {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 16px;
            background-color: white;
            border: 1px solid #D0D5DD;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            color: #344054;
            cursor: pointer;
        }

        .filter-icon {
            width: 15px;
            height: 10px;
            border: 1.67px solid #344054;
        }

        .transactions-table {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
        }

        .table-header {
            display: flex;
            background-color: #F9FAFB;
            border-bottom: 1px solid #EAECF0;
        }

        .header-cell {
            flex: 1;
            padding: 12px 24px;
            font-size: 12px;
            font-weight: 500;
            color: #475467;
            line-height: 18px;
        }

        .table-body {
            display: flex;
            flex-direction: column;
        }

        .table-row {
            display: flex;
            border-bottom: 1px solid #EAECF0;
        }

        .table-row:nth-child(even) {
            background-color: #F6FEF9;
        }

        .cell {
            flex: 1;
            padding: 16px 24px;
            display: flex;
            align-items: center;
        }

        .transaction-cell {
            gap: 12px;
        }

        .transaction-icon {
            width: 40px;
            height: 40px;
            border-radius: 24px;
        }

        .transaction-name {
            font-size: 14px;
            font-weight: 500;
            color: #101828;
            line-height: 20px;
        }

        .amount-cell {
            font-weight: 600;
            font-size: 14px;
            line-height: 20px;
        }

        .amount-cell.negative {
            color: #F04438;
        }

        .amount-cell.positive {
            color: #039855;
        }

        .status-badge {
            padding: 2px 8px;
            border-radius: 16px;
            font-size: 12px;
            font-weight: 500;
            line-height: 18px;
        }

        .status-badge.processing {
            background-color: #F2F4F7;
            color: #344054;
        }

        .status-badge.success {
            background-color: #ECFDF3;
            color: #027A48;
        }

        .date-cell {
            font-size: 14px;
            color: #475467;
        }

        .category-badge {
            padding: 2px 8px;
            border-radius: 16px;
            font-size: 12px;
            font-weight: 500;
            line-height: 18px;
        }

        .category-badge.subscriptions {
            border: 1.5px solid #1570EF;
            color: #175CD3;
        }

        .category-badge.deposit {
            border: 1.5px solid #039855;
            color: #027A48;
        }

        .category-badge.groceries {
            border: 1.5px solid #444CE7;
            color: #3538CD;
        }

        .category-badge.income {
            border: 1.5px solid #039855;
            color: #027A48;
        }

        .category-badge.food-and-dining {
            border: 1.5px solid #DD2590;
            color: #C11574;
        }

        .pagination {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 16px;
            border-top: 1px solid #EAECF0;
        }

        .pagination-button {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            font-weight: 600;
            color: #475467;
            background: none;
            border: none;
            cursor: pointer;
        }

        .pagination-icon {
            width: 20px;
            height: 20px;
            border: 1.67px solid #475467;
        }

        .pagination-numbers {
            display: flex;
            gap: 2px;
        }

        .page-number {
            width: 40px;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 14px;
            font-weight: 500;
            color: #475467;
            border-radius: 8px;
            cursor: pointer;
        }

        .page-number.active {
            background-color: #F9FAFB;
            color: #1D2939;
        }

        .date-filter-component {
            display: flex;
            flex-direction: column;
            gap: 10px;
            align-items: center;
            text-align: center;
            margin-bottom: 20px;
        }

        .date-inputs {
            display: flex;
            gap: 20px;
        }

        .date-inputs div {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .date-inputs label {
            color: #344054;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .date-inputs input[type="date"] {
            padding: 10px;
            color: #344054;
            font-size: 16px;
            border: 1px #EAECF0 solid;
            border-radius: 8px;
            cursor: pointer;
        }

        .filter-button-group {
            margin-top: 10px;
        }

        .filter-button {
            padding: 10px 16px;
            background: #0179FE;
            border: none;
            border-radius: 8px;
            box-shadow: 0px 1px 2px rgba(16, 24, 40, 0.05);
            color: white;
            font-size: 14px;
            font-weight: 600;
            cursor:pointer;
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
    </style>
</head>

<body>
<div class="container">
    <header class="header">
        <h1 class="account-name">${account.getName()}</h1>
        <a href="${pageContext.request.contextPath}/AccountingController?ruta=showAccount" class="exit-button">
            <i class="fa-solid fa-arrow-left"></i> Exit
        </a>
    </header>
    <main class="main-content">
        <div class="filter-section">
            <div class="category-type">
                <h2>${category.getName()}</h2>
            </div>
            <div class="date-filter-component">
                <form method="get" action="${pageContext.request.contextPath}/AccountingController?ruta=showAccounts">
                    <div class="date-inputs">
                        <div>
                            <label for="fromDate">From:</label>
                            <input type="date" id="fromDate" name="fromDate" value="${startDate}">
                        </div>
                        <div>
                            <label for="toDate">To:</label>
                            <input type="date" id="toDate" name="toDate" value="${endDate}">
                        </div>
                    </div>
                    <input type="hidden" name="ruta" value="showCategoriesTransactions&category=${category.getName()}">
                    <div class="filter">
                        <button class="filter-button">Filter by Date</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="transactions-table">
            <div class="table-header">
                <div class="header-cell">Transaction</div>
                <div class="header-cell">Amount</div>
                <div class="header-cell">Date</div>
                <div class="header-cell">Category</div>
                <div class="header-cell">Edit</div>
                <div class="header-cell">Delete</div>
            </div>
            <div class="table-body">
                <c:forEach var="transaction" items="${transactions}">
                    <div class="table-row">
                        <div class="cell transaction-cell">
                            <span class="transaction-name">${transaction.getConcept()}</span>
                        </div>
                        <div class="cell amount-cell
                        <c:choose>
                            <c:when test="${transaction.getTransactionType() == 'Expense'}">
                                negative
                            </c:when>
                            <c:when test="${transaction.getTransactionType() == 'Income'}">
                                positive
                            </c:when>
                            <c:when test="${transaction.getTransactionType() == 'Transfer'}">
                                neutral
                            </c:when>
                        </c:choose>">
                                ${transaction.getValue() < 0 ? '- ' : ''}$${transaction.getValue()}
                        </div>
                        <div class="cell date-cell">${transaction.getDate()}</div>
                        <div class="cell category-cell">
                            <span class="category-badge ${transaction.getCategoryName().toLowerCase()}">${transaction.getCategoryName()}</span>
                        </div>
                        <div class="cell edit-cell">
                            <button class="edit-button"><i class="fa-solid fa-pen-to-square"></i></button>
                        </div>
                        <div class="cell delete-cell">
                            <button class="delete-button"><i class="fa-solid fa-trash"></i></button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

    </main>
</div>
</body>

</html>