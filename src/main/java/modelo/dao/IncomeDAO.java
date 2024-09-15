package modelo.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import modelo.entidad.*;

public class IncomeDAO {

    private EntityManager em;

    public IncomeDAO() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("WebAppFinance");
        this.em = emf.createEntityManager();
    }

    public void registerIncome(Income income) {
        if (income.getValue() <= 0) {
            throw new IllegalArgumentException("El valor de la transacción debe ser mayor a 0.");
        }
        em.getTransaction().begin();

        IncomeCategory category = em.find(IncomeCategory.class, income.getCategory().getId());
        if (category == null) {
            throw new IllegalArgumentException("La categoría especificada no existe.");
        }
        income.setCategory(category);

        // Persiste el ingreso
        em.persist(income);

        AccountDAO accountDAO = new AccountDAO();
        Account account = accountDAO.getAccountById(income.getAccount().getId());
        account.setTotal(account.getTotal() + income.getValue());

        System.out.println(" Total income dao "+account);
        em.merge(account);

        em.getTransaction().commit();
    }
}