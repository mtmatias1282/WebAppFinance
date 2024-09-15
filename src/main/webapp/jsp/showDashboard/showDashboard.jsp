<%@ page language="java" contentType="text/html; charset = UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
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
            height: 960px;
            background: white;
            border-radius: 14px;
            overflow: hidden;
            display: flex;
        }

        /* Sidebar */
        .sidebar {
            width: 280px;
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

        .content {
            flex: 1;
            padding: 48px;
            display: flex;
            flex-direction: column;
            gap: 32px;
        }

        /* Content Area */
        .content {
            flex: 1;
            padding: 48px;
            background: white;
            display: flex;
            flex-direction: column;
            gap: 32px;
        }

        .header {
            display: flex;
            justify-content: flex-start;
            align-items: flex-start;
            gap: 20px;
            height: 70px;
        }

        .welcome .title {
            color: #101828;
            font-size: 30px;
            font-weight: 600;
            line-height: 38px;
        }

        .welcome .description {
            color: #475467;
            font-size: 16px;
            font-weight: 400;
            line-height: 24px;
        }

        .summary {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            gap: 24px;
        }

        .summary-item {
            flex: 1;
            height: 162px;
            padding: 24px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 1px 2px rgba(16, 24, 40, 0.06);
            border: 1px solid #EAECF0;
        }

        .summary-title {
            font-size: 16px;
            font-weight: 600;
            color: #101828;
        }

        .summary-balance {
            margin-top: 24px;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .balance-label {
            color: #475467;
            font-size: 14px;
            font-weight: 500;
        }

        .balance-amount {
            font-size: 30px;
            font-weight: 600;
            color: #101828;
        }

        /* Transactions */
        .transactions {
            margin-top: 32px;
            padding-top: 1px;
            border-top: 1px solid #EAECF0;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .transactions-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .transactions-title {
            font-size: 24px;
            font-weight: 600;
            color: #101828;
            margin-top: 10px;
        }

        .view-all {
            margin-top: 10px;
            padding: 10px 16px;
            background: white;
            border: 1px solid #D0D5DD;
            border-radius: 8px;
            box-shadow: 0 1px 2px rgba(16, 24, 40, 0.05);
            color: #344054;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
        }

        .transactions-table {
            border: 1px solid #D0D5DD;
            border-radius: 10px;
            display: flex;
            flex-direction: column;
            max-height: 315px; /* Ajustar según sea necesario */
            overflow-y: auto;
        }

        .transactions-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px;
            border-bottom: 1px solid #EAECF0;
        }

        .transactions-row.header {
            background: #F9FAFB;
            font-weight: bold;
            color: #475467;
            position: sticky;
        }

        .transactions-row:not(.header):nth-child(odd) {
            background: #F6FEF9;
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

        .transaction-cell {
            flex: 1;
            padding: 0 10px;
        }

        .transaction-name {
            display: inline-flex;
            align-items: center;
            gap: 12px;
        }

        .category {

            padding: 2px 8px;
            border-radius: 16px;
            font-weight: 500;
        }

        /* Right Sidebar */
        .sidebar-right {
            width: 392px;
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .system-date {
            text-align: center;
            font-size: 30px;
            font-weight: 600;
            color: #101828;
        }

        /* Notificación bajo el widget */
        .notification {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .pagination-controls {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .pagination-controls .prev,
        .pagination-controls .next {
            color: #344054;
            font-size: 14px;
            cursor: pointer;
        }

        .pagination-controls .dots {
            display: flex;
            gap: 8px;
        }

        .pagination-controls .dot {
            width: 8px;
            height: 8px;
            background: #D1D1D1;
            border-radius: 50%;
        }

        .pagination-controls .dot.active {
            background: #0179FE;
        }

        .view-all-button {
            margin-top: 20px;
            padding: 10px 16px;
            background: white;
            border: 1px solid #D0D5DD;
            border-radius: 8px;
            box-shadow: 0 1px 2px rgba(16, 24, 40, 0.05);
            color: #344054;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            text-align: center;
        }

        .widget {
            display: flex;
            justify-content: center;
            /* Centrar horizontalmente */
            align-items: center;
            /* Centrar verticalmente si es necesario */
            /* O ajusta según tu necesidad */
        }

        /* Card */
        .account-card {
            width: 302px;
            height: 182px;
            background: linear-gradient(90deg, #0179FE 0%, #4893FF 100%);
            border-radius: 19.11px;
            border: 0.96px solid white;
            box-shadow: 7.645569801330566px 9.556962013244629px 15.291139602661133px rgba(0, 0, 0, 0.05);
            position: relative;
            overflow: hidden;
        }

        .card-background {
            width: 624.80px;
            height: 209.30px;
            position: absolute;
            top: 38.65px;
            left: -139.53px;
            opacity: 0.20;
            border: 0.96px solid white;
        }

        .card-details {
            padding: 16px;
            position: relative;
            z-index: 1;
            display: flex;
            justify-content: space-between; /* Alinea el total a la derecha */
            align-items: flex-start; /* Alinea el contenido al inicio verticalmente */
            flex-direction: column; /* Mantener el nombre y el total en columnas separadas */
        }

        .card-title {
            font-size: 15.29px;
            font-weight: 600;
            color: white;
            margin-bottom: 8px; /* Añade un pequeño margen debajo del nombre */
        }

        .spending-summary {
            text-align: right;
            align-self: flex-end; /* Alinea el total a la derecha */
            margin-top: -24px; /* Ajusta la posición del total */
        }

        .spending-amount {
            font-size: 15.29px;
            font-weight: 600;
            color: white;
        }

        .card-icons {
            display: flex;
            gap: 12px;
            margin-top: 20px;
        }

        .card-labels {
            display: flex;
            justify-content: space-around;
            margin-top: 16px;
        }

        /* Categories */
        .categories {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .categories-title {
            font-size: 18px;
            font-weight: 600;
            color: #101828;
        }

        .categoryitems {
            border: 1px solid #D0D5DD;
            border-radius: 10px;
            height: calc(3 * 70px); /* Ajusta la altura según el tamaño de cada categoría */
            overflow-y: auto;
            padding: 10px;
            /* Añadir espacio para el scrollbar */
        }

        .categoryitems::-webkit-scrollbar {
            width: 8px;
        }

        .categoryitems::-webkit-scrollbar-thumb {
            background-color: #D0D5DD;
            border-radius: 4px;
        }

        .categoryitems::-webkit-scrollbar-track {
            background: #F0F0F0;
            margin-right: 10px; /* Añadir espacio entre el scrollbar y el borde */
        }

        .category-item {
            padding: 16px;
            background: white;
            border-radius: 12px;
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        .category-header {
            display: flex;
        }

        .category-header div{
            margin: 0 10px;
        }

        .category-icon {
            width: 40px;
            height: 40px;
            border-radius: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .savings-icon {
            background: #D1FADF;
        }

        .category-info {
            display: flex;
            align-items: center;
        }

        .category-name {
            font-size: 14px;
            font-weight: 500;
            color: #475467;
        }

        .category-balance {
            font-size: 14px;
            font-weight: 400;
            color: #175CD3;
        }

        /* Estilos para el componente de filtrado por fecha */
        .date-filter-component {
            display: flex;
            flex-direction: column;
            gap: 10px;
            align-items: center;
            text-align: center;
            margin-bottom: 20px;
            /* Añade un pequeño margen inferior */
            margin-top: 50px;
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
            box-shadow: 0 1px 2px rgba(16, 24, 40, 0.05);
            color: white;
            margin-top: 20px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
        }

        .pagination-controls .prev[data-enabled="false"],
        .pagination-controls .next[data-enabled="false"] {
            color: #d0d5dd;
            /* Un color más claro para indicar que está deshabilitado */
            cursor: not-allowed;
        }

        .pagination-controls .dot {
            background-color: #d0d5dd;
            /* Color por defecto para los dots inactivos */
            width: 8px;
            height: 8px;
            border-radius: 50%;
            display: inline-block;
            margin: 0 4px;
        }

        .pagination-controls .dot.active {
            background-color: #007BFF;
            /* Color para el dot activo */
        }

        .icon-wrapper {
            display: flex;
            flex-direction: column;
            /* Apila los elementos verticalmente */
            align-items: center;
            gap: 8px;
            /* Espacio entre el icono y el texto */
        }

        .icon-button {
            background-color: white;
            /* Fondo del ícono, ajusta según sea necesario */
            border: none;
            border-radius: 50%;
            width: 50px;
            /* Ajusta el tamaño según tu necesidad */
            height: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
        }

        .icon-label {
            font-size: 14px;
            font-weight: 500;
            color: white;
            /* Color del texto debajo de cada icono */
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }

        .transaction-amount.positive {
            color: #039855;
            font-weight: 600;
            /* Verde */
        }

        .transaction-amount.negative {
            color: #F04438;
            font-weight: 600;
            /* Rojo */
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
    </style>
</head>

<body>
<div class="main-container">
    <div class="sidebar">
        <div class="sidebar-content">
            <div class="logo-container">
                <div class="logo"></div>
                <div class="logo-text">Finances</div>
            </div>
            <div class="menu">
                <div class="menu-item active">
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
                <div class="menu-item">
                    <i class="fa-solid fa-receipt"></i>
                    <a href="${pageContext.request.contextPath}/AccountingController?ruta=showTransactions">Transactions</a>
                </div>
            </div>
            <div class="sidebar-footer"></div>
        </div>
    </div>
    <div class="content">
        <div class="header">
            <div class="welcome">
                <div class="header-title">Welcome</div>
                <div class="header-subtitle">Access & manage your account, categories and transactions
                    efficiently.</div>
            </div>
        </div>
        <div class="summary">
            <div class="summary-item">
                <div class="summary-title">${numberOfAccounts} Accounts</div>
                <div class="summary-balance">
                    <div class="balance-label">Total Current Balance</div>
                    <div class="balance-amount">${totalBalance}</div>
                </div>
            </div>
        </div>
        <div class="transactions">
            <div class="transactions-header">
                <div class="transactions-title">Recent transactions</div>
                <a href="${pageContext.request.contextPath}/AccountingController?ruta=showTransactions" class="view-all">View all</a>
            </div>
            <div class="transactions-table">
                <div class="transactions-row header">
                    <div class="transaction-cell">Transaction</div>
                    <div class="transaction-cell">Amount</div>
                    <div class="transaction-cell">Date</div>
                    <div class="transaction-cell">Category</div>
                </div>
                <c:forEach var="transaction" items="${latestTransactions}" varStatus="status">
                    <c:if test="${status.index < 5}">
                        <div class="transactions-row">
                            <div class="transaction-cell">
                                <div class="transaction-name">${transaction.getConcept()}</div>
                            </div>
                            <div class="transaction-cell transaction-amount
                    <c:choose>
                        <c:when test="${transaction.getTransactionType() == 'Income'}">positive</c:when>
                        <c:when test="${transaction.getTransactionType() == 'Expense'}">negative</c:when>
                        <c:when test="${transaction.getTransactionType() == 'Transfer'}">neutral</c:when>
                    </c:choose>
                ">
                                <c:choose>
                                    <c:when test="${transaction.getTransactionType() == 'Income'}">
                                        +${transaction.getValue()}
                                    </c:when>
                                    <c:when test="${transaction.getTransactionType() == 'Expense'}">
                                        -${transaction.getValue()}
                                    </c:when>
                                    <c:when test="${transaction.getTransactionType() == 'Transfer'}">
                                        ${transaction.getValue()}
                                    </c:when>
                                </c:choose>
                            </div>
                            <div class="transaction-cell">${transaction.getDate()}</div>
                            <div class="transaction-cell category">
                                <c:choose>
                                    <c:when test="${transaction.getTransactionType() == 'Income'}">
                                        <span class="category-label income-category">${transaction.getCategoryName()}</span>
                                    </c:when>
                                    <c:when test="${transaction.getTransactionType() == 'Expense'}">
                                        <span class="category-label expense-category">${transaction.getCategoryName()}</span>
                                    </c:when>
                                    <c:when test="${transaction.getTransactionType() == 'Transfer'}">
                                        <span class="category-label transfer-category">${transaction.getCategoryName()}</span>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="sidebar-right">
        <div class="date-filter-component">
            <form method="get" action="AccountingController">
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
                <input type="hidden" name="ruta" value="showDashboard">
                <button type="submit" class="filter-button">Filter by
                    Date</button>
            </form>
        </div>

        <div class="widget">
            <c:forEach var="account" items="${accounts}">
                <div class="account-card" style="display:none;">
                    <div class="card-details">
                        <div class="card-title">${account.name}</div>
                        <div class="spending-summary">

                            <div class="spending-amount">$${accountDAO.calculateAccountTotal(account)}</div>
                        </div>
                    </div>
                    <div class="card-icons">
                        <!-- Icons here -->
                    </div>
                    <div class="card-labels">
                        <div class="icon-wrapper">
                            <a href="${pageContext.request.contextPath}/AccountingController?ruta=showIncome&accountId=${account.id}">
                                <button class="icon-button incomes-icon">
                                    <i class="fa-solid fa-arrow-up"></i>
                                </button>
                            </a>
                            <span class="icon-label">Incomes</span>
                        </div>
                        <div class="icon-wrapper">
                            <a href="${pageContext.request.contextPath}/AccountingController?ruta=showExpense&accountId=${account.id}">
                                <button class="icon-button expenses-icon"><i class="fa-solid fa-arrow-down"></i></button>
                            </a>
                            <span class="icon-label">Expenses</span>
                        </div>
                        <div class="icon-wrapper">
                            <a href="${pageContext.request.contextPath}/AccountingController?ruta=showTransfer&accountId=${account.id}">
                                <button class="icon-button transfers-icon"><i class="fa-solid fa-money-bill-transfer"></i></button>
                            </a>
                            <span class="icon-label">Transfers</span>
                        </div>
                        <div class="icon-wrapper">
                            <a href="${pageContext.request.contextPath}/AccountingController?ruta=showAccountTransactions&accountId=${account.id}">
                                <button class="icon-button show-icon"><i class="fa-solid fa-eye"></i></button>
                            </a>
                            <span class="icon-label">Show</span>
                        </div>
                    </div>
                </div>
            </c:forEach>

        </div>
        <div class="notification">
            <div class="pagination-controls">
                <span class="prev" data-enabled="false">Previous</span>
                <span class="dots">
                                <c:forEach var="account" items="${accounts}" varStatus="status">
                                    <span class="dot <c:if test=" ${status.first}">active</c:if>"
                                          data-page="${status.index + 1}"></span>
                                </c:forEach>
                            </span>
                <span class="next" data-enabled="true">Next</span>
            </div>
            <a href="${pageContext.request.contextPath}/AccountingController?ruta=showAccount" class="view-all">View all</a>
        </div>

        <div class="categories">
            <div class="categories-title">My Categories</div>
            <div class="categoryitems">
                <c:forEach var="category" items="${categories}">
                    <div class="category-item">
                        <div class="category-header">
                            <a href="${pageContext.request.contextPath}/AccountingController?ruta=showCategoriesTransactions&category=${category.getName()}">
                                <button class="icon-button show-icon"><i
                                        class="fa-solid fa-eye"></i></button>
                            </a>
                            <div class="category-info">
                                <div class="category-name">${category.getName()}</div>
                                <div class="category-balance">$${category.getTotal()}</div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const prevButton = document.querySelector('.prev');
            const nextButton = document.querySelector('.next');
            const dots = document.querySelectorAll('.dot');
            const cards = document.querySelectorAll('.account-card');
            let currentPage = 1;
            const totalPages = dots.length;

            function updatePagination() {
                // Actualizar botones
                prevButton.dataset.enabled = currentPage > 1 ? "true" : "false";
                nextButton.dataset.enabled = currentPage < totalPages ? "true" : "false";

                // Actualizar dots
                dots.forEach(dot => {
                    dot.classList.remove('active');
                    if (parseInt(dot.dataset.page) === currentPage) {
                        dot.classList.add('active');
                    }
                });

                // Actualizar visibilidad de las cartas
                cards.forEach((card, index) => {
                    if (index + 1 === currentPage) {
                        card.style.display = 'block';
                        card.classList.add('fade-in');
                    } else {
                        card.style.display = 'none';
                        card.classList.remove('fade-in');
                    }
                });

                // Actualizar el balance después de cada cambio de página
                updateBalance();
            }

            prevButton.addEventListener('click', function () {
                if (currentPage > 1) {
                    currentPage--;
                    updatePagination();
                }
            });

            nextButton.addEventListener('click', function () {
                if (currentPage < totalPages) {
                    currentPage++;
                    updatePagination();
                }
            });

            updatePagination();
        });
    </script>

</div>
</body>

</html>