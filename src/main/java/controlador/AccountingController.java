package controlador;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.dao.*;
import modelo.dto.*;
import modelo.dto.TransactionDTO;
import modelo.entidad.*;

import java.util.stream.Collectors;

@WebServlet("/AccountingController")
public class AccountingController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private AccountDAO accountDAO;
    private TransactionDAO transactionDAO;
    private CategoryDAO categoryDAO;
    private IncomeCategoryDAO incomeCategoryDAO;
    private ExpenseCategoryDAO expenseCategoryDAO;
    private IncomeDAO incomeDAO;
    private ExpenseDAO expenseDAO;
    private TransferDAO transferDAO;
    private TransferCategoryDAO transferCategoryDAO;


    @Override
    public void init() throws ServletException {
        super.init();
        accountDAO = new AccountDAO();
        transactionDAO = new TransactionDAO();
        categoryDAO = new CategoryDAO();
        incomeCategoryDAO = new IncomeCategoryDAO();
        expenseCategoryDAO = new ExpenseCategoryDAO();
        incomeDAO = new IncomeDAO();
        expenseDAO = new ExpenseDAO();
        transferDAO = new TransferDAO();
        transferCategoryDAO =  new TransferCategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.ruteador(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String ruta = req.getParameter("ruta");

        switch (ruta) {
            case "createAccount":
                createAccount(req, resp);
                break;
            case "addIncome":
                handleTransaction(req, resp, TransactionType.INCOME);
                break;
            case "addExpense":
                handleTransaction(req, resp, TransactionType.EXPENSE);
                break;
            case "addTransfer":
                handleTransfer(req, resp);
                break;
            default:
                ruteador(req, resp);
        }
    }
    private void showExpense(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accountIdStr = req.getParameter("accountId");
        Account account = null;
        if (accountIdStr != null && !accountIdStr.isEmpty()) {
            try {
                int accountId = Integer.parseInt(accountIdStr);
                account = accountDAO.getAccountById(accountId);

            } catch (NumberFormatException e) {
                System.out.println("showExpense - Error parsing accountId: " + e.getMessage());
            }
        }
        List<ExpenseCategory> expenseCategories = expenseCategoryDAO.getAllExpenseCategories();

        req.setAttribute("expenseCategories", expenseCategories);

        req.setAttribute("account", account);

        req.getRequestDispatcher("jsp/showExpense/showExpense.jsp").forward(req, resp);
    }

    private void handleTransaction(HttpServletRequest req, HttpServletResponse resp, TransactionType type) throws IOException {
        String accountIdStr = req.getParameter("accountId");
        if (accountIdStr == null || accountIdStr.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "No se ha proporcionado un ID de cuenta válido.");
            return;
        }

        try {
            int accountId = Integer.parseInt(accountIdStr);
            HttpSession session = req.getSession();
            session.setAttribute("currentAccountId", accountId);

            String amountStr = req.getParameter("amount");
            String concept = req.getParameter("concept");
            String categoryIdStr = req.getParameter(type == TransactionType.INCOME ? "incomeCategoryId" : "expenseCategoryId");

            double amount = Double.parseDouble(amountStr);
            int categoryId = Integer.parseInt(categoryIdStr);

            Account account = accountDAO.getAccountById(accountId);
            Object category = type == TransactionType.INCOME ?
                    incomeCategoryDAO.getIncomeCategoryById(categoryId) :
                    expenseCategoryDAO.getExpenseCategoryById(categoryId);

            if (account != null && category != null) {
                Object transaction = type == TransactionType.INCOME ?
                        new Income(null, amount, new Date(), concept, account, (IncomeCategory)category) :
                        new Expense(null, amount, new Date(), concept, account, (ExpenseCategory)category);

                if (type == TransactionType.INCOME) {
                    incomeDAO.registerIncome((Income)transaction);
                } else {
                    expenseDAO.registerExpense((Expense)transaction);
                }

                resp.sendRedirect(req.getContextPath() + "/AccountingController?ruta=showAccountTransactions&accountId=" + accountId);
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cuenta o categoría no válida.");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Formato de número inválido.");
        }
    }
    private void handleTransfer(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String sourceAccountIdStr = req.getParameter("sourceAccountId");
        String destinationAccountIdStr = req.getParameter("destinationAccountId");
        String categoryIdStr = req.getParameter("categoryId");
        String concept = req.getParameter("concepto");
        String amountStr = req.getParameter("valor");

        if (sourceAccountIdStr == null || destinationAccountIdStr == null || categoryIdStr == null ||
                sourceAccountIdStr.isEmpty() || destinationAccountIdStr.isEmpty() ||
                categoryIdStr.isEmpty() || amountStr == null || amountStr.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Todos los campos son obligatorios.");
            return;
        }

        try {
            int sourceAccountId = Integer.parseInt(sourceAccountIdStr);
            int destinationAccountId = Integer.parseInt(destinationAccountIdStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            double amount = Double.parseDouble(amountStr);

            Account sourceAccount = accountDAO.getAccountById(sourceAccountId);
            Account destinationAccount = accountDAO.getAccountById(destinationAccountId);
            TransferCategory transferCategory = transferCategoryDAO.getTransferCategoryById(categoryId);

            if (sourceAccount != null && destinationAccount != null && transferCategory != null) {
                Transfer transfer = new Transfer(null, amount, new Date(), concept, sourceAccount, destinationAccount, transferCategory);
                transferDAO.registerTransfer(transfer);

                resp.sendRedirect(req.getContextPath() + "/AccountingController?ruta=showDashboard");
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cuenta o categoría no válida.");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Formato de número inválido.");
        }
    }



    private void createAccount(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String accountName = req.getParameter("accountName");
        if (accountName != null && !accountName.trim().isEmpty()) {
            Account newAccount = new Account(null, accountName);
            accountDAO.addAccount(newAccount);
        }
        resp.sendRedirect(req.getContextPath() + "/AccountingController?ruta=showAccount");
    }

    private enum TransactionType {
        INCOME, EXPENSE
    }



    private void ruteador(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String ruta = (req.getParameter("ruta") == null) ? "showDashboard" : req.getParameter("ruta");

        switch (ruta) {
            case "showDashboard":
                this.showDashboard(req, resp);
                break;
            case "showCategories":
                this.showCategories(req, resp);
                break;
            case "showTransactions":
                this.showTransactions(req, resp);
                break;
            case "showAccount":
                this.showAccount(req, resp);
                break;
            case "showAccountTransactions":
                this.showAccountTransactions(req, resp);
                break;
            case "showCreateAccount":
                this.showCreateAccount(req, resp);
                break;
            case "showCategoriesTransactions":
                this.showCategoriesTransactions(req, resp);
                break;
            case "showIncome":
                this.showIncome(req, resp);
                break;
            case "showExpense":
                this.showExpense(req, resp);
                break;
            case "showTransfer":
                this.showTransfer(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Ruta no encontrada");
                break;
        }
    }

    private void showCreateAccount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("jsp/showCreateAccount/showCreateAccount.jsp").forward(req, resp);
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        handleDates(req);

        HttpSession session = req.getSession();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Date startDate = (Date) session.getAttribute("startDate");
        Date endDate = (Date) session.getAttribute("endDate");

        List<Account> accounts = accountDAO.getAllAccounts();
        int numberOfAccounts = accounts.size();

        double totalBalance = 0.0;
        for (Account account : accounts) {
            totalBalance += accountDAO.calculateAccountTotal(account);
        }

        // Obtener las últimas 5 transacciones
        List<TransactionDTO> latestTransactions = transactionDAO.getTransactionsForDashboard(startDate, endDate);
        if (latestTransactions.size() > 5) {
            latestTransactions = latestTransactions.subList(0, 5); // Limitar a 5 transacciones
        }

        // Obtener las categorías con balance filtradas por fecha
        List<CategoryDTO> categoriesWithBalance = new CategoryDAO().calculateBalanceByDate(startDate, endDate);

        req.setAttribute("categories", categoriesWithBalance);
        req.setAttribute("accountDAO",accountDAO);

        // Obtener los nombres de las cuentas
        List<String> accountNames = accounts.stream()
                .map(Account::getName)
                .collect(Collectors.toList());

        req.setAttribute("numberOfAccounts", numberOfAccounts);
        req.setAttribute("totalBalance", totalBalance);
        req.setAttribute("latestTransactions", latestTransactions);
        req.setAttribute("accountNames", accountNames);

        // Pasar las cuentas al JSP
        req.setAttribute("accounts", accounts);

        // Las fechas ya fueron manejadas y están disponibles en la sesión y en los atributos de la solicitud
        req.setAttribute("startDate", sdf.format(startDate));
        req.setAttribute("endDate", sdf.format(endDate));

        // Redirigir a la página de dashboard
        req.getRequestDispatcher("jsp/showDashboard/showDashboard.jsp").forward(req, resp);
    }


    private void showTransactions(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        handleDates(req);

        HttpSession session = req.getSession();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Date startDate = (Date) session.getAttribute("startDate");
        Date endDate = (Date) session.getAttribute("endDate");

        String accountIdStr = req.getParameter("accountId");
        List<TransactionDTO> transactions;
        System.out.println("Account ID: " + accountIdStr);

        if (accountIdStr != null && !accountIdStr.equals("all")) {
            try {
                int accountId = Integer.parseInt(accountIdStr);
                Account account = accountDAO.getAccountById(accountId);
                transactions = transactionDAO.getTransactionsForAccountContext(startDate, endDate, account);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid account ID.");
                return;
            }
        } else {
            transactions = transactionDAO.getTransactionsForDashboard(startDate, endDate);
        }

        List<Account> accounts = accountDAO.getAllAccounts();
        req.setAttribute("accounts", accounts);
        req.setAttribute("transactions", transactions);
        req.setAttribute("startDate", sdf.format(startDate));
        req.setAttribute("endDate", sdf.format(endDate));
        req.getRequestDispatcher("jsp/showTransactions/showTransactions.jsp").forward(req, resp);
    }

    private void showAccount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Account> accounts = accountDAO.getAllAccounts();
        req.setAttribute("accountDAO",accountDAO);
        req.setAttribute("accounts", accounts);
        req.getRequestDispatcher("jsp/showAccounts/showAccounts.jsp").forward(req, resp);
    }

    private void showAccountTransactions(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        handleDates(req);
        HttpSession session = req.getSession();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Date startDate = (Date) session.getAttribute("startDate");
        Date endDate = (Date) session.getAttribute("endDate");

        // Obtener el contexto de cuenta si existe
        Account account = null;
        String accountIdStr = req.getParameter("accountId");
        if (accountIdStr != null && !accountIdStr.isEmpty()) {
            try {
                int accountId = Integer.parseInt(accountIdStr);
                account = accountDAO.getAllAccounts().stream()
                        .filter(acc -> acc.getId().equals(accountId))
                        .findFirst()
                        .orElse(null);

                // Verifica si la cuenta es nula y maneja el caso
                if (account == null) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "La cuenta especificada no existe.");
                    return;
                }

            } catch (NumberFormatException e) {
                e.printStackTrace();
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de cuenta no válido");
                return;
            }
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "No se ha proporcionado un ID de cuenta");
            return;
        }
        List<TransactionDTO> transactions = transactionDAO.getTransactionsForAccountContext(startDate, endDate, account);
        req.setAttribute("account", account);
        req.setAttribute("transactions", transactions);
        req.getRequestDispatcher("jsp/showAccountTransactions/showAccountTransactions.jsp").forward(req, resp);
    }


    private void showCategoriesTransactions(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        handleDates(req);
        HttpSession session = req.getSession();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Date startDate = (Date) session.getAttribute("startDate");
        Date endDate = (Date) session.getAttribute("endDate");


        String categoryName = req.getParameter("category");
        List<Category> categories = categoryDAO.getAllCategories();
        Category categoriaEncontrada = null;

        for (Category category : categories) {
            if (category.getName().equalsIgnoreCase(categoryName)) {
                System.out.println(category.getName());
                categoriaEncontrada = category;
                break;
            }
        }
        // Obtener transacciones filtradas por la categoría seleccionada
        TransactionDAO transactionDAO = new TransactionDAO();
        List<TransactionDTO> transactions = transactionDAO.getTransactionsForCategoryContext(startDate, endDate, categoriaEncontrada);
        System.out.println(transactions.size());
        // Establecer las transacciones como atributo de la solicitud
        req.setAttribute("transactions", transactions);
        req.setAttribute("category", categoriaEncontrada);
        // Redirigir a la JSP
        req.getRequestDispatcher("jsp/showCategoriesTransactions/showCategoriesTransactions.jsp").forward(req, resp);
    }



    private void showIncome(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accountIdStr = req.getParameter("accountId");

        Account account = null;
        if (accountIdStr != null && !accountIdStr.isEmpty()) {
            try {
                int accountId = Integer.parseInt(accountIdStr);
                account = accountDAO.getAccountById(accountId);
            } catch (NumberFormatException e) {
                System.out.println("showIncome - Error parsing accountId: " + e.getMessage());
            }
        }
        System.out.println("ShowINCOME"+account.getTotal());
        List<IncomeCategory> incomeCategories = incomeCategoryDAO.getAllIncomeCategories();
        req.setAttribute("incomeCategories", incomeCategories);
        req.setAttribute("account", account);
        req.getRequestDispatcher("jsp/showIncome/showIncome.jsp").forward(req, resp);
    }



    private void showTransfer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accountIdStr = req.getParameter("accountId");
        Account sourceAccount = null;
        List<Account> destinationAccounts = new ArrayList<>();

        if (accountIdStr != null && !accountIdStr.isEmpty()) {
            try {
                int accountId = Integer.parseInt(accountIdStr);
                sourceAccount = accountDAO.getAccountById(accountId);

                // Obtener todas las cuentas excepto la de origen
                List<Account> allAccounts = accountDAO.getAllAccounts();
                for (Account acc : allAccounts) {
                    if (acc.getId() != accountId) {
                        destinationAccounts.add(acc);
                    }
                }
            } catch (NumberFormatException e) {
                System.out.println("showTransfer - Error parsing accountId: " + e.getMessage());
            }
        }

        TransferCategory transferCategory = transferCategoryDAO.getTransferCategory();

        req.setAttribute("transferCategory", transferCategory);
        req.setAttribute("sourceAccount", sourceAccount);
        req.setAttribute("destinationAccounts", destinationAccounts);


        req.getRequestDispatcher("jsp/showTransfer/showTransfer.jsp").forward(req, resp);
    }

    private void showCategories(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        handleDates(req);

        HttpSession session = req.getSession();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Date startDate = (Date) session.getAttribute("startDate");
        Date endDate = (Date) session.getAttribute("endDate");

        List<CategoryDTO> categoriesWithBalance = categoryDAO.calculateBalanceByDate(startDate, endDate);

        // Obtener las listas de Income, Expense y Transfer para comparar nombres
        List<IncomeCategory> incomeCategories = incomeCategoryDAO.getAllIncomeCategories();
        List<ExpenseCategory> expenseCategories = expenseCategoryDAO.getAllExpenseCategories();
        TransferCategory transferCategory = transferCategoryDAO.getTransferCategory();

        req.setAttribute("categories", categoriesWithBalance);
        req.setAttribute("incomeCategories", incomeCategories);
        req.setAttribute("expenseCategories", expenseCategories);
        req.setAttribute("transferCategory", transferCategory);

        req.getRequestDispatcher("jsp/showCategories/showCategories.jsp").forward(req, resp);
    }


    private void handleDates(HttpServletRequest req) {
        HttpSession session = req.getSession();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String fromDateStr = req.getParameter("fromDate");
        String toDateStr = req.getParameter("toDate");

        Date startDate = (Date) session.getAttribute("startDate");
        Date endDate = (Date) session.getAttribute("endDate");

        try {
            Calendar calendar = Calendar.getInstance();

            // Setear la fecha de inicio
            if (fromDateStr != null && !fromDateStr.isEmpty()) {
                startDate = sdf.parse(fromDateStr);
                calendar.setTime(startDate);
                calendar.set(Calendar.HOUR_OF_DAY, 0);
                calendar.set(Calendar.MINUTE, 0);
                calendar.set(Calendar.SECOND, 1);
                startDate = calendar.getTime();
                session.setAttribute("startDate", startDate);
            }

            // Setear la fecha final
            if (toDateStr != null && !toDateStr.isEmpty()) {
                endDate = sdf.parse(toDateStr);
                calendar.setTime(endDate);
                calendar.set(Calendar.HOUR_OF_DAY, 23);
                calendar.set(Calendar.MINUTE, 59);
                calendar.set(Calendar.SECOND, 59);
                endDate = calendar.getTime();
                session.setAttribute("endDate", endDate);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Si no se proporciona ninguna fecha, usar por defecto
        if (startDate == null || endDate == null) {
            Calendar calendar = Calendar.getInstance();

            // Configurar la fecha de inicio al primer día del mes actual a las 00:00:01
            calendar.set(Calendar.DAY_OF_MONTH, 1);
            calendar.set(Calendar.HOUR_OF_DAY, 0);
            calendar.set(Calendar.MINUTE, 0);
            calendar.set(Calendar.SECOND, 1);
            startDate = calendar.getTime();


            calendar.setTime(new Date());
            calendar.set(Calendar.HOUR_OF_DAY, 23);
            calendar.set(Calendar.MINUTE, 59);
            calendar.set(Calendar.SECOND, 59);
            endDate = calendar.getTime();

            session.setAttribute("startDate", startDate);
            session.setAttribute("endDate", endDate);
        }
        req.setAttribute("startDate", sdf.format(startDate));
        req.setAttribute("endDate", sdf.format(endDate));
    }


}


