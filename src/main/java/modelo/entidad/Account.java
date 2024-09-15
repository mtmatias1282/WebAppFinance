package modelo.entidad;

import jakarta.persistence.*;
import modelo.dao.AccountDAO;
import org.eclipse.tags.shaded.org.apache.xalan.xsltc.dom.AnyNodeCounter;

import java.io.Serializable;
import java.util.Objects;

@Entity
@Table(name = "account") // Opcional: especifica el nombre de la tabla en la base de datos
public class Account implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Configura la generación automática de ID
    @Column
    private Integer id;

    @Column
    private String name;

    @Column
    private double total;

    // Constructor sin parámetros, necesario para JPA
    public Account( ) {

    }
    // Constructor con parámetros
    public Account(Integer id, String name) {
        this.id = id;
        this.name = name;
    }

    // Getters y setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    // Sobrescribir equals y hashCode usando Objects para asegurar comparación correcta
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Account account = (Account) o;
        return Double.compare(account.total, total) == 0 && Objects.equals(id, account.id) && Objects.equals(name, account.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, total);
    }

    // Sobrescribir toString para facilitar la depuración
    @Override
    public String toString() {
        return "Account{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", total=" + total +
                '}';
    }
}
