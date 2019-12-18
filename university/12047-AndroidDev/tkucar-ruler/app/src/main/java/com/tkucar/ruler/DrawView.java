package com.tkucar.ruler;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.os.Build;
import android.text.TextPaint;
import android.util.AttributeSet;
import android.util.DisplayMetrics;
import android.view.View;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

public class DrawView extends View{
    Paint paint = new Paint();
    TextPaint textPaint = new TextPaint();
    DisplayMetrics dm = getResources().getDisplayMetrics();

    public DrawView(Context context) {
        super(context);
        init(null);
    }

    public DrawView(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        init(attrs);
    }

    public DrawView(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init(attrs);
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    public DrawView(Context context, @Nullable AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        init(attrs);
    }

    private void init(@Nullable AttributeSet set){
        paint.setStrokeWidth(3f);
        paint.setColor(Color.BLACK);

        textPaint.setAntiAlias(true);
        textPaint.setTextSize(16 * getResources().getDisplayMetrics().density);
        textPaint.setColor(0xFF000000);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        canvas.translate(0, 100);

        canvas.drawLine(
                0,
                0,
                getWidth(),
                0,
                paint
        );


        float mm = (float) (1.0f * dm.xdpi / 25.4);
        float ekranMM = (float) ((dm.xdpi * dm.widthPixels)/ 25.4);

        int counter = 0;
        for (float i = 0; i < ekranMM; i+=mm){
            if (counter%10==0) {
                canvas.drawLine(i, -50, i, 50, paint);
                canvas.drawText(String.valueOf(counter/10),i-mm,90, textPaint);
                counter++;
            }
            else if (counter%5 == 0) {
                canvas.drawLine(i, -25, i, 25, paint);
                counter++;
            }
            else {
                canvas.drawLine(i, -10, i, 10, paint);
                counter++;
            }
        }
    }
}