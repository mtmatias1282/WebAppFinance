package modelo.dao;

import jakarta.persistence.*;
import modelo.entidad.ExpenseCategory;


import java.util.List;

public class ExpenseCategoryDAO  {

    @PersistenceContext
    private EntityManager em;

    public ExpenseCategoryDAO(){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("WebAppFinance");
        this.em = emf.createEntityManager();
    }
    //Para cuando agrego un egreso, se muestre la lista de categorías de egreso que puedo elegir.
    public List<ExpenseCategory> getAllExpenseCategories() {
        // JPQL query to select categories where category_type is "ExpenseCategory"
        TypedQuery<ExpenseCategory> query = em.createQuery(
                "SELECT c FROM ExpenseCategory c",
                ExpenseCategory.class
        );
        return query.getResultList();
    }


    public ExpenseCategory getExpenseCategoryById(int categoryId) {
        return em.find(ExpenseCategory.class, categoryId);
    }
}
