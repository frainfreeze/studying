package com.tomislavkucar.omm;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.UUID;
import javax.swing.BorderFactory;
import javax.swing.JFrame;
import javax.swing.JLabel;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.PDPageContentStream.AppendMode;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.ChartUtils;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.block.BlockBorder;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.XYLineAndShapeRenderer;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.xy.XYDataset;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;

/**
 *
 * @author frain
 */
public class Report {

    private JFreeChart createBarChart(CategoryDataset dataset) {
        JFreeChart barChart = ChartFactory.createBarChart(
                "Average patients treated by doctor",
                "",
                "Patients",
                dataset,
                PlotOrientation.VERTICAL,
                false, true, false);

        return barChart;
    }

    private JFreeChart createLineChart(final XYDataset dataset) {
        JFreeChart chart = ChartFactory.createXYLineChart(
                "Patients trend for week 34",
                "Day of the week",
                "Number of patients",
                dataset,
                PlotOrientation.VERTICAL,
                true,
                true,
                false
        );

        XYPlot plot = chart.getXYPlot();

        var renderer = new XYLineAndShapeRenderer();

        renderer.setSeriesPaint(0, Color.RED);
        renderer.setSeriesStroke(0, new BasicStroke(2.0f));
        renderer.setSeriesPaint(1, Color.BLUE);
        renderer.setSeriesStroke(1, new BasicStroke(2.0f));

        plot.setRenderer(renderer);
        plot.setBackgroundPaint(Color.white);
        plot.setRangeGridlinesVisible(false);
        plot.setDomainGridlinesVisible(false);

        chart.getLegend().setFrame(BlockBorder.NONE);

        chart.setTitle(new TextTitle("Patients trend for week 34",
                new Font("Serif", Font.BOLD, 18)
        )
        );

        return chart;
    }

    public void GenerateReport() throws IOException {
        var dataset = new DefaultCategoryDataset();
        dataset.setValue(46, "Patients", "Gregory House");
        dataset.setValue(38, "Patients", " Lisa Cuddy");
        dataset.setValue(29, "Patients", "James Wilson");
        dataset.setValue(22, "Patients", "Eric Foreman");
        dataset.setValue(11, "Patients", "Robert Chase");
        JFreeChart chart = createBarChart(dataset);
        File barChart = File.createTempFile("Virgo-", ".png");
        ChartUtils.saveChartAsPNG(barChart, chart, 800, 600);
        
        var series1 = new XYSeries("New patients");
        series1.add(18, 530);
        series1.add(20, 580);
        series1.add(25, 740);
        series1.add(30, 901);
        series1.add(40, 1300);
        series1.add(50, 2219);

        var series2 = new XYSeries("Follow up patients");
        series2.add(18, 567);
        series2.add(20, 612);
        series2.add(25, 800);
        series2.add(30, 980);
        series2.add(40, 1210);
        series2.add(50, 2350);

        var dataset1 = new XYSeriesCollection();
        dataset1.addSeries(series1);
        dataset1.addSeries(series2);
        JFreeChart chart1 = createLineChart(dataset1);
        
        File lineChart = File.createTempFile("Virgo-", ".png");
        ChartUtils.saveChartAsPNG(lineChart, chart1, 800, 600);

        
        // Create a document and add a page to it
        PDDocument document = new PDDocument();
        PDPage page = new PDPage();
        document.addPage(page);

        // Create a new font object selecting one of the PDF base fonts
        PDFont font = PDType1Font.HELVETICA_BOLD;

        // Start a new content stream which will "hold" the to be created content
        PDPageContentStream contentStream = new PDPageContentStream(document, page, AppendMode.APPEND, true);
        // Define a text content stream using the selected font, moving the cursor and drawing the text
        contentStream.beginText();
        contentStream.setFont(font, 12);
        contentStream.moveTextPositionByAmount(100, 700);
        contentStream.drawString("Virgo Hospital - weekly report");
        contentStream.endText();
        
        //add img
        PDImageXObject pdImage = PDImageXObject.createFromFileByExtension(barChart,document);
        contentStream.drawImage(pdImage,70,340,452,339);
        
        pdImage = PDImageXObject.createFromFileByExtension(lineChart,document);
        contentStream.drawImage(pdImage,70,1,452,339);

        // Make sure that the content stream is closed:
        contentStream.close();

        // Save the results and ensure that the document is properly closed:
        document.save(Config.reportName);
        document.close();

        //remove imgs
        barChart.delete();
        lineChart.delete();
    }
}
