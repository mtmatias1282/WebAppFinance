package modelo.dao;


import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.transaction.Transactional;
import modelo.entidad.Account;
import modelo.entidad.Category;
import modelo.dto.CategoryDTO;


import java.util.Date;
import java.util.List;

@Transactional
public class CategoryDAO {

    private EntityManager em;

    public CategoryDAO() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("WebAppFinance");
        this.em = emf.createEntityManager();
    }


    //Para ver todas las categorías y su balance
    public List<CategoryDTO> calculateBalanceByDate(Date from, Date to) {
        // JPQL query to calculate the sum of values grouped by category
        String jpql = "SELECT new modelo.dto.CategoryDTO(c.name, SUM(t.value)) " +
                "FROM Transaction t " +
                "JOIN t.category c " +
                "WHERE t.date BETWEEN :from AND :to " +
                "GROUP BY c.name";

        // Execute the query and retrieve the result list
        List<CategoryDTO> categoriesWithBalance = em.createQuery(jpql, CategoryDTO.class)
                .setParameter("from", from)
                .setParameter("to", to)
                .getResultList();

        return categoriesWithBalance;
    }

    public void addCategory(Category category) {
        em.getTransaction().begin();
        em.persist(category);
        em.getTransaction().commit();
    }

    public List<Category> getAllCategories() {
        return em.createQuery("SELECT a FROM Category a", Category.class).getResultList();
    }
}
