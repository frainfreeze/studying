/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tomislavkucar.omm;

import org.supercsv.cellprocessor.constraint.NotNull;
import org.supercsv.cellprocessor.constraint.UniqueHashCode;
import org.supercsv.cellprocessor.ift.CellProcessor;

/**
 *
 * @author frain
 */
public class Processors {

    static CellProcessor[] patientsMiniFormProcessor() {
        final CellProcessor[] processors = new CellProcessor[]{new NotNull(), // txtName
        new NotNull(), // txtMiddleName
        new NotNull(), // txtSurname
        new NotNull(), // sex
        new NotNull(), //FmtDate("dd/MM/yyyy"), // txtDob
        new NotNull(), // txtStmt
        new NotNull(), // txtNum1
        new NotNull(), // txtNum2
        new NotNull(), // txtKinName
        new NotNull(), // txtKinRel
        new UniqueHashCode() // Outpatient ID (OPID): (must be unique)
        //todo - extend with full form
        };
        return processors;
    }

    static CellProcessor[] personelProcessor() {
        final CellProcessor[] processors = new CellProcessor[]{new NotNull(), // txtName
        new NotNull(), // txtSurname
        new NotNull(), // worktype
        new NotNull(), // available
        new NotNull(), // email
        new NotNull(), // phone
        new NotNull() // uuid
        };
        return processors;
    }
    
}
