package test;

import modelo.dao.*;
import modelo.dto.*;
import modelo.entidad.*;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class Main {

    public static void main(String[] args) {
        // Crear instancias de DAO
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

        // 2. Mostrar las cuentas en consola
        List<Account> cuentas = accountDAO.getAllAccounts();
        System.out.println("Cuentas:");
        for (Account cuenta : cuentas) {
            System.out.println(cuenta);
        }

        // 3. Crear categorías
        IncomeCategory salario = new IncomeCategory(null, "Salario");
        ExpenseCategory renta = new ExpenseCategory(null, "Renta");
        TransferCategory transferencia = new TransferCategory(null, "Transferencia");

        // Persistir categorías
        categoryDAO.addCategory(salario);
        categoryDAO.addCategory(renta);
        categoryDAO.addCategory(transferencia);

        // Crear una instancia de Calendar para manejar fechas
        Calendar calendar = Calendar.getInstance();

        // 5. Realizar movimientos en las cuentas

        // Fecha actual
        Date hoy = new Date();

        // Ingresos en diferentes fechas
        calendar.set(2024, Calendar.JANUARY, 15);
        Date fechaIngreso1 = calendar.getTime();

        calendar.set(2024, Calendar.FEBRUARY, 10);
        Date fechaIngreso2 = calendar.getTime();

        calendar.set(2024, Calendar.MARCH, 5);
        Date fechaIngreso3 = calendar.getTime();

        calendar.set(2024, Calendar.APRIL, 20);
        Date fechaIngresoGuayaquil = calendar.getTime();

        calendar.set(2024, Calendar.MAY, 25);
        Date fechaIngresoProdubanco = calendar.getTime();

        // Ingresos
        Income ingreso1 = new Income(null, 1000.0, fechaIngreso1, "Ingreso 1", pichincha, salario);
        Income ingreso2 = new Income(null, 1000.0, fechaIngreso2, "Ingreso 2", pichincha, salario);
        Income ingreso3 = new Income(null, 1000.0, fechaIngreso3, "Ingreso 3", pichincha, salario);
        Income ingresoGuayaquil = new Income(null, 2000.0, fechaIngresoGuayaquil, "Ingreso Guayaquil", guayaquil, salario);
        Income ingresoProdubanco = new Income(null, 5000.0, fechaIngresoProdubanco, "Ingreso Produbanco", produbanco, salario);

        incomeDAO.registerIncome(ingreso1);
        incomeDAO.registerIncome(ingreso2);
        incomeDAO.registerIncome(ingreso3);
        incomeDAO.registerIncome(ingresoGuayaquil);
        incomeDAO.registerIncome(ingresoProdubanco);

        // Fecha para el egreso
        calendar.set(2024, Calendar.JUNE, 15);
        Date fechaEgresoPichincha = calendar.getTime();

        // Egreso
        Expense egresoPichincha = new Expense(null, 2000.0, fechaEgresoPichincha, "Egreso Pichincha", pichincha, renta);
        expenseDAO.registerExpense(egresoPichincha);

        // Fecha para la transferencia
        calendar.set(2024, Calendar.JULY, 30);
        Date fechaTransferenciaGuayaquilProdubanco = calendar.getTime();

        // Transferencia de Guayaquil a Produbanco
        Transfer transferenciaGuayaquilProdubanco = new Transfer(null, 500.0, fechaTransferenciaGuayaquilProdubanco, "Transferencia Guayaquil a Produbanco", guayaquil, produbanco, transferencia);
        transferDAO.registerTransfer(transferenciaGuayaquilProdubanco);


        ///PARA PROBAR QUE SE ELIJAN CATEGORIAS DE INGRESO DE UNA CUENTA
        Calendar calendarTo = Calendar.getInstance();
        calendarTo.set(Calendar.YEAR, 2024);
        calendarTo.set(Calendar.MONTH, Calendar.FEBRUARY); // Mes de febrero
        calendarTo.set(Calendar.DAY_OF_MONTH, 11); // Día 11
        Date toDate = calendarTo.getTime();


        // 4. Mostrar la
        // s categorías con el balance calculado SI VALEEEEEE
        List<CategoryDTO> categorias = categoryDAO.calculateBalanceByDate(new Date(0), new Date());
        System.out.println("\nCategorías con su balance");
        for (CategoryDTO categoria : categorias) {
            System.out.println(categoria);
        }
    }
}