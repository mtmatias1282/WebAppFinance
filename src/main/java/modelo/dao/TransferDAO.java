package modelo.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import modelo.entidad.Account;
import modelo.entidad.Transfer;

public class TransferDAO {

    private EntityManager em;

    public TransferDAO() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("WebAppFinance");
        this.em = emf.createEntityManager();
    }

    public void registerTransfer(Transfer transfer) {

        if (transfer.getValue() <= 0) {
            throw new IllegalArgumentException("El valor de la transacción debe ser mayor a 0.");
        }

        em.getTransaction().begin();


        // Actualizar saldos en cuentas de origen y destino
        AccountDAO accountDAO = new AccountDAO();
        Account originAccount = accountDAO.getAccountById(transfer.getOriginAccount().getId());
        Account destinationAccount = accountDAO.getAccountById(transfer.getDestinationAccount().getId());

        if (originAccount.getTotal() < transfer.getValue()) {
            em.getTransaction().rollback();
            throw new IllegalArgumentException("Saldo insuficiente en la cuenta de origen para realizar la transferencia.");
        }

        originAccount.setTotal(originAccount.getTotal() - transfer.getValue());
        destinationAccount.setTotal(destinationAccount.getTotal() + transfer.getValue());

        em.merge(originAccount);
        em.merge(destinationAccount);

        // Persiste la transferencia
        em.persist(transfer);

        em.getTransaction().commit();

    }
}
