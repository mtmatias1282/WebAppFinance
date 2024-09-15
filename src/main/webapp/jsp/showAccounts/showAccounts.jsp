<%@ page language="java" contentType="text/html; charset = UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Accounts</title>
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

        .categories-container {
            width: 1440px;
            height: 960px;
            background: white;
            border-radius: 14px;
            overflow: hidden;
            display: flex;
        }

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

        .header {
            padding-left: 32px;
            padding-right: 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-text {
            display: flex;
            flex-direction: column;
            gap: 8px;
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
            font-size: 30px;
            font-weight: 600;
            color: #101828;
        }

        .filter-by-date {
            display: flex;
            align-items: center;
            gap: 8px;
            background: white;
            border: 1px solid #D0D5DD;
            border-radius: 8px;
            padding: 10px 16px;
        }

        .filter-checkbox {
            width: 20px;
            height: 20px;
            border: 1.67px solid #344054;
        }

        .filter-text {
            font-size: 14px;
            font-weight: 600;
            color: #344054;
        }

        /* Category Cards */
        .category-summary {
            padding: 24px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .category-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .category-title {
            font-size: 18px;
            font-weight: 600;
            color: #101828;
        }

        .category-cards {
            display: flex;
            flex-wrap: wrap;
            gap: 40px;
        }

        .category-card {
            width: 302px;
            height: 200px;
            background: linear-gradient(90deg, #0179FE 0%, #4893FF 100%);
            border-radius: 19.11px;
            border: 0.96px solid white;
            box-shadow: 7.65px 9.56px 15.29px rgba(0, 0, 0, 0.05);
            position: relative;
            overflow: hidden;
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

        .label {
            font-size: 14px;
            font-weight: 500;
            color: #344054;
        }

        /* Estilos específicos para la tarjeta de "Add Account" */
        .category-card.add-account-card {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }

        .category-card.add-account-card .card-details {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .category-card.add-account-card .icon-button {
            margin-top: 0; /* Eliminar cualquier margen adicional */
        }

        .category-card.add-account-card .icon-label {
            margin-top: 8px; /* Asegurar que el texto "Add" tenga un espacio adecuado debajo del ícono */
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
            cursor: pointer;
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
    </style>
</head>

<body>
<div class="categories-container">
    <div class="sidebar">
        <div class="sidebar-content">
            <div class="logo-container">
                <div class="logo"></div>
                <div class="logo-text">Finances</div>
            </div>
            <div class="menu">
                <div class="menu-item">
                    <i class="fa-solid fa-house"></i>
                    <a href="${pageContext.request.contextPath}/AccountingController?ruta=showDashboard">Dashboard</a>
                </div>
                <div class="menu-item active">
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
        </div>
    </div>
    <div class="content">
        <div class="header">
            <div class="header-text">
                <div class="header-title">My Accounts</div>
                <div class="header-subtitle">Your Accounts, all in one place</div>
            </div>
        </div>

        <div class="category-cards">
            <c:forEach var="account" items="${accounts}">
                <div class="category-card">
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
            <!-- Add Account Card -->
            <div class="category-card add-account-card">
                <div class="card-details">
                    <div class="card-title">Add Account</div>
                    <div class="card-icons">
                        <!-- Icons here -->
                    </div>
                    <div class="card-labels">
                        <div class="icon-wrapper">
                            <a href="${pageContext.request.contextPath}/AccountingController?ruta=showCreateAccount">
                                <button class="icon-button show-icon">
                                    <i class="fa-solid fa-plus"></i>
                                </button>
                            </a>
                            <span class="icon-label">Add</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
