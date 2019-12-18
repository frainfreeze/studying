package hr.algebra.zadatak02;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;

import hr.algebra.zadatak02.view.Circle;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //setContentView(R.layout.activity_main);
        //Circle circle = findViewById(R.id.circle);
        //circle.setValues(2, 0.7f);

        Circle circle = new Circle(this);
        circle.setValues(2, 0.7f);
        setContentView(circle);
    }
}
