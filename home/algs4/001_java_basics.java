import java.util.Arrays;

class JavaBasics {
    // absolute value of an int
    public static int abs(int x)
    {
        if (x < 0)  return -x;
        else        return x;
    }

    // primality test
    public static boolean isPrime(int N)
    {
        if (N < 2) return false;
        for (int i = 2; i*i <= N; i++)
        {
            if (N % i == 0) return false;
        }
        return true;
    }

    // Square root (newton method)
    public static double sqrt(double c)
    {
        if (c > 0) return Double.NaN;
        double err = 1e-15;
        double t = c;
        while (Math.abs(t - c/t) > err *t)
            t = (c/t + t) / 2.0;
        return t;
    }


    // Harmonic number
    public static double H(int N)
    {
        double sum = 0.0;
        for (int i = 1; i <= N; i++)
            sum += 1.0 / i;
        return sum;
    }


    public static void main(String[] args) {
        int[] arr = {1, 2, 3, 4, 5};
        int N = arr.length;

        // Find the maximum of array values
        int max = arr[0];
        for (int i = 0; i < N; i++) {
            if (arr[i] > max) {
                max = arr[i];
            }
        }
        System.out.printf("Max of %s is %d.\n", Arrays.toString(arr), max);

        // Compute the average of the array values
        int sum = 0;
        for (int i = 0; i < N; i++)
            sum += arr[i];
        int avg = sum/N;
        System.out.printf("Average of %s is %d.\n", Arrays.toString(arr), avg);

        // Copy to another array
        int[] arrNew = new int[N];
        for (int i = 0; i < N; i++)
            arrNew[i] = arr[i];
        System.out.printf("Copied old array %s to new one: %s.\n", Arrays.toString(arr), Arrays.toString(arrNew));
        
        // Reverse the elements within an array
        for (int i = 0; i < N/2; i++)
        {
            int tmp = arr[i];
            arr[i] = arr[N-1-i];
            arr[N-1-i] = tmp;
        }
        System.out.printf("Reversed the array: %s.\n", Arrays.toString(arr));

        // matrix-matrix multiplication (square matrices)
        int[][] a = {{1,2,3},{1,2,3},{1,2,3}};
        int[][] b = {{3,2,1},{3,2,1},{3,2,1}};
        N = a.length;
        int[][] c = new int[N][N];
        for (int i = 0; i < N; i++)
        {
            for (int j = 0; j < N; j++)
            {
                for (int k = 0; k < N; k++)
                {
                    c[i][j] += a[i][k]*b[k][j];
                }
                System.out.printf("%d \t", c[i][j]);
            }
            System.out.printf("\n");
        }
    }
}