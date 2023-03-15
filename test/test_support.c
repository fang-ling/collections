//
//  test_support.c
//  c-collections
//
//  Created by Fang Ling on 2023/2/18.
//

#include "test_support.h"

#define var __auto_type

/* Terminal color code */
/* See: https://stackoverflow.com \
 *      /questions/3585846/color-text-in-terminal-applications-in-unix
 */
#define T_RED "\x1B[31m"
#define T_GRN "\x1B[32m"
#define T_RST "\x1B[0m"

void expect_true(Bool value) {
    if (value) {
        return;
    }
    fatal_error("false is not true");
}

void expect_false(Bool value) {
    if (!value) {
        return;
    }
    fatal_error("true is not false");
}

void expect_null(const void* value) {
    if (value == NULL) {
        return;
    }
    char buf[64];
    snprintf(buf, 64, "%p is not NULL", value);
    fatal_error(buf);
}

void expect_not_null(const void* value) {
    if (value != NULL) {
        return;
    }
    fatal_error("value is NULL");
}

void expect_equal(const void* lhs,
                  const void* rhs,
                  Bool (*equal)(const void* lhs, const void* rhs)) {
    if (equal(lhs, rhs)) {
        return;
    }
    char buf[64];
    snprintf(buf, 64, "*%p is not equal to *%p", lhs, rhs);
    fatal_error(buf);
}

void expect_not_equal(const void* lhs,
                      const void* rhs,
                      Bool (*equal)(const void* lhs, const void* rhs)) {
    if (!equal(lhs, rhs)) {
        return;
    }
    char buf[64];
    snprintf(buf, 64, "*%p is equal to *%p", lhs, rhs);
    fatal_error(buf);
}

void expect_equal_elements(const void* lhs,
                           const void* rhs,
                           Int count,
                           Int element_size,
                           Bool (*equal)(const void* lhs, const void* rhs)) {
    if (memcmp(lhs, rhs, count * element_size) == 0) {
        return;
    }
    char buf[64];
    snprintf(buf, 64, "%p does not have equal elements to %p", lhs, rhs);
    fatal_error(buf);
}

void run_test(const Char* ds, const Char* fn, Bool (*test_function)(void)) {
    printf("Test Case '-[%s Test %s()]' started.\n", ds, fn);
    var result = test_function();
    printf("Test Case '-[%s Test %s()]' ", ds, fn);
    printf(result ? T_GRN "passed" T_RST : T_RED "failed" T_RST);
    printf(".\n");
}

/* See: https://stackoverflow.com/questions/6127503/shuffle-array-in-c */
void c_array_shuffle(Int* array, Int count) {
    if (count > 1) {
        var delta = 0ll;
        var j = 0;
        count -= 1;
        for (var i = 0; i < count; i += 1) {
            j = i + rand() / (RAND_MAX / (count + 1 - i) + 1);
            delta = array[i];
            array[i] = array[j];
            array[j] = delta;
        }
    }
}
