//
//  red_black_tree_test.c
//  c-collections
//
//  Created by Fang Ling on 2023/2/26.
//

#include "red_black_tree_test.h"
#include "red_black_tree.h"
#include "test_support.h"
#include "types.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define var __auto_type

/* This will clean out the tree */
static void* items_in_ascending_order(struct RedBlackTree* tree) {
    var buf = malloc(tree -> element_size * tree -> count);
    var i = 0;
    void* delta;
    while (!tree -> is_empty) {
        delta = red_black_tree_min(tree);
        memcpy(buf + i * tree -> element_size,
               delta,
               tree -> element_size);
        red_black_tree_remove(tree, delta);
        i += 1;
    }
    return buf;
}

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

struct Car {
    const Char* name;
    Int speed;
};

static Int car_cmp(void* lhs, void* rhs) {
    return int_cmp(&(((struct Car*)lhs) -> speed),
                   &(((struct Car*)rhs) -> speed));
}

static Bool car_equal(void* lhs, void* rhs) {
    if (car_cmp(lhs, rhs) == 0) {
        return strcmp(((struct Car*)lhs) -> name,
                      ((struct Car*)rhs) -> name) == 0;
    }
    return false;
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

static Bool test_insert(void) {
    var tree = red_black_tree_init(sizeof(struct Car), true, car_cmp);

    var delta = 0ll;
    expect_equal(&tree -> count, &delta, int_equal);
    struct Car alpha;
    alpha.name = "Alice";
    alpha.speed = 12333;
    red_black_tree_insert(tree, &alpha);
    delta = 1ll;
    expect_equal(&tree -> count, &delta, int_equal);

    red_black_tree_deinit(tree);
    return true;
}

static Bool test_insert_random(void) {
    var c = 128ll;
    Int input[c];
    Int sorted[c];
    for (var i = 0ll; i < c; i += 1) {
        input[i] = i;
        sorted[i] = i;
    }
    for (var seed = 0; seed < 5000; seed += 1) {
        srand(seed);
        /* Shuffle array */
        c_array_shuffle(input, c);
        /* Insert */
        var tree = red_black_tree_init(sizeof(Int), true, int_cmp);
        var i = 0ll;
        while (i < c) {
            expect_equal(&tree -> count, &i, int_equal);
            red_black_tree_insert(tree, &input[i]);
            i += 1;
            expect_equal(&tree -> count, &i, int_equal);
        }
        var items = items_in_ascending_order(tree);
        expect_equal_elements(sorted,
                              items,
                              c,
                              tree -> element_size,
                              int_equal);
        red_black_tree_deinit(tree);
        free(items);
    }
    return true;
}

void red_black_tree_test(void) {
    run_test("Red Black Tree", "test_is_empty", test_is_empty);
    run_test("Red Black Tree", "test_count", test_count);
    run_test("Red Black Tree", "test_insert", test_insert);
    run_test("Red Black Tree", "test_insert_random", test_insert_random);
}
