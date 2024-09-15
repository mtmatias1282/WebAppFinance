package modelo.entidad;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Date;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "TRANSACTION_TYPE", discriminatorType = DiscriminatorType.STRING)
@Table(name = "transaction")
public abstract class Transaction implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Integer id;

    @Column
    private double value;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date date;

    @Column
    private String concept;

    @ManyToOne
    @JoinColumn
    private Category category;
    // Constructor sin parámetros, necesario para JPA
    public Transaction() {
    }

    // Constructor con parámetros
    public Transaction(Integer id, double value, Date date, String concept, Category category) {
        if (value <= 0) {
            throw new IllegalArgumentException("El valor de la transacción debe ser mayor a 0.");
        }
        this.id = id;
        this.value = value;
        this.date = date;
        this.concept = concept;
        this.category = category;
    }

    // Getters y Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getConcept() {
        return concept;
    }

    public void setConcept(String concept) {
        this.concept = concept;
    }

    public Category getCategory() {
        return category;
    }
    public void setCategory(Category category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "Transaction{" +
                "id=" + getId() +
                ", value=" + getValue() +
                ", date=" + getDate() +
                ", concept='" + getConcept() + '\'' +
                ", category='" + getCategory() + '\'' +
                '}';
    }
}
