//
//  red_black_tree_test.c
//  c-collections
//
//  Created by Fang Ling on 2023/2/26.
//

#include "red_black_tree_test.h"

#define var __auto_type

static Int int_cmp(void* lhs, void* rhs) {
    if (*(Int*)lhs < *(Int*)rhs) {
        return -1;
    } else if (*(Int*)lhs > *(Int*)rhs) {
        return 1;
    }
    return 0;
}

static Bool int_equal(void* lhs, void* rhs) {
    return int_cmp(lhs, rhs) == 0 ? true : false;
}

static Bool test_is_empty(void) {
    var tree = red_black_tree_init(sizeof(Int), int_cmp);
    expect_true(tree -> is_empty);

    var delta = 19358ll;
    red_black_tree_insert(tree, &delta, true);
    //expect_false(tree -> is_empty);

    //red_black_tree_remove(tree, &delta);
    //expect_true(tree -> is_empty);

    //red_black_tree_deinit(tree);
    return true;
}


void red_black_tree_test(void) {
    run_test("Red Black Tree", "test_is_empty", test_is_empty);
}
