package modelo.entidad;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Date;

@Entity
@DiscriminatorValue("Expense")
public class Expense extends Transaction implements Serializable {

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
    Account originAccount;

    // Constructor sin parámetros, necesario para JPA
    public Expense() {
    }

    public Expense(Integer id, double value, Date date, String concept, Account originAccount, ExpenseCategory category) {
        super(id, value, date, concept, category);
        this.originAccount = originAccount;
    }

    public Account getAccount() {
        return originAccount;
    }

    public void setAccount(Account account) {
        this.originAccount = account;
    }
    @Override
    public String toString() {
        return "Expense{" +
                "id=" + getId() +
                ", value=" + getValue() +
                ", date=" + getDate() +
                ", concept='" + getConcept() + '\'' +
                ", originAccount='" + originAccount.getName() + '\'' +
                ", category='" + getCategory().getName() + '\'' +
                '}';
    }

}
