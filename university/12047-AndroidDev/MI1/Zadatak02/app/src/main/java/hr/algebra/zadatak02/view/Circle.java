package hr.algebra.zadatak02.view;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.util.AttributeSet;
import android.view.View;

import androidx.annotation.Nullable;

public class Circle extends View {

    private static final int DEFAULT_RADIUS = 100;
    private int nrColoredCircles;

    private Paint transparentPaint;
    private Paint bluePaint;

    public Circle(Context context) {
        super(context);
        init();
    }
    public Circle(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        init();
    }

    private void init() {
        transparentPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        transparentPaint.setStyle(Paint.Style.STROKE);
        transparentPaint.setColor(Color.BLACK);

        bluePaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        bluePaint.setColor(Color.BLUE);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        drawCircles(canvas, DEFAULT_RADIUS, DEFAULT_RADIUS, DEFAULT_RADIUS);
    }

    private void drawCircles(Canvas canvas, int posX, int posY, int radius) {
        Paint paint;
        for (int i = 1; i <= 3 ; i++) {
            if (i <= nrColoredCircles) {
                paint = bluePaint;
            } else {
                paint = transparentPaint;
            }
            canvas.drawCircle(posX, posY, radius, paint);
            posX += radius;
            radius /= 2;
            posX += radius;
        }
    }

    public void setValues(int nrColoredCircles, float transparency) {
        this.nrColoredCircles = nrColoredCircles;
        bluePaint.setAlpha(Math.round(255 * transparency));
        invalidate();
    }
}
