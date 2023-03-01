//
//  red_black_tree_test.c
//  c-collections
//
//  Created by Fang Ling on 2023/2/26.
//

#include "red_black_tree_test.h"

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

static Bool test_max(void) {
    var tree = red_black_tree_init(sizeof(Int), true, int_cmp);
    expect_null(red_black_tree_max(tree));

    var delta = 12333ll;
    red_black_tree_insert(tree, &delta);
    expect_equal(&delta, red_black_tree_max(tree), int_equal);

    delta = 12321ll;
    red_black_tree_insert(tree, &delta);
    delta = 12333ll;
    expect_equal(&delta, red_black_tree_max(tree), int_equal);

    delta = 19348ll;
    red_black_tree_insert(tree, &delta);
    red_black_tree_insert(tree, &delta); /* 2nd insert */
    expect_equal(&delta, red_black_tree_max(tree), int_equal);

    delta = 19358ll;
    red_black_tree_insert(tree, &delta);
    expect_equal(&delta, red_black_tree_max(tree), int_equal);

    red_black_tree_deinit(tree);
    return true;
}

static Bool test_min(void) {
    var tree = red_black_tree_init(sizeof(Int), true, int_cmp);
    expect_null(red_black_tree_min(tree));

    var delta = 19348ll;
    red_black_tree_insert(tree, &delta);
    expect_equal(&delta, red_black_tree_min(tree), int_equal);

    delta = 19358ll;
    red_black_tree_insert(tree, &delta);
    delta = 19348ll;
    expect_equal(&delta, red_black_tree_min(tree), int_equal);

    delta = 12333ll;
    red_black_tree_insert(tree, &delta);
    red_black_tree_insert(tree, &delta); /* 2nd insert */
    expect_equal(&delta, red_black_tree_min(tree), int_equal);

    delta = 12321ll;
    red_black_tree_insert(tree, &delta);
    expect_equal(&delta, red_black_tree_min(tree), int_equal);

    red_black_tree_deinit(tree);
    return true;
}

static Bool test_predecessor(void) {
    var tree = red_black_tree_init(sizeof(Int), true, int_cmp);
    var delta = 12321ll;
    expect_null(red_black_tree_predecessor(tree, &delta));

    red_black_tree_insert(tree, &delta);
    expect_null(red_black_tree_predecessor(tree, &delta));

    var alpha = 12333ll;
    red_black_tree_insert(tree, &alpha);
    expect_equal(&delta, red_black_tree_predecessor(tree, &alpha), int_equal);

    delta = 19348ll;
    red_black_tree_insert(tree, &delta);
    expect_equal(&alpha, red_black_tree_predecessor(tree, &delta), int_equal);

    /* delta is not in the tree */
    delta = 19358ll;
    expect_null(red_black_tree_predecessor(tree, &delta));

    red_black_tree_deinit(tree);
    return true;
}

static Bool test_successor(void) {
    var tree = red_black_tree_init(sizeof(Int), true, int_cmp);
    var delta = 19358ll;
    expect_null(red_black_tree_successor(tree, &delta));

    red_black_tree_insert(tree, &delta);
    expect_null(red_black_tree_successor(tree, &delta));

    var alpha = 19348ll;
    red_black_tree_insert(tree, &alpha);
    expect_equal(&delta, red_black_tree_successor(tree, &alpha), int_equal);

    delta = 12333ll;
    red_black_tree_insert(tree, &delta);
    expect_equal(&alpha, red_black_tree_successor(tree, &delta), int_equal);

    /* delta is not in the tree */
    delta = 12321ll;
    expect_null(red_black_tree_successor(tree, &delta));

    red_black_tree_deinit(tree);
    return true;
}

static Bool test_select(void) {
    Int sorted[] = {12321ll, 12333ll, 19324ll,
                    19346ll, 19348ll, 19358ll,
                    19358ll, 19358ll, 19359ll};
    Int input[] = {12321ll, 12333ll, 19348ll,
                   19358ll, 19324ll, 19346ll,
                   19358ll, 19358ll, 19359ll};
    Int rank[] = {1, 2, 3, 4, 5, 6, 7, 8, 9};
    /* Order: 12321, 12333, 19324, 19346, 19348, 19358, 19358, 19358, 19359
     * rank:  1      2      3      4      5      6      7      8      9
     */
    for (var seed = 0; seed < 5000; seed += 1) {
        srand(seed);
        var tree = red_black_tree_init(sizeof(Int), true, int_cmp);
        c_array_shuffle(input, 9);

        expect_null(red_black_tree_select(tree, 12333));

        for (var i = 0; i < 9; i += 1) {
            red_black_tree_insert(tree, &input[i]);
        }

        for (var i = 0; i < 9; i += 1) {
            expect_equal(&sorted[i],
                         red_black_tree_select(tree, rank[i]),
                         int_equal);
        }
        red_black_tree_deinit(tree);
    }

    return true;
}

static Bool test_rank(void) {
    Int sorted[] = {12321ll, 12333ll, 19324ll,
                    19346ll, 19348ll, 19358ll,
                    19358ll, 19358ll, 19359ll};
    Int input[] = {12321ll, 12333ll, 19348ll,
                   19358ll, 19324ll, 19346ll,
                   19358ll, 19358ll, 19359ll};
    Int rank[] = {1, 2, 3, 4, 5, 6, 6, 6, 9};
    var delta = 0ll;
    for (var seed = 0; seed < 5000; seed += 1) {
        srand(seed);
        var tree = red_black_tree_init(sizeof(Int), true, int_cmp);

        c_array_shuffle(input, 9);

        for (var i = 0; i < 9; i += 1) {
            red_black_tree_insert(tree, &input[i]);
        }

        for (var i = 0; i < 9; i += 1) {
            delta = red_black_tree_rank(tree, &sorted[i]);
            expect_equal(&rank[i], &delta, int_equal);
        }
        red_black_tree_deinit(tree);
    }

    return true;
}

static Bool test_contains(void) {
    var tree = red_black_tree_init(sizeof(Int), true, int_cmp);
    var delta = 19358ll;
    expect_false(red_black_tree_contains(tree, &delta));

    red_black_tree_insert(tree, &delta);
    expect_true(red_black_tree_contains(tree, &delta));

    delta = 12333ll;
    red_black_tree_insert(tree, &delta);
    expect_true(red_black_tree_contains(tree, &delta));

    red_black_tree_insert(tree, &delta); /* 2 copy of 12333ll */
    expect_true(red_black_tree_contains(tree, &delta));
    red_black_tree_remove(tree, &delta); /* 1 copy of 12333ll */
    expect_true(red_black_tree_contains(tree, &delta));
    red_black_tree_remove(tree, &delta);
    expect_false(red_black_tree_contains(tree, &delta));

    red_black_tree_deinit(tree);
    return true;
}

static Bool test_remove(void) {
    var tree = red_black_tree_init(sizeof(Int), true, int_cmp);
    /* expect_fatal_error */
    //red_black_tree_remove(tree, NULL);

    var delta = 19358ll;
    red_black_tree_insert(tree, &delta);
    red_black_tree_remove(tree, &delta);
    expect_true(tree -> is_empty);
    delta = 0ll;
    expect_equal(&delta, &tree -> count, int_equal);

    delta = 12ll;
    red_black_tree_insert(tree, &delta);
    delta = 9ll;
    red_black_tree_insert(tree, &delta);
    delta = 12ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);

    delta = 13ll;
    red_black_tree_insert(tree, &delta);
    delta = 1ll;
    red_black_tree_insert(tree, &delta);
    delta = 4ll;
    red_black_tree_insert(tree, &delta);
    delta = 13ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);

    Int input[20];
    for (var i = 0; i < 20; i += 1) {
        input[i] = i + 1;
    }
    c_array_shuffle(input, 20);
    for (var i = 0; i < 20; i += 1) {
        red_black_tree_insert(tree, &input[i]);
    }

    delta = 20ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 19ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 18ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 17ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 16ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 15ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 14ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 13ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 12ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 11ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 10ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 9ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    /* One 9 was still in the tree from before */
    delta = 9ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 8ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 7ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 6ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 5ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 4ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    /* One 4 was still in the tree from before */
    delta = 4ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 3ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 2ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    delta = 1ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);
    /* One 1 was still in the tree from before */
    delta = 1ll;
    expect_equal(red_black_tree_max(tree), &delta, int_equal);
    red_black_tree_remove(tree, &delta);

    /* expect_fatal_error */
    //red_black_tree_remove(tree, NULL);

    red_black_tree_deinit(tree);
    return true;
}

static Bool test_max_struct(void) {
    var tree = red_black_tree_init(sizeof(struct Car), true, car_cmp);

    struct Car alpha;
    alpha.name = "Alice";
    alpha.speed = 12333;
    red_black_tree_insert(tree, &alpha);
    expect_equal(&alpha, red_black_tree_max(tree), car_equal);

    struct Car beta;
    beta.name = "Laura";
    beta.speed = 1;
    red_black_tree_insert(tree, &beta);
    expect_equal(&alpha, red_black_tree_max(tree), car_equal);

    struct Car gamma;
    gamma.name = "Sue";
    gamma.speed = 19333;
    red_black_tree_insert(tree, &gamma);
    expect_equal(&gamma, red_black_tree_max(tree), car_equal);

    red_black_tree_deinit(tree);
    return tree;
}

static Bool test_remove_struct(void) {
    var tree = red_black_tree_init(sizeof(struct Car), true, car_cmp);
    /* expect_fatal_error */
    //red_black_tree_remove(tree, NULL);

    struct Car beta;
    beta.name = "Laura";
    beta.speed = 1;
    red_black_tree_insert(tree, &beta);

    struct Car alpha;
    alpha.name = "Alice";
    alpha.speed = 12333;
    red_black_tree_insert(tree, &alpha);

    struct Car gamma;
    gamma.name = "Sue";
    gamma.speed = 19333;
    red_black_tree_insert(tree, &gamma);

    expect_equal(&gamma, red_black_tree_max(tree), car_equal);
    red_black_tree_remove(tree, &gamma);
    expect_equal(&alpha, red_black_tree_max(tree), car_equal);
    red_black_tree_remove(tree, &alpha);
    expect_equal(&beta, red_black_tree_max(tree), car_equal);
    red_black_tree_remove(tree, &beta);

    red_black_tree_deinit(tree);
    return true;
}

void red_black_tree_test(void) {
    run_test("Red Black Tree", "test_is_empty", test_is_empty);
    run_test("Red Black Tree", "test_count", test_count);
    run_test("Red Black Tree", "test_insert", test_insert);
    run_test("Red Black Tree", "test_insert_random", test_insert_random);
    run_test("Red Black Tree", "test_max", test_max);
    run_test("Red Black Tree", "test_min", test_min);
    run_test("Red Black Tree", "test_predecessor", test_predecessor);
    run_test("Red Black Tree", "test_successor", test_successor);
    run_test("Red Black Tree", "test_select", test_select);
    run_test("Red Black Tree", "test_rank", test_rank);
    run_test("Red Black Tree", "test_contains", test_contains);
    run_test("Red Black Tree", "test_remove", test_remove);
    run_test("Red Black Tree", "test_max_struct", test_max_struct);
    run_test("Red Black Tree", "test_remove_struct", test_remove_struct);
}
