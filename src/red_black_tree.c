//
//  red_black_tree.c
//  c-collections
//
//  Created by Fang Ling on 2023/2/19.
//

#include "red_black_tree.h"

#define var __auto_type

/** Begin: Private helpers **/
/* Create a new red black tree node */
static struct RedBlackTreeNode*
red_black_tree_node_init(void* key,
                         Int element_size,
                         Int size,
                         Int count,
                         struct RedBlackTreeNode* left,
                         struct RedBlackTreeNode* right,
                         struct RedBlackTreeNode* p,
                         enum RedBlackTreeColor color) {
    var node =
        (struct RedBlackTreeNode*)malloc(sizeof(struct RedBlackTreeNode));

    node -> child[0] = left;
    node -> child[1] = right;
    node -> p = p;
    node -> color = color;
    node -> count = count;
    node -> size = size;
    if (key == NULL) {
        /* If either dest or src is a null pointer,
         * the behavior is undefined, even if count is zero.
         * See: https://en.cppreference.com/w/cpp/string/byte/memcpy
         */
        node -> key = NULL;
    } else {
        memcpy(node -> key, key, element_size);
    }

    return node;
}
/** End: Private helpers **/

/** Begin: Creating a tree **/
/* Creates a new, empty tree. */
struct RedBlackTree *
red_black_tree_init(Int element_size,
                    Int (*compare)(void* lhs, void* rhs)) {
    var tree = (struct RedBlackTree*)malloc(sizeof(struct RedBlackTree));
    tree -> count = 0;
    tree -> is_empty = true;
    tree -> compare = compare;

    tree -> nil = red_black_tree_node_init(NULL,         /* key */
                                           element_size, /* e_size */
                                           0,            /* size */
                                           0,            /* count */
                                           NULL,         /* left */
                                           NULL,         /* right */
                                           NULL,         /* p */
                                           RBT_BLACK);   /* color */
    tree -> root = tree -> nil;
    tree -> root -> p = tree -> nil;

    return tree;
}
/** End: Creating a tree **/
