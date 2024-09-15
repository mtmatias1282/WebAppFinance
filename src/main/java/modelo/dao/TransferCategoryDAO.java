package modelo.dao;

import jakarta.persistence.*;
import modelo.entidad.ExpenseCategory;
import modelo.entidad.IncomeCategory;
import modelo.entidad.TransferCategory;

import java.util.List;

public class TransferCategoryDAO {

    @PersistenceContext
    private EntityManager em;

    public TransferCategoryDAO() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("WebAppFinance");
        this.em = emf.createEntityManager();
    }

    // Para obtener la única instancia de TransferCategory
    public TransferCategory getTransferCategory() {
        TypedQuery<TransferCategory> query = em.createQuery(
                "SELECT c FROM TransferCategory c",
                TransferCategory.class
        );

        return query.getSingleResult();
    }

    public TransferCategory getTransferCategoryById(int categoryId) {
        return em.find(TransferCategory.class, categoryId);
    }
}
