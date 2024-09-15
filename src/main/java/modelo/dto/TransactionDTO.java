package modelo.dto;

import java.util.Date;

public class TransactionDTO {
    private Date date;
    private String concept;
    private double value;
    private String categoryName;
    private String transactionType; // Para especificar si es "Income", "Expense", o "Transfer"
    private String originAccount;
    private String destinationAccount;


    // Constructor con parámetros
    public TransactionDTO(Date date, String concept, double value, String categoryName, String transactionType, String originAccount, String destinationAccount) {
        this.date = date;
        this.concept = concept;
        this.value = value;
        this.categoryName = categoryName;
        this.transactionType = transactionType;
        this.originAccount = originAccount;
        this.destinationAccount = destinationAccount;
    }

    // Getters y Setters
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

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public String getOriginAccount() {
        return originAccount;
    }

    public void setOriginAccount(String originAccount) {
        this.originAccount = originAccount;
    }

    public String getDestinationAccount() {
        return destinationAccount;
    }

    public void getDestinationAccount(String destinationAccount) {
        this.destinationAccount = destinationAccount;
    }
    @Override
    public String toString() {
        return "TransactionDTO{" +
                "date=" + date +
                ", concept='" + concept + '\'' +
                ", value=" + value +
                ", categoryName='" + categoryName + '\'' +
                ", transactionType='" + transactionType + '\'' +
                ", originAccount='" + originAccount + '\'' +
                ", destinationAccount='" + destinationAccount + '\'' +
                '}';
    }
}
