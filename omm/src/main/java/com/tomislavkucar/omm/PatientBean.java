/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tomislavkucar.omm;

/**
 *
 * @author frain
 */
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

    public PatientBean(final String firstName, final String middleName, final String lastName, final String DOB, final String sex, final String statement, final String num1, final String num2, final String kinName, final String kinRel) {
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
    }
}
