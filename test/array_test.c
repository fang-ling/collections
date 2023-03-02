//
//  array_test.c
//  c-collections
//
//  Created by Fang Ling on 2023/3/1.
//

#include "array_test.h"

#define var __auto_type

/*static Int int_cmp(void* lhs, void* rhs) {
    if (*(Int*)lhs > *(Int*)rhs) {
        return 1;
    } else if(*(Int*)lhs < *(Int*)rhs) {
        return -1;
    }
    return 0;
}

static Bool equal(void* lhs, void* rhs) {
    if (int_cmp(lhs, rhs) == 0) {
        return true;
    }
    return false;
    }*/

static Bool test_is_empty(void) {
    var array = array_init(sizeof(Int));
    expect_true(array -> is_empty);

    var delta = 19358ll;
    array_append(array, &delta);
    expect_false(array -> is_empty);

    array_remove_lastn(array);
    expect_true(array -> is_empty);

    array_insert(array, &delta, 0);
    expect_false(array -> is_empty);

    array_remove_firstn(array);
    expect_true(array -> is_empty);

    array_deinit(array);

    array = array_init2(sizeof(Int), delta);
    expect_false(array -> is_empty);

    array_deinit(array);

    array = array_init3(sizeof(Int), &delta, delta);
    expect_false(array -> is_empty);

    array_deinit(array);
    return true;
}

void array_test(void) {
    run_test("Array", "test_is_empty", test_is_empty);
}
