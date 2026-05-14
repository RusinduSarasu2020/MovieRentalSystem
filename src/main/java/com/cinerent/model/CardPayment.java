package com.cinerent.model;

import jakarta.persistence.*;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;

@Entity
@DiscriminatorValue("CARD")
public class CardPayment extends Payment {
    private String cardNumber;
    private String cardHolderName;
    private String expiryDate;   // MM/YY
    private String cvv;

    public CardPayment() {}

    public boolean validateCardDetails() {
        if (cardNumber == null || !cardNumber.matches("\\d{16}")) return false;
        if (cvv == null || !cvv.matches("\\d{3}")) return false;
        if (cardHolderName == null || cardHolderName.isBlank()) return false;
        if (expiryDate == null || !expiryDate.matches("(0[1-9]|1[0-2])/\\d{2}")) return false;
        try {
            YearMonth ym = YearMonth.parse("20" + expiryDate.substring(3) + "-" + expiryDate.substring(0,2),
                    DateTimeFormatter.ofPattern("yyyy-MM"));
            if (ym.isBefore(YearMonth.now())) return false;
        } catch (Exception e) { return false; }
        return amount > 0;
    }

    @Override
    public boolean processPayment() {     // POLYMORPHISM
        if (validateCardDetails()) {
            this.status = "SUCCESS";
            return true;
        }
        this.status = "FAILED";
        return false;
    }

    public String getCardNumber() { return cardNumber; } public void setCardNumber(String c) { this.cardNumber = c; }
    public String getCardHolderName() { return cardHolderName; } public void setCardHolderName(String c) { this.cardHolderName = c; }
    public String getExpiryDate() { return expiryDate; } public void setExpiryDate(String e) { this.expiryDate = e; }
    public String getCvv() { return cvv; } public void setCvv(String c) { this.cvv = c; }
}