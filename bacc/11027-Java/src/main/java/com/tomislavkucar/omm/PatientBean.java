package com.tomislavkucar.omm;

public class PatientBean {

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getMiddleName() {
        return middleName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getDOB() {
        return DOB;
    }

    public void setDOB(String DOB) {
        this.DOB = DOB;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getStatement() {
        return statement;
    }

    public void setStatement(String statement) {
        this.statement = statement;
    }

    public String getNum1() {
        return num1;
    }

    public void setNum1(String num1) {
        this.num1 = num1;
    }

    public String getNum2() {
        return num2;
    }

    public void setNum2(String num2) {
        this.num2 = num2;
    }

    public String getKinName() {
        return kinName;
    }

    public void setKinName(String kinName) {
        this.kinName = kinName;
    }

    public String getKinRel() {
        return kinRel;
    }

    public void setKinRel(String kinRel) {
        this.kinRel = kinRel;
    }

    public String getOpid() {
        return opid;
    }

    public void setOpid(String opid) {
        this.opid = opid;
    }

    private String firstName;
    private String middleName;
    private String lastName;

    private String DOB;
    private String sex;

    private String statement;
    private String num1;
    private String num2;

    private String kinName;
    private String kinRel;

    private String opid;

    public PatientBean() {
    }

    @Override
    public String toString() {
        return "PatientBean{" + "firstName=" + firstName + ", middleName=" + middleName + ", lastName=" + lastName + ", DOB=" + DOB + ", sex=" + sex + ", statement=" + statement + ", num1=" + num1 + ", num2=" + num2 + ", kinName=" + kinName + ", kinRel=" + kinRel + ", opid=" + opid + '}';
    }

    public PatientBean(String firstName, String middleName, String lastName, String DOB, String sex, String statement, String num1, String num2, String kinName, String kinRel, String opid) {
        this.firstName = firstName;
        this.middleName = middleName;
        this.lastName = lastName;
        this.DOB = DOB;
        this.sex = sex;
        this.statement = statement;
        this.num1 = num1;
        this.num2 = num2;
        this.kinName = kinName;
        this.kinRel = kinRel;
        this.opid = opid;
    }

    /**
    * Tests for empty fields
    *
    * @return True if there are empty fields, otherwise false
    */
    public boolean checkEmpty(){
        if ("".equals(firstName)) return true;
        if ("".equals(middleName)) return true;
        if ("".equals(lastName)) return true;
        if ("".equals(DOB)) return true;
        if ("".equals(sex)) return true;
        if ("".equals(statement)) return true;
        if ("".equals(num1)) return true;
        if ("".equals(num2)) return true;
        if ("".equals(kinName)) return true;
        if ("".equals(kinRel)) return true;
        if ("".equals(opid)) return true;
        return false;        
    }
}
