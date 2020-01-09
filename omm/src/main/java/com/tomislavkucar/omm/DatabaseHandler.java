package com.tomislavkucar.omm;

import java.io.FileReader;
import java.io.FileWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import org.supercsv.cellprocessor.ift.CellProcessor;
import org.supercsv.io.CsvBeanReader;
import org.supercsv.io.CsvBeanWriter;
import org.supercsv.io.CsvListWriter;
import org.supercsv.io.ICsvBeanReader;
import org.supercsv.io.ICsvBeanWriter;
import org.supercsv.io.ICsvListWriter;
import org.supercsv.prefs.CsvPreference;

public class DatabaseHandler {

    static void writeWithCsvListWriter(List<Object> data, CellProcessor[] processor, String db) throws Exception {
        try (final ICsvListWriter listWriter = new CsvListWriter(new FileWriter(db, true), CsvPreference.STANDARD_PREFERENCE)) {
            listWriter.write(data, processor);
        }
    }

    static void writeWithCsvBeanWriter(CellProcessor[] processor, Object data, String[] header, String db) throws Exception {
        try (ICsvBeanWriter beanWriter = new CsvBeanWriter(new FileWriter(db, true), CsvPreference.STANDARD_PREFERENCE)) {
            if (Files.size(Paths.get(db)) == 0) {
                beanWriter.writeHeader(header);
            }
            beanWriter.write(data, header, processor);
        }
    }

    static List readWithCsvBeanReader(Object bean, CellProcessor[] processor, String db) throws Exception {
        List<Object> lst = new ArrayList<>();
        try (ICsvBeanReader beanReader = new CsvBeanReader(new FileReader(db), CsvPreference.STANDARD_PREFERENCE)) {
            final String[] header = beanReader.getHeader(true);
            while ((bean = beanReader.read(bean.getClass(), header, processor)) != null) {
                lst.add(bean);
            }
            return lst;
        }
    }
}
