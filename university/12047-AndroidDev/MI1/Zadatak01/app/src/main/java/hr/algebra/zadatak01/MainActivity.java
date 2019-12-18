package hr.algebra.zadatak01;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private LinearLayout llCheckboxes;
    private Button btnWrite;
    private TextView tvReport;

    private int nrCheckboxes;
    private int nrChecked;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        initWidgets();
        setupListeners();
    }

    private void initWidgets() {
        llCheckboxes = findViewById(R.id.llCheckboxes);
        btnWrite = findViewById(R.id.btnWrite);
        tvReport = findViewById(R.id.tvReport);
    }

    private void setupListeners() {
        btnWrite.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                writeReport();
            }
        });
        for (int i = 0; i < llCheckboxes.getChildCount(); i++) {
            if (llCheckboxes.getChildAt(i) instanceof CheckBox) {
                nrCheckboxes++;
                llCheckboxes.getChildAt(i).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        if (((CheckBox)view).isChecked()) {
                            nrChecked++;
                        } else {
                            nrChecked--;
                        }
                    }
                });
            }
        }
    }

    private void writeReport() {
        String report = getString(R.string.none_checked);
        if (nrChecked == nrCheckboxes) {
            report = getString(R.string.all_checked);
        } else if (nrChecked > 0) {
            report = String.format("%s %d", getString(R.string.number_of_checked), nrChecked);
        }
        tvReport.setText(report);
    }
}
