package hr.algebra.zadatak03;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.Arrays;
import java.util.List;

import hr.algebra.zadatak03.model.Item;

public class MainActivity extends AppCompatActivity {

    private ListView lvItems;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        initWidgets();
        setAdapeter();
    }

    private void initWidgets() {
        lvItems = findViewById(R.id.lvItems);
    }

    private void setAdapeter() {
        List<Item> items = Arrays.asList(
                new Item("Markovic", "Marko", "Programiranje", 5),
                new Item("Ana", "Anic", "Baze podataka", 4)
        );

        ArrayAdapter<Item> adapter = new ItemsAdapter(this, -1, items);
        lvItems.setAdapter(adapter);
    }
}
