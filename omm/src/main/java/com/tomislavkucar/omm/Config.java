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
public class Config {
    public static String STAFF = "target/staff.csv";
    public static String PATIENTS = "target/patients.csv";
    public static String[] patientHeader = new String[]{"firstName","middleName","lastName","DOB","sex","statement","num1","num2","kinName","kinRel","OPID"};
}
