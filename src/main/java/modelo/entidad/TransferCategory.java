package modelo.entidad;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@DiscriminatorValue("TransferCategory")  // Si deseas que se almacene en una tabla separada
public class TransferCategory extends Category implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column
    private String name;

    // Constructor sin parámetros, necesario para JPA
    public TransferCategory() {
        super();
    }

    public TransferCategory(Integer id, String name) {
        super(id, name);
    }
}
