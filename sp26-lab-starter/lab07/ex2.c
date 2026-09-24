#include "ex2.h"

double dotp_naive(double* x, double* y, int arr_size) {
    double global_sum = 0.0;

    for (int i = 0; i < arr_size; i++)
        global_sum += x[i] * y[i];

    return global_sum;
}

// Critical Keyword
double dotp_critical(double* x, double* y, int arr_size) {
    double global_sum = 0.0;

    #pragma omp parallel for
    for (int i = 0; i < arr_size; i++) {
        #pragma omp critical
        {
            global_sum += x[i] * y[i];
        }
    }

    return global_sum;
}

// Reduction Keyword
double dotp_reduction(double* x, double* y, int arr_size) {
    double global_sum = 0.0;

    #pragma omp parallel for reduction(+:global_sum)
    for (int i = 0; i < arr_size; i++) {
        global_sum += x[i] * y[i];
    }

    return global_sum;
}

// Manual Reduction
double dotp_manual_reduction(double* x, double* y, int arr_size) {
    double global_sum = 0.0;

    #pragma omp parallel
    {
        double local_sum = 0.0;

        #pragma omp for
        for (int i = 0; i < arr_size; i++) {
            local_sum += x[i] * y[i];
        }

        // Each thread enters this section only once.
        #pragma omp critical
        {
            global_sum += local_sum;
        }
    }

    return global_sum;
}


// Naive: 1 thread took 1.129563 seconds
// Critical: 1 thread(s) took 1.893523 seconds
// Reduction Optimized: 1 thread(s) took 1.127523 seconds
// Reduction Optimized: 2 thread(s) took 0.597902 seconds
// Fastest reduction optimized didn't achieve at least 2.5x speedup from naive.