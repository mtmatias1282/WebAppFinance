package modelo.entidad;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Date;

@Entity
@DiscriminatorValue("Transfer")
public class Transfer extends Transaction implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @Column
    double value;

    @Column
    Date date;

    @Column
    String concept;

    @ManyToOne
    @JoinColumn
    private Account originAccount;

    @ManyToOne
    @JoinColumn
    private Account destinationAccount;

    // Constructor sin parámetros, necesario para JPA
    public Transfer() {
    }

    public Transfer(Integer id, double value, Date date, String concept, Account originAccount, Account destinationAccount, TransferCategory category) {
        super(id, value, date, concept, category);
        this.originAccount = originAccount;
        this.destinationAccount = destinationAccount;
    }

    public Account getOriginAccount() {
        return originAccount;
    }

    public void setOriginAccount(Account originAccount) {
        this.originAccount = originAccount;
    }

    public Account getDestinationAccount() {
        return destinationAccount;
    }

    public void setDestinationAccount(Account destinationAccount) {
        this.destinationAccount = destinationAccount;
    }
    @Override
    public String toString() {
        return "Transfer{" +
                "id=" + getId() +
                ", value=" + getValue() +
                ", date=" + getDate() +
                ", concept='" + getConcept() + '\'' +
                ", originAccount='" + originAccount.getName() + '\'' +
                ", destinationAccount='" + destinationAccount.getName() + '\'' +
                ", category='" + getCategory().getName() + '\'' +
                '}';
    }
}
