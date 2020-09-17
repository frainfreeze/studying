package hr.algebra.zadatak03.model;

import androidx.annotation.NonNull;

public class Item {

    private String firstName;
    private String lastName;
    private String subject;
    private int grade;

    public Item(String firstName, String lastName, String subject, int grade) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.subject = subject;
        this.grade = grade;
    }

    public String getSubject() {
        return subject;
    }

    public int getGrade() {
        return grade;
    }

    @NonNull
    @Override
    public String toString() {
        return String.format("%s, %s", lastName, firstName);
    }
}
