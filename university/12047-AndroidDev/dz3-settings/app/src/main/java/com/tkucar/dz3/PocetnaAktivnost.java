package com.tkucar.dz3;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import android.preference.PreferenceManager;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;
import android.widget.Toast;

public class PocetnaAktivnost extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        final TextView mainTextView = findViewById(R.id.text_view_id);
        mainTextView.setText(R.string.no_data_string);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        final TextView mainTextView = findViewById(R.id.text_view_id);

        switch (item.getItemId()) {
            case R.id.action_settings:
                startActivity(new Intent(this, PostavkeAktivnost.class));
                return true;

            case R.id.action_delete:
                PreferenceManager.getDefaultSharedPreferences(this).edit().clear().apply();
                toasty("Postavke obrisane.");
                refreshData(mainTextView);
                return true;

            case R.id.action_refresh:
                refreshData(mainTextView);
                toasty("Podatci osvjezeni.");
                return true;

            default:
                return super.onOptionsItemSelected(item);
        }
    }

    private void toasty(String msg) {
        Toast.makeText(getApplicationContext(), msg, Toast.LENGTH_SHORT).show();
    }

    private void refreshData(TextView mainTextView) {
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);

        String name = prefs.getString("name", "nepoznato");
        String location = prefs.getString("location", "nepoznata");
        String gender = prefs.getBoolean("gender", false) ? "Muskog" : "Zenskog";

        //mainTextView.setText(String.format("Vase ime je %s. %s ste spola i Vasa lokacija je %s.", name, gender, location));
        StringBuilder sb = new StringBuilder();
        sb.append("Vase ime je ");
        sb.append(name);
        sb.append(". ");
        sb.append(gender);
        sb.append(" ste spola i Vasa lokacija je ");
        sb.append(location);

        mainTextView.setText(sb.toString());
    }
}
