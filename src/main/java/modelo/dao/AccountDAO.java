package modelo.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import modelo.entidad.Account;

import java.util.List;

public class AccountDAO {

    private EntityManager em;

    public AccountDAO() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("WebAppFinance");
        this.em = emf.createEntityManager();
    }

    public void addAccount(Account account) {
        em.getTransaction().begin();
        em.persist(account);
        em.getTransaction().commit();
    }

    public List<Account> getAllAccounts() {
        return em.createQuery("SELECT a FROM Account a", Account.class).getResultList();
    }

    //modificamos cuenta
    public double calculateAccountTotal(Account account) {
        String jpql = "SELECT a.total FROM Account a WHERE a = :account";

        Double total = em.createQuery(jpql, Double.class)
                .setParameter("account", account)
                .getSingleResult();

        return total != null ? total : 0.0;
    }

        public Account getAccountById(int id) {
        return getAllAccounts().stream()
                .filter(acc -> acc.getId() == id)
                .findFirst()
                .orElse(null);
    }
}