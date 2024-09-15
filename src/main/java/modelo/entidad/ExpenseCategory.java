package modelo.entidad;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@DiscriminatorValue("ExpenseCategory") // Si deseas que se almacene en una tabla separada
public class ExpenseCategory extends Category implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column
    private String name;

    public ExpenseCategory() {
    }

    public ExpenseCategory(Integer id, String name) {
        super(id, name);
    }
}