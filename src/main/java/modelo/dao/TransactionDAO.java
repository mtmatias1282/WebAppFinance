package modelo.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import modelo.entidad.*;
import modelo.dto.*;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

public class TransactionDAO {

    private EntityManager em;

    public TransactionDAO() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("WebAppFinance");
        this.em = emf.createEntityManager();
    }
    public Transaction getTransactionById(int id) {
        return em.find(Transaction.class, id);
    }
    // Método para actualizar una transacción
    public void updateTransaction(Transaction updatedTransaction) {
        em.getTransaction().begin();
        Transaction transaction = em.find(Transaction.class, updatedTransaction.getId());
        if (transaction != null) {
            transaction.setValue(updatedTransaction.getValue());
            transaction.setDate(updatedTransaction.getDate());
            transaction.setConcept(updatedTransaction.getConcept());
            transaction.setCategory(updatedTransaction.getCategory());
        }
        em.getTransaction().commit();
    }

    // Método para eliminar una transacción
    public void deleteTransaction(Transaction deletedTransaction) {
        em.getTransaction().begin();
        Transaction transaction = em.find(Transaction.class, deletedTransaction.getId());
        if (transaction != null) {
            em.remove(transaction);
        }
        em.getTransaction().commit();
    }

    // Método base para obtener transacciones

    public List<TransactionDTO> getTransactionsForAccountContext(Date fromDate, Date toDate, Account account) {
        return getTransactions(fromDate, toDate, account, null);
    }

    public List<TransactionDTO> getTransactionsForCategoryContext(Date fromDate, Date toDate, Category category) {
        return getTransactions(fromDate, toDate, null, category);
    }


    public List<TransactionDTO> getTransactionsForDashboard(Date fromDate, Date toDate) {
        return getTransactions(fromDate, toDate, null, null);
    }

    private List<TransactionDTO> getTransactions(Date fromDate, Date toDate, Account account, Category category) {
        // Consulta para ingresos (Income)
        String incomeJpql = "SELECT new modelo.dto.TransactionDTO(i.date, i.concept, i.value, c.name, 'Income', '', i.destinationAccount.name) " +
                "FROM Income i " +
                "JOIN i.category c " +
                "WHERE i.date BETWEEN :fromDate AND :toDate";
        if (account != null) {
            incomeJpql += " AND i.destinationAccount = :account";
        }
        if (category != null) {
            incomeJpql += " AND i.category = :category";
        }

        var incomeQuery = em.createQuery(incomeJpql, TransactionDTO.class)
                .setParameter("fromDate", fromDate)
                .setParameter("toDate", toDate);
        if (account != null) {
            incomeQuery.setParameter("account", account);
        }
        if (category != null) {
            incomeQuery.setParameter("category", category);
        }
        List<TransactionDTO> incomeTransactions = incomeQuery.getResultList();

        // Consulta para egresos (Expense)
        String expenseJpql = "SELECT new modelo.dto.TransactionDTO(e.date, e.concept, e.value, c.name, 'Expense', e.originAccount.name, '') " +
                "FROM Expense e " +
                "JOIN e.category c " +
                "WHERE e.date BETWEEN :fromDate AND :toDate";
        if (account != null) {
            expenseJpql += " AND e.originAccount = :account";
        }
        if (category != null) {
            expenseJpql += " AND e.category = :category";
        }

        var expenseQuery = em.createQuery(expenseJpql, TransactionDTO.class)
                .setParameter("fromDate", fromDate)
                .setParameter("toDate", toDate);
        if (account != null) {
            expenseQuery.setParameter("account", account);
        }
        if (category != null) {
            expenseQuery.setParameter("category", category);
        }
        List<TransactionDTO> expenseTransactions = expenseQuery.getResultList();


        // Consulta para transferencias (Transfer)
        String transferJpql = "SELECT new modelo.dto.TransactionDTO(t.date, t.concept, t.value, c.name, 'Transfer', t.originAccount.name, t.destinationAccount.name) " +
                "FROM Transfer t " +
                "JOIN t.category c " +
                "WHERE t.date BETWEEN :fromDate AND :toDate";
        if (account != null) {
            transferJpql += " AND (t.originAccount = :account OR t.destinationAccount = :account)";
        }
        if (category != null) {
            transferJpql += " AND t.category = :category";
        }

        var transferQuery = em.createQuery(transferJpql, TransactionDTO.class)
                .setParameter("fromDate", fromDate)
                .setParameter("toDate", toDate);
        if (account != null) {
            transferQuery.setParameter("account", account);
        }
        if (category != null) {
            transferQuery.setParameter("category", category);
        }
        List<TransactionDTO> transferTransactions = transferQuery.getResultList();

        // Combina todas las listas de transacciones en una sola lista
        List<TransactionDTO> allTransactions = new ArrayList<>();
        allTransactions.addAll(incomeTransactions);
        allTransactions.addAll(expenseTransactions);
        allTransactions.addAll(transferTransactions);

        allTransactions.sort(Comparator.comparing(TransactionDTO::getDate).reversed());

        return allTransactions;
    }


}
