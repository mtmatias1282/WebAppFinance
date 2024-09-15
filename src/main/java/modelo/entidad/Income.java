package modelo.entidad;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Date;

@Entity
@DiscriminatorValue("Income")
public class Income extends Transaction implements Serializable {

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
    Account destinationAccount;

    // Constructor sin parámetros, necesario para JPA
    public Income() {
    }

    public Income(Integer id, double value, Date date, String concept, Account destinationAccount, IncomeCategory category) {
        super(id, value, date, concept, category);
        this.destinationAccount = destinationAccount;
    }

    public Account getAccount() {
        return destinationAccount;
    }

    public void setAccount(Account account) {
        this.destinationAccount = account;
    }
    @Override
    public String toString() {
        return "Income{" +
                "id=" + getId() +
                ", value=" + getValue() +
                ", date=" + getDate() +
                ", concept='" + getConcept() + '\'' +
                ", destinationAccount='" + destinationAccount.getName() + '\'' +
                ", category='" + getCategory().getName() + '\'' +
                '}';
    }

}
