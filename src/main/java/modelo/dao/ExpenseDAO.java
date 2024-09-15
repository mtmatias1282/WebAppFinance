package modelo.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import modelo.entidad.Account;
import modelo.entidad.Expense;

public class ExpenseDAO {

    private EntityManager em;

    public ExpenseDAO() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("WebAppFinance");
        this.em = emf.createEntityManager();
    }

    // Método para registrar un nuevo gasto
    public void registerExpense(Expense expense) {
        if (expense.getValue() <= 0) {
            throw new IllegalArgumentException("El valor de la transacción debe ser mayor a 0.");
        }

        em.getTransaction().begin();
        // Persiste el gasto
        em.persist(expense);

        // Actualizar el saldo de la cuenta relacionada
        AccountDAO accountDAO = new AccountDAO();
        Account account = accountDAO.getAccountById(expense.getAccount().getId());
        account.setTotal(account.getTotal() - expense.getValue());

        em.merge(account);
        em.getTransaction().commit();
    }
}
