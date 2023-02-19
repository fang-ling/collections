//
//  red_black_tree.h
//  c-collections
//
//  Created by Fang Ling on 2023/2/19.
//

#ifndef red_black_tree_h
#define red_black_tree_h

#include <stdlib.h>
#include <string.h>

#include "types.h"

enum RedBlackTreeColor {
    RBT_RED,
    RBT_BLACK
};

struct RedBlackTreeNode {
    struct RedBlackTreeNode* child[2];
    struct RedBlackTreeNode* p;
    enum RedBlackTreeColor color;
    Int count; /* Duplicate element count */
    Int size; /* Subtree size */
    void* key;
};

struct RedBlackTree {
    struct RedBlackTreeNode* root;
    struct RedBlackTreeNode* nil;

    /* The number of elements in the tree */
    Int count;
    /* A Boolean value indicating whether the tree is empty. */
    Bool is_empty;
    /* Compare function, like Java */
    Int (*compare)(void* lhs, void* rhs);
};

#endif /* red_black_tree_h */
