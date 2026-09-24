#include <time.h>
#include <stdio.h>
#include <x86intrin.h>
#include "ex1.h"

long long int sum(int vals[NUM_ELEMS]) {
    clock_t start = clock();

    long long int sum = 0;
    for(unsigned int w = 0; w < OUTER_ITERATIONS; w++) {
        for(unsigned int i = 0; i < NUM_ELEMS; i++) {
            if(vals[i] >= 128) {
                sum += vals[i];
            }
        }
    }
    clock_t end = clock();
    printf("Time taken: %Lf s\n", (long double)(end - start) / CLOCKS_PER_SEC);
    return sum;
}

long long int sum_unrolled(int vals[NUM_ELEMS]) {
    clock_t start = clock();
    long long int sum = 0;

    for(unsigned int w = 0; w < OUTER_ITERATIONS; w++) {
        for(unsigned int i = 0; i < NUM_ELEMS / 4 * 4; i += 4) {
            if(vals[i] >= 128) sum += vals[i];
            if(vals[i + 1] >= 128) sum += vals[i + 1];
            if(vals[i + 2] >= 128) sum += vals[i + 2];
            if(vals[i + 3] >= 128) sum += vals[i + 3];
        }

        // TAIL CASE, for when NUM_ELEMS isn't a multiple of 4
        // NUM_ELEMS / 4 * 4 is the largest multiple of 4 less than NUM_ELEMS
        // Order is important, since (NUM_ELEMS / 4) effectively rounds down first
        for(unsigned int i = NUM_ELEMS / 4 * 4; i < NUM_ELEMS; i++) {
            if (vals[i] >= 128) {
                sum += vals[i];
            }
        }
    }
    clock_t end = clock();
    printf("Time taken: %Lf s\n", (long double)(end - start) / CLOCKS_PER_SEC);
    return sum;
}

long long int sum_simd(int vals[NUM_ELEMS]) {
    clock_t start = clock();
    __m128i _127 = _mm_set1_epi32(127); // This is a vector with 127s in it... Why might you need this?
    long long int result = 0; // This is where you should put your final result!
    /* DO NOT MODIFY ANYTHING ABOVE THIS LINE (in this function) */

    for (unsigned int w = 0; w < OUTER_ITERATIONS; w++) {
        __m128i sum_vec = _mm_setzero_si128();
        unsigned int i = 0;

        for (; i < NUM_ELEMS / 4 * 4; i += 4) {
            __m128i values =
                _mm_loadu_si128((__m128i *)(vals + i));

            /* values > 127 is equivalent to values >= 128. */
            __m128i mask = _mm_cmpgt_epi32(values, _127);
            values = _mm_and_si128(values, mask);
            sum_vec = _mm_add_epi32(sum_vec, values);
        }

        /*
         * Reduce after each outer iteration. Waiting until all outer
         * iterations finish could overflow the 32-bit SIMD lanes.
         */
        int partial[4];
        _mm_storeu_si128((__m128i *)partial, sum_vec);

        result += (long long int)partial[0]
                + partial[1]
                + partial[2]
                + partial[3];

        /* Tail case for NUM_ELEMS not divisible by four. */
        for (; i < NUM_ELEMS; i++) {
            if (vals[i] >= 128) {
                result += vals[i];
            }
        }
    }


    /* DO NOT MODIFY ANYTHING BELOW THIS LINE (in this function) */
    clock_t end = clock();
    printf("Time taken: %Lf s\n", (long double)(end - start) / CLOCKS_PER_SEC);
    return result;
}

long long int sum_simd_unrolled(int vals[NUM_ELEMS]) {
    clock_t start = clock();
    __m128i _127 = _mm_set1_epi32(127);
    long long int result = 0;
    /* DO NOT MODIFY ANYTHING ABOVE THIS LINE (in this function) */

    for (unsigned int w = 0; w < OUTER_ITERATIONS; w++) {
        __m128i sum_vec = _mm_setzero_si128();
        unsigned int i = 0;

        /* Four SIMD operations per iteration: 4 × 4 = 16 elements. */
        for (; i < NUM_ELEMS / 16 * 16; i += 16) {
            __m128i values0 =
                _mm_loadu_si128((__m128i *)(vals + i));
            __m128i values1 =
                _mm_loadu_si128((__m128i *)(vals + i + 4));
            __m128i values2 =
                _mm_loadu_si128((__m128i *)(vals + i + 8));
            __m128i values3 =
                _mm_loadu_si128((__m128i *)(vals + i + 12));

            __m128i mask0 = _mm_cmpgt_epi32(values0, _127);
            __m128i mask1 = _mm_cmpgt_epi32(values1, _127);
            __m128i mask2 = _mm_cmpgt_epi32(values2, _127);
            __m128i mask3 = _mm_cmpgt_epi32(values3, _127);

            sum_vec = _mm_add_epi32(
                sum_vec, _mm_and_si128(values0, mask0));
            sum_vec = _mm_add_epi32(
                sum_vec, _mm_and_si128(values1, mask1));
            sum_vec = _mm_add_epi32(
                sum_vec, _mm_and_si128(values2, mask2));
            sum_vec = _mm_add_epi32(
                sum_vec, _mm_and_si128(values3, mask3));
        }

        int partial[4];
        _mm_storeu_si128((__m128i *)partial, sum_vec);

        result += (long long int)partial[0]
                + partial[1]
                + partial[2]
                + partial[3];

        /* Handles all remaining 0–15 elements. */
        for (; i < NUM_ELEMS; i++) {
            if (vals[i] >= 128) {
                result += vals[i];
            }
        }
    }


    /* DO NOT MODIFY ANYTHING BELOW THIS LINE (in this function) */
    clock_t end = clock();
    printf("Time taken: %Lf s\n", (long double)(end - start) / CLOCKS_PER_SEC);
    return result;
}


// Let's generate a randomized array.
// Starting randomized sum.
// Time taken: 5.235024 s
// Sum: 103161741312

// Starting randomized unrolled sum.
// Time taken: 4.196454 s
// Sum: 103161741312

// Starting randomized SIMD sum.
// Time taken: 1.807777 s
// Sum: 103161741312

// Starting randomized SIMD unrolled sum.
// Time taken: 1.612363 s
// Sum: 103161741312

// All tests Passed! Correct values were produced, and speedups were achieved!