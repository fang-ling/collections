//
//  test_support.h
//  c-collections
//
//  Created by Fang Ling on 2023/2/18.
//

#ifndef test_support_h
#define test_support_h

#include <stdio.h>
#include <string.h>

#include "util.h"
#include "types.h"

void expect_true(Bool value);
void expect_false(Bool value);

void expect_null(void* value);
void expect_not_null(void* value);

void expect_equal(void *lhs, void *rhs, Bool (*equal)(void *lhs, void *rhs));
void expect_not_equal(void* lhs,
                      void* rhs,
                      Bool (*equal)(void* lhs, void* rhs));
void expect_equal_elements(void* lhs,
                           void* rhs,
                           Int count,
                           Int element_size,
                           Bool (*equal)(void* lhs, void* rhs));

void run_test(const Char* ds, const Char* fn, Bool (*test_function)(void));

void c_array_shuffle(Int* array, Int count);

#endif /* test_support_h */
