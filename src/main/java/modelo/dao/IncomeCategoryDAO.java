package modelo.dao;

import jakarta.persistence.*;
import modelo.entidad.IncomeCategory;

import java.util.List;

public class IncomeCategoryDAO {

    @PersistenceContext
    private EntityManager em;

    public IncomeCategoryDAO(){
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("WebAppFinance");
        this.em = emf.createEntityManager();
    }


    //Para cuando agrego un ingreso, se muestre la lista de categorías de ingreso que puedo elegir.
    public List<IncomeCategory> getAllIncomeCategories() {
        TypedQuery<IncomeCategory> query = em.createQuery(
                "SELECT c FROM IncomeCategory c",
                IncomeCategory.class
        );
        return query.getResultList();
    }

    public IncomeCategory getIncomeCategoryById(int id) {
        return em.find(IncomeCategory.class, id);
    }

}
