<%@ page language="java" contentType="text/html; charset = UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction History</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://kit.fontawesome.com/1d2e493c85.js" crossorigin="anonymous"></script>
    <style>
        /* General Styles */
        a {
            text-decoration: none;
            color: inherit;
        }

        a:hover {
            color: #007BFF;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #FCFCFD;
            margin: 0;
            padding: 0;
        }

        .main-container {
            width: 1440px;
            height: 1018px;
            background: white;
            border-radius: 14px;
            overflow: hidden;
            display: flex;
        }

        .sidebar {
            width: 280px;
            height: 100%;
            background: white;
            border-right: 1px solid #EAECF0;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .sidebar-content {
            padding-top: 32px;
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .logo-container {
            padding-left: 24px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logo {
            width: 33px;
            height: 32px;
            position: relative;
            background: linear-gradient(1deg, #0058D4 0%, #00245B 100%);
        }

        .logo-text {
            color: #00214F;
            font-size: 28px;
            font-family: 'IBM Plex Serif', serif;
            font-weight: 700;
        }

        .menu {
            padding-left: 16px;
            padding-right: 16px;
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .menu-item {
            padding: 16px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 16px;
            font-weight: 600;
            color: #344054;
        }

        .menu-item.active {
            background: linear-gradient(90deg, #0179FE 0%, #4893FF 100%);
            color: white;
        }

        .menu-item.dashboard {
            background: none;
            color: #344054;
            font-size: 16px;
            font-weight: 600;
        }

        .menu-item.accounts,
        .menu-item.categories,
        .menu-item.transaction-history {
            background: white;
            color: #344054;
            font-size: 16px;
            font-weight: 600;
        }

        .menu-item.transaction-history {
            background: linear-gradient(90deg, #0179FE 0%, #4893FF 100%);
            color: white;
        }

        .content {
            flex: 1;
            padding: 48px;
            background: #FCFCFD;
            display: flex;
            flex-direction: column;
            gap: 32px;
        }

        .header {
            height: 116px;
            padding-left: 32px;
            padding-right: 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-title {
            color: #101828;
            font-size: 30px;
            font-weight: 600;
            line-height: 38px;
            margin-bottom: 20px; /* Añadido un margen inferior para más separación */

        }

        .header-subtitle {
            color: #475467;
            font-size: 16px;
            font-weight: 400;
            line-height: 24px;
            margin-bottom: 20px; /* Añadido un margen inferior para más separación */

        }

        .header-date {
            color: #101828;
            font-size: 30px;
            font-weight: 600;
            line-height: 38px;
        }

        .account-selector {
            /*background: white;
            border: 1px solid #D0D5DD;
            border-radius: 8px;*/
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 16px;
        }

        .checkbox {
            width: 24px;
            height: 24px;
            border: 2px solid #0179FE;
        }

        .account-text {
            color: #344054;
            font-size: 14px;
            font-weight: 600;
        }

        .dropdown-icon {
            width: 10px;
            height: 5px;
            border: 1.67px solid #344054;
        }

        /* Transactions Table Styles */
        .transactions-table {
            border: 1px solid #D0D5DD;
            border-radius: 10px;
            background-color: white;
            border-radius: 8px;
            overflow-y: auto;
            max-height: 400px;
        }

        .table-header {
            display: flex;
            background-color: #F9FAFB;
            border-bottom: 1px solid #EAECF0;
        }

        .transactions-table::-webkit-scrollbar {
            width: 8px;
        }

        .transactions-table::-webkit-scrollbar-thumb {
            background-color: #D0D5DD;
            border-radius: 4px;
        }

        .transactions-table::-webkit-scrollbar-track {
            background: #F0F0F0;
            margin-right: 10px; /* Añadir espacio entre el scrollbar y el borde */
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

        .category-cell {
            display: flex;
            align-items: center;
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

        /* Pagination Styles */
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

        /* Estilos para el componente de filtrado por fecha */
        .date-filter-component {
            display: flex;
            flex-direction: column;
            gap: 10px;
            align-items: center;
            text-align: center;
            margin-bottom: 20px; /* Añade un pequeño margen inferior */
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

        .filter-button {
            padding: 10px 16px;
            background: #0179FE;
            border: none;
            border-radius: 8px;
            box-shadow: 0px 1px 2px rgba(16, 24, 40, 0.05);
            color: white;
            font-size: 14px;
            font-weight: 600;
            margin-top: 10px;
            cursor: pointer;
        }
        /* Estilo para el combo box de selección de categoría */
        .category-combo {
            padding: 10px;
            border: 1px solid #D0D5DD;
            border-radius: 8px;
            font-size: 16px;
            color: #344054;
            background: white;
            cursor: pointer;
            width: 300px;
        }

        .pagination-button[disabled] {
            color: #d0d5dd; /* Un color más claro para indicar que está deshabilitado */
            cursor: not-allowed;
        }

        .page-number.active {
            background-color: #007BFF; /* Color para el número de página activo */
            color: white;
        }

        .page-number {
            background-color: #d0d5dd; /* Color por defecto para los números de página inactivos */
            color: #475467;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
        }
        .amount-cell.negative {
            color: #F04438; /* Rojo para gastos */
        }

        .amount-cell.positive {
            color: #039855; /* Verde para ingresos */
        }

        .amount-cell.transfer {
            color: #1570EF; /* Azul para transferencias */
        }
    </style>
</head>

<body>
<div class="main-container">
    <div class="sidebar">
        <div class="sidebar-content">
            <div class="logo-container">
                <div class="logo">
                    <!-- SVG or other elements aquí -->
                </div>
                <div class="logo-text">Finances</div>
            </div>
            <div class="menu">
                <div class="menu-item">
                    <i class="fa-solid fa-house"></i>
                    <a href="${pageContext.request.contextPath}/AccountingController?ruta=showDashboard">Dashboard</a>
                </div>
                <div class="menu-item">
                    <i class="fa-solid fa-coins"></i>
                    <a href="${pageContext.request.contextPath}/AccountingController?ruta=showAccount">My Accounts</a>
                </div>
                <div class="menu-item">
                    <i class="fa-solid fa-layer-group"></i>
                    <a href="${pageContext.request.contextPath}/AccountingController?ruta=showCategories">Categories</a>
                </div>
                <div class="menu-item active">
                    <i class="fa-solid fa-receipt"></i>
                    <a href="${pageContext.request.contextPath}/AccountingController?ruta=showTransactions">Transactions</a>
                </div>
            </div>
        </div>
    </div>
    <div class="content">
        <div class="header">
            <div class="header-content">
                <div class="header-text">
                    <div class="header-title">Transaction history</div>
                    <div class="header-subtitle">Keep a Track Your Transactions Over Time</div>
                </div>
                <div class="account-selector">
                    <form method="get" action="${pageContext.request.contextPath}/AccountingController">
                        <select name="accountId" id="accountSelect" class="category-combo">
                            <option value="all">All Accounts</option>
                            <c:forEach var="account" items="${accounts}">
                                <option value="${account.id}">${account.name}</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" name="ruta" value="showTransactions">
                        <button type="submit" class="filter-button">Filter</button>
                    </form>
                </div>
            </div>

            <!-- Aquí se integra el componente de filtrado por fecha -->
            <div class="date-filter-component">
                <form method="get" action="${pageContext.request.contextPath}/AccountingController">
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
                    <input type="hidden" name="ruta" value="showTransactions">
                    <button type="submit" class="filter-button">Filter by
                        Date</button>
                </form>
            </div>
        </div>

        <div class="transactions-table">
            <div class="table-header">
                <div class="header-cell">Concept</div>
                <div class="header-cell">Amount</div>
                <div class="header-cell">Origin Account</div>
                <div class="header-cell">Destination Account</div>
                <div class="header-cell">Date & Time</div>
                <div class="header-cell">Category</div>
                <div class="header-cell">Actions</div>
            </div>
            <div class="table-body">
                <c:forEach var="transaction" items="${transactions}">
                    <div class="table-row">
                        <div class="cell transaction-cell">
                            <span class="transaction-name">${transaction.getConcept()}</span>
                        </div>
                        <div class="cell amount-cell ${transaction.transactionType == 'Expense' ? 'negative' : transaction.transactionType == 'Income' ? 'positive' : 'transfer'}">
                            <c:choose>
                                <c:when test="${transaction.transactionType == 'Expense'}">
                                    - $${Math.abs(transaction.value)}
                                </c:when>
                                <c:when test="${transaction.transactionType == 'Income'}">
                                    + $${transaction.value}
                                </c:when>
                                <c:otherwise>
                                    $${transaction.value}
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="cell origin-account-cell">${transaction.getOriginAccount()}</div>
                        <div class="cell destination-account-cell">${transaction.getDestinationAccount() }</div>
                        <div class="cell date-cell">${transaction.getDate()}</div>
                        <div class="cell category-cell">${transaction.getCategoryName()}</div>
                        <div class="cell edit-cell">
                            <button class="edit-button"><i class="fa-solid fa-pen-to-square"></i></button>
                            <button class="delete-button"><i class="fa-solid fa-trash"></i></button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

    </div>
</div>
</body>

</html>
