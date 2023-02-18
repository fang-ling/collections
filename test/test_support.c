//
//  test_support.c
//  c-collections
//
//  Created by Fang Ling on 2023/2/18.
//

#include "test_support.h"
#include "util.h"
#include <stdio.h>

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

void expect_null(void* value) {
    if (value == NULL) {
        return;
    }
    char buf[64];
    snprintf(buf, 64, "%p is not NULL", value);
    fatal_error(buf);
}

void expect_not_null(void* value) {
    if (value != NULL) {
        return;
    }
    fatal_error("value is NULL");
}

void expect_equal(void* lhs, void* rhs, Bool (*equal)(void* lhs, void* rhs)) {
    if (equal(lhs, rhs)) {
        return;
    }
    char buf[64];
    snprintf(buf, 64, "*%p is not equal to *%p", lhs, rhs);
    fatal_error(buf);
}

void expect_not_equal(void* lhs,
                      void* rhs,
                      Bool (*equal)(void* lhs, void* rhs)) {
    if (!equal(lhs, rhs)) {
        return;
    }
    char buf[64];
    snprintf(buf, 64, "*%p is equal to *%p", lhs, rhs);
    fatal_error(buf);
}
