package hr.algebra.zadatak03;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.List;

import hr.algebra.zadatak03.model.Item;

public class ItemsAdapter extends ArrayAdapter<Item> {

    public ItemsAdapter(@NonNull Context context, int resource, @NonNull List<Item> objects) {
        super(context, resource, objects);
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        if (convertView == null) {
            convertView = LayoutInflater
                    .from(parent.getContext())
                    .inflate(R.layout.item, parent, false);
        }

        Item item = getItem(position);

        TextView tvName = convertView.findViewById(R.id.tvName);
        TextView tvSubject = convertView.findViewById(R.id.tvSubject);
        TextView tvGrade = convertView.findViewById(R.id.tvGrade);

        tvName.setText(item.toString());
        tvSubject.setText(item.getSubject());
        tvGrade.setText(String.valueOf(item.getGrade()));

        return convertView;
    }
}
