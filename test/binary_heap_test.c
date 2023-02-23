//
//  binary_heap_test.c
//  c-collections
//
//  Created by Fang Ling on 2023/2/18.
//

#include "binary_heap_test.h"

#define var __auto_type

/* This will clean out the heap */
static void* items_in_decending_order(struct BinaryHeap *heap) {
    var buf = malloc(heap -> storage -> element_size * heap -> count);
    var i = 0;
    void* delta;
    while (!heap -> is_empty) {
        delta = binary_heap_remove(heap);
        memcpy(buf + i * heap -> storage -> element_size,
               delta,
               heap -> storage -> element_size);
        free(delta);
        i += 1;
    }
    return buf;
}

static Int cmp(void* lhs, void* rhs) {
    if (*(Int*)lhs < *(Int*)rhs) {
        return -1;
    } else if (*(Int*)lhs > *(Int*)rhs) {
        return 1;
    }
    return 0;
}

static Bool equal(void* lhs, void* rhs) {
    if (cmp(lhs, rhs) == 0) {
        return true;
    }
    return false;
}

struct Task {
    const Char* name;
    Int priority;
};

static Int cmp2(void* lhs, void* rhs) {
    return cmp(&(((struct Task*)lhs) -> priority),
               &(((struct Task*)rhs) -> priority));
}

static Bool equal2(void* lhs, void* rhs) {
    if (cmp2(lhs, rhs) == 0) {
        return strcmp(((struct Task*)lhs) -> name,
                      ((struct Task*)rhs) -> name) == 0;
    }
    return cmp2(lhs, rhs) == 0;
}

static Bool test_is_empty(void) {
    var heap = binary_heap_init(sizeof(Int), cmp);
    expect_true(heap -> is_empty);

    var delta = 19358ll;
    binary_heap_insert(heap, &delta);
    expect_false(heap -> is_empty);

    free(binary_heap_remove(heap));
    expect_true(heap -> is_empty);

    binary_heap_deinit(heap);
    return true;
}

static Bool test_count(void) {
    var heap = binary_heap_init(sizeof(Int), cmp);
    var delta = 0ll;
    expect_equal(&heap -> count, &delta, equal);

    delta = 19358ll;
    binary_heap_insert(heap, &delta);
    delta = 1ll;
    expect_equal(&heap -> count, &delta, equal);

    delta = 12321ll;
    binary_heap_insert(heap, &delta);
    delta = 2ll;
    expect_equal(&heap -> count, &delta, equal);

    free(binary_heap_remove(heap));
    delta = 1ll;
    expect_equal(&heap -> count, &delta, equal);

    binary_heap_deinit(heap);
    return true;
}

static Bool test_insert(void) {
    var heap = binary_heap_init(sizeof(struct Task), cmp2);

    var delta = 0ll;
    expect_equal(&heap -> count, &delta, equal);
    struct Task alpha;
    alpha.name = "Alice";
    alpha.priority = 12333;
    binary_heap_insert(heap, &alpha);
    delta = 1ll;
    expect_equal(&heap -> count, &delta, equal);

    binary_heap_deinit(heap);
    return true;
}

static Bool test_insert_random(void) {
    var c = 128ll;
    Int input[c];
    Int sorted[c];
    for (var i = 0ll; i < c; i += 1) {
        input[i] = i;
        sorted[i] = c - i - 1;
    }
    for (var seed = 0; seed < 1; seed += 1) {
        srand(seed);
        /* Shuffle array */
        c_array_shuffle(input, c);
        /* Insert */
        var heap = binary_heap_init(sizeof(Int), cmp);
        var i = 0ll;
        while (i < c) {
            expect_equal(&heap -> count, &i, equal);
            binary_heap_insert(heap, &input[i]);
            i += 1;
            expect_equal(&heap -> count, &i, equal);
        }
        expect_equal_elements(sorted, items_in_decending_order(heap),
                              c, sizeof(Int), equal);
        binary_heap_deinit(heap);
    }
    return true;
}

static Bool test_max(void) {
    var heap = binary_heap_init(sizeof(Int), cmp);
    expect_null(binary_heap_max(heap));

    var delta = 12333ll;
    binary_heap_insert(heap, &delta);
    expect_equal(&delta, binary_heap_max(heap), equal);

    delta = 12321ll;
    binary_heap_insert(heap, &delta);
    delta = 12333ll;
    expect_equal(&delta, binary_heap_max(heap), equal);

    delta = 19348ll;
    binary_heap_insert(heap, &delta);
    expect_equal(&delta, binary_heap_max(heap), equal);

    delta = 19358ll;
    binary_heap_insert(heap, &delta);
    expect_equal(&delta, binary_heap_max(heap), equal);

    binary_heap_deinit(heap);
    return true;
}

static Bool test_remove(void) {
    var heap = binary_heap_init(sizeof(Int), cmp);
    /* expect_fatal_error */
    //free(binary_heap_remove(heap));

    var delta = 19358ll;
    binary_heap_insert(heap, &delta);
    var buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);

    delta = 12ll;
    binary_heap_insert(heap, &delta);
    delta = 9ll;
    binary_heap_insert(heap, &delta);
    buf = binary_heap_remove(heap);
    delta = 12ll;
    expect_equal(buf, &delta, equal);

    delta = 13ll;
    binary_heap_insert(heap, &delta);
    delta = 1ll;
    binary_heap_insert(heap, &delta);
    delta = 4ll;
    binary_heap_insert(heap, &delta);
    delta = 13ll;
    buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);

    Int input[20];
    for (var i = 0; i < 20; i += 1) {
        input[i] = i + 1;
    }
    c_array_shuffle(input, 20);
    for (var i = 0; i < 20; i += 1) {
        binary_heap_insert(heap, &input[i]);
    }

    delta = 20ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 19ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 18ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 17ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 16ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 15ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 14ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 13ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 12ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 11ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 10ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 9ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    /* One 9 was still in the heap from before */
    delta = 9ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 8ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 7ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 6ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 5ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 4ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    /* One 4 was still in the heap from before */
    delta = 4ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 3ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 2ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    delta = 1ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);
    /* One 1 was still in the heap from before */
    delta = 1ll; buf = binary_heap_remove(heap);
    expect_equal(buf, &delta, equal);

    /* expect_fatal_error */
    //free(binary_heap_remove(heap));

    delta = 0ll;
    expect_equal(&delta, &heap -> count, equal);
    expect_true(heap -> is_empty);

    binary_heap_deinit(heap);
    return true;
}

static Bool test_max_struct(void) {
    var heap = binary_heap_init(sizeof(struct Task), cmp2);

    struct Task alpha;
    alpha.name = "Alice";
    alpha.priority = 12333;
    binary_heap_insert(heap, &alpha);
    expect_equal(&alpha, binary_heap_max(heap), equal2);

    struct Task beta;
    beta.name = "Laura";
    beta.priority = 1;
    binary_heap_insert(heap, &beta);
    expect_equal(&alpha, binary_heap_max(heap), equal2);

    struct Task gamma;
    gamma.name = "Sue";
    gamma.priority = 19333;
    binary_heap_insert(heap, &gamma);
    expect_equal(&gamma, binary_heap_max(heap), equal2);

    binary_heap_deinit(heap);
    return true;
}

static Bool test_remove_struct(void) {
    var heap = binary_heap_init(sizeof(struct Task), cmp2);
    /* expect_fatal_error */
    //free(binary_heap_remove(heap));

    struct Task beta;
    beta.name = "Laura";
    beta.priority = 1;
    binary_heap_insert(heap, &beta);

    struct Task alpha;
    alpha.name = "Alice";
    alpha.priority = 12333;
    binary_heap_insert(heap, &alpha);

    struct Task gamma;
    gamma.name = "Sue";
    gamma.priority = 19333;
    binary_heap_insert(heap, &gamma);

    expect_equal(&gamma, binary_heap_remove(heap), equal2);
    expect_equal(&alpha, binary_heap_remove(heap), equal2);
    expect_equal(&beta, binary_heap_remove(heap), equal2);

    binary_heap_deinit(heap);
    return true;
}

void binary_heap_test(void) {
    run_test("Binary Heap", "test_is_empty", test_is_empty);
    run_test("Binary Heap", "test_count", test_count);
    run_test("Binary Heap", "test_insert", test_insert);
    run_test("Binary Heap", "test_insert_random", test_insert_random);
    run_test("Binary Heap", "test_max", test_max);
    run_test("Binary Heap", "test_remove", test_remove);
    run_test("Binary Heap", "test_max_struct", test_max_struct);
    run_test("Binary Heap", "test_remove_struct", test_remove_struct);
}
