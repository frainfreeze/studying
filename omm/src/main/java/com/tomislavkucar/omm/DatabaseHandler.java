/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tomislavkucar.omm;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.supercsv.cellprocessor.ift.CellProcessor;
import org.supercsv.io.CsvBeanReader;
import org.supercsv.io.CsvListWriter;
import org.supercsv.io.ICsvBeanReader;
import org.supercsv.io.ICsvListWriter;
import org.supercsv.prefs.CsvPreference;

/**
 *
 * @author frain
 */
public class DatabaseHandler {

    static void writeWithCsvListWriter(List<Object> data, CellProcessor[] processor, String db) throws Exception {
        try (final ICsvListWriter listWriter = new CsvListWriter(new FileWriter(db, true), CsvPreference.STANDARD_PREFERENCE)) {
            /*final String[] header = new String[]{"txtName", "txtMiddleName", "txtSurname",
            "sex", "txtDob", "txtStmt", "txtNum1", "txtNum2", "txtKinName", "txtKinRel", "OPID"};
            listWriter.writeHeader(header);*/
            listWriter.write(data, processor);
        }
    }

    static List readWithCsvBeanReader(Object bean, CellProcessor[] processor, String db) throws Exception {

        List<Object> lst = new ArrayList<>();
        try (ICsvBeanReader beanReader = new CsvBeanReader(new FileReader(db), CsvPreference.STANDARD_PREFERENCE)) {
            // the header elements are used to map the values to the bean (names must match)
            final String[] header = beanReader.getHeader(true);
            
            while ((bean = beanReader.read(bean.getClass(), header, processor)) != null) {
                System.out.println(bean.toString());
                lst.add(bean);
            }
        return lst;
        }
    }
}
