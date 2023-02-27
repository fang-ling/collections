//
//  red_black_tree_test.c
//  c-collections
//
//  Created by Fang Ling on 2023/2/26.
//

#include "red_black_tree_test.h"
#include "red_black_tree.h"
#include "test_support.h"

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
    var tree = red_black_tree_init(sizeof(Int), true, int_cmp);
    expect_true(tree -> is_empty);

    var delta = 19358ll;
    red_black_tree_insert(tree, &delta);
    expect_false(tree -> is_empty);

    red_black_tree_remove(tree, &delta);
    expect_true(tree -> is_empty);

    red_black_tree_deinit(tree);
    return true;
}

static Bool test_count(void) {
    /* set count */
    var tree = red_black_tree_init(sizeof(Int), true, int_cmp);
    var delta = 0ll;
    expect_equal(&tree -> count, &delta, int_equal);

    delta = 19358ll;
    red_black_tree_insert(tree, &delta);
    delta = 1ll;
    expect_equal(&tree -> count, &delta, int_equal);

    delta = 19358ll;
    red_black_tree_insert(tree, &delta);
    delta = 2ll;
    expect_equal(&tree -> count, &delta, int_equal);

    delta = 12333ll;
    red_black_tree_insert(tree, &delta);
    delta = 3ll;
    expect_equal(&tree -> count, &delta, int_equal);

    delta = 19358ll;
    red_black_tree_remove(tree, &delta);
    delta = 2ll;
    expect_equal(&tree -> count, &delta, int_equal);

    delta = 12333ll;
    red_black_tree_remove(tree, &delta);
    delta = 1ll;
    expect_equal(&tree -> count, &delta, int_equal);

    red_black_tree_deinit(tree);

    /* multiset count */
    tree = red_black_tree_init(sizeof(Int), false, int_cmp);

    delta = 19358ll;
    red_black_tree_insert(tree, &delta);
    delta = 1ll;
    expect_equal(&tree -> count, &delta, int_equal);

    delta = 19358ll;
    red_black_tree_insert(tree, &delta);
    delta = 1ll;
    expect_equal(&tree -> count, &delta, int_equal);

    delta = 19358ll;
    red_black_tree_remove(tree, &delta);
    delta = 0ll;
    expect_equal(&tree -> count, &delta, int_equal);

    red_black_tree_deinit(tree);
    return true;
}

void red_black_tree_test(void) {
    run_test("Red Black Tree", "test_is_empty", test_is_empty);
    run_test("Red Black Tree", "test_count", test_count);
}
