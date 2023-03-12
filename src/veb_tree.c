#include "types.h"
#include <stdio.h>
#include <stdlib.h>

#define nil -1
#define var __auto_type

struct vEBTree {
    Int u;
    Int lower_sqrt;
    Int upper_sqrt;

    Int max;
    Int min;
    Int max_count;
    Int min_count;

    struct vEBTree* summary;
    struct vEBTree** cluster;
};

static Int high(Int lower_sqrt, Int x) { return x / lower_sqrt; }

static Int low(Int lower_sqrt, Int x) { return x % lower_sqrt; }

static Int index(Int lower_sqrt, Int x, Int y) { return x * lower_sqrt + y; }

struct vEBTree* veb_tree_init(Int u) {
    var tree = (struct vEBTree*)malloc(sizeof(struct vEBTree));
    tree -> u = u;
    var delta = u;
    var bit_count = -1;
    while (delta > 0) {
        delta >>= 1;
        bit_count += 1;
    }
    tree -> upper_sqrt = 1 << ((bit_count + 1) / 2);
    tree -> lower_sqrt = 1 << (bit_count / 2);
    tree -> min = nil;
    tree -> max = nil;
    tree -> min_count = 0;
    tree -> max_count = 0;

    if (tree -> u != 2) { /* not leaf */
        tree -> summary = veb_tree_init(tree -> upper_sqrt);
        tree -> cluster = (struct vEBTree**)malloc(tree -> upper_sqrt *
                                                   sizeof(struct vEBTree*));
        for (var i = 0; i < tree -> upper_sqrt; i += 1) {
            tree -> cluster[i] = veb_tree_init(tree -> lower_sqrt);
        }
    }
    return tree;
}

static void empty_tree_insert(struct vEBTree* tree, Int x, Int count) {
    tree -> min = x;
    tree -> max = x;
    tree -> min_count = count;
    tree -> max_count = count;
}

static void tree_insert(struct vEBTree* tree, Int x, Int count) {
    if (tree -> min == nil) {
        empty_tree_insert(tree, x, count);
    }
    if (x == tree -> max) {
        tree -> max += count;
    }
    if (x == tree -> min) {
        tree -> min += count;
        return;
    }
    if (x < tree -> min) {
        /* swap x with tree -> min */
        var delta = x;
        x = tree -> min;
        tree -> min = delta;
        /* swap count with tree -> min_count */
        delta = count;
        count = tree -> min_count;
        tree -> min_count = delta;
    }
    if (tree -> u != 2) { /* not a leaf */
        var h = high(tree -> lower_sqrt, x);
        var l = low(tree -> lower_sqrt, x);
        if (tree -> cluster[h] -> min == nil) {
            tree_insert(tree -> summary, h, 1);
            empty_tree_insert(tree -> cluster[h], l, count);
        } else {
            tree_insert(tree -> cluster[h], l, count);
        }
    }
    if (x > tree -> max) {
        tree -> max = x;
        tree -> max_count = count;
    }
}

Int veb_tree_max(struct vEBTree* tree) {
    return tree -> max;
}

int main(void) {
    var tree = veb_tree_init(65536);

    tree_insert(tree, 2, 1);
    tree_insert(tree, 1, 1);
    tree_insert(tree, 19358, 1);

    printf("%lld\n", veb_tree_max(tree));
    printf("%lld\n", tree -> min);

    return 0;
}
