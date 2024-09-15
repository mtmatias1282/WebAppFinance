package modelo.dto;

public class CategoryDTO {

    private String name;
    private Double total;

    // Constructor con parámetros
    public CategoryDTO(String name, Double total) {
        this.name = name;
        this.total = total;
    }

    // Getters y Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    // Método toString para facilitar la visualización del objeto
    @Override
    public String toString() {
        return "CategoryDTO{" +
                ", name='" + name + '\'' +
                ", total=" + total +
                '}';
    }
}
