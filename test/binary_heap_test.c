//
//  binary_heap_test.c
//  c-collections
//
//  Created by Fang Ling on 2023/2/18.
//

#include "binary_heap_test.h"

#define var __auto_type

/* See: https://stackoverflow.com/questions/6127503/shuffle-array-in-c */
static void shuffle(Int* array, Int count) {
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
    return cmp(&(((struct Task*)rhs) -> priority),
               &(((struct Task*)lhs) -> priority));
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
        shuffle(input, c);
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

void binary_heap_test(void) {
    run_test("Binary Heap", "test_is_empty", test_is_empty);
    run_test("Binary Heap", "test_count", test_count);
    run_test("Binary Heap", "test_insert", test_insert);
    run_test("Binary Heap", "test_insert_random", test_insert_random);
}
