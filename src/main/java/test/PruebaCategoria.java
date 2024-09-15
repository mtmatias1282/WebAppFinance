package test;

import modelo.dao.*;
import modelo.dto.TransactionDTO;
import modelo.entidad.*;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class PruebaCategoria {

    public static void main(String[] args) {

        AccountDAO accountDAO = new AccountDAO();
        IncomeDAO incomeDAO = new IncomeDAO();
        ExpenseDAO expenseDAO = new ExpenseDAO();
        TransferDAO transferDAO = new TransferDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        TransactionDAO transactionDAO = new TransactionDAO();

        // 1. Crear tres cuentas (Banco Pichincha, Banco Guayaquil, Produbanco)
        Account pichincha = new Account(null, "Banco Pichincha");
        Account guayaquil = new Account(null, "Banco Guayaquil");
        Account produbanco = new Account(null, "Produbanco");


        accountDAO.addAccount(pichincha);
        accountDAO.addAccount(guayaquil);
        accountDAO.addAccount(produbanco);

        // 2. Crear categorías
        IncomeCategory salario = new IncomeCategory(null, "Salario");
        ExpenseCategory renta = new ExpenseCategory(null, "Renta");
        TransferCategory transferencia = new TransferCategory(null, "Transferencia");

        categoryDAO.addCategory(salario);
        categoryDAO.addCategory(renta);
        categoryDAO.addCategory(transferencia);

        // Crear una instancia de Calendar para manejar fechas
        Calendar calendar = Calendar.getInstance();

        // 3. Registrar ingresos
        calendar.set(2024, Calendar.JANUARY, 15);
        Date fechaIngreso1 = calendar.getTime();

        calendar.set(2024, Calendar.FEBRUARY, 10);
        Date fechaIngreso2 = calendar.getTime();

        Income ingreso1 = new Income(null, 1000.0, fechaIngreso1, "Ingreso 1", pichincha, salario);
        Income ingreso2 = new Income(null, 1500.0, fechaIngreso2, "Ingreso 2", guayaquil, salario);
        Income ingreso3 = new Income(null, 1500.0, fechaIngreso2, "Ingreso 3", guayaquil, salario);

        incomeDAO.registerIncome(ingreso1);
        incomeDAO.registerIncome(ingreso2);
        incomeDAO.registerIncome(ingreso3);


        // 4. Registrar egresos
        calendar.set(2024, Calendar.MARCH, 5);
        Date fechaEgreso1 = calendar.getTime();

        Expense egreso1 = new Expense(null, 500.0, fechaEgreso1, "Egreso 1", pichincha, renta);

        expenseDAO.registerExpense(egreso1);

        // 5. Registrar transferencias
        calendar.set(2024, Calendar.APRIL, 20);
        Date fechaTransferencia = calendar.getTime();

        Transfer transferencia1 = new Transfer(null, 300.0, fechaTransferencia, "Transferencia 1", guayaquil, produbanco, transferencia);

        transferDAO.registerTransfer(transferencia1);

        // Definir el rango de fechas para las pruebas
        calendar.set(2024, Calendar.JANUARY, 1);
        Date fromDate = calendar.getTime();

        calendar.set(2024, Calendar.MARCH, 31);
        Date toDate = calendar.getTime();

        // 6. Probar transacciones por cuenta (contexto de cuenta)
        System.out.println("\nTransacciones de la cuenta Banco Pichincha:");
        List<TransactionDTO> transaccionesPorCuenta = transactionDAO.getTransactionsForAccountContext(fromDate, toDate, pichincha);
        for (TransactionDTO transaccion : transaccionesPorCuenta) {
            System.out.println(transaccion);
        }

        // 7. Probar transacciones por categoría (contexto de categoría)
        System.out.println("\nTransacciones de la categoría Renta:");
        List<TransactionDTO> transaccionesPorCategoria = transactionDAO.getTransactionsForCategoryContext(fromDate, toDate, renta);
        for (TransactionDTO transaccion : transaccionesPorCategoria) {
            System.out.println(transaccion);
        }

        // 8. Probar transacciones para el dashboard
        System.out.println("\nTransacciones para el dashboard:");
        List<TransactionDTO> transaccionesDashboard = transactionDAO.getTransactionsForDashboard(fromDate, toDate);
        for (TransactionDTO transaccion : transaccionesDashboard) {
            System.out.println(transaccion);
        }


        // 9. Calcular el saldo de la cuenta Banco Pichincha
        double saldoPichincha = accountDAO.calculateAccountTotal(pichincha);
        System.out.println("\nSaldo de la cuenta Banco Pichincha: " + saldoPichincha);

        // 10. Calcular el saldo de la cuenta Banco Guayaquil
        double saldoGuayaquil = accountDAO.calculateAccountTotal(guayaquil);
        System.out.println("Saldo de la cuenta Banco Guayaquil: " + saldoGuayaquil);

        // 11. Calcular el saldo de la cuenta Produbanco
        double saldoProdubanco = accountDAO.calculateAccountTotal(produbanco);
        System.out.println("Saldo de la cuenta Produbanco: " + saldoProdubanco);
    }
}
