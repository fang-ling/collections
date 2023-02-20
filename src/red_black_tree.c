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
/* Red Black Tree Rotation: Modify tree structure without breaking binary
 * search tree property, i.e. x.left.key < x.key < x.right.key
 */
/*
 *        |                               |
 *       [y]       left_rotate(x)        [x]
 *      /   \      <--------------      /   \
 *    [x]    c                         a    [y]
 *   /   \         -------------->         /   \
 *  a     b        right_rotate(y)        b     c
 */
static void rotate(struct RedBlackTree* tree,
                   struct RedBlackTreeNode* x,
                   Int is_right) {
    var y = x -> child[is_right ^ 1];
    x -> child[is_right ^ 1] = y -> child[is_right];
    if (y -> child[is_right] != tree -> nil) {
        y -> child[is_right] -> p = x;
    }
    y -> p = x -> p;
    if (x -> p == tree -> nil) {
        tree -> root = y;
    } else {
        x -> p -> child[x == x -> p -> child[1] ? 1 : 0] = y;
    }
    y -> child[is_right] = x;
    x -> p = y;
    /* Maintain augmented data */
    y -> size = x -> size;
    x -> size = x -> child[0] -> size + x -> child[1] -> size + x -> count;
}

/* Maintain the red black tree property violated by insert. */
/* Notes from CLRS 3e:
 * Case 1: z's uncle y is red, {[A]: red node, (A): black node}
 *
 *           |                                   |
 *          (C)                                 [z] <--~ {new z}
 *         /   \                               /   \
 *        /     \                             /     \
 *       /       \                           / _old z\
 *      /         \                         / /       \
 *    [A]         [y]    ------------>    (A) |       (y)
 *   /   \       /   \                   /   \|      /   \
 *  a    [z]    d     e                 a    [z]    d     e
 *      /   \                               /   \
 *     b     c                             b     c
 *
 * Because z.p.p (in here: C) is black, we can color both z.p (A) and y black,
 * thereby fixing the problem of z and z.p (A) both being red, and we can color
 * z.p.p (C) red, thereby maintaining property 5. We then repeat the while loop
 * with z.p.p (C) as the new node z. The pointer z moves up two levels in the
 * tree.
 *
 * Case 2: z's uncle y is black, and z is a right child.
 * Case 3: z's uncle y is black, and z is a left child.
 *
 *           |                                  |
 *          (C)                                (C)
 *         /   \                              /   \
 *        /     \       left-rotate(A)       /     \
 *       /       \      ------------->      /       \
 *      /         \                        /         \
 *    [A]          d y                   [B]          d y
 *   /   \                              /   \
 *  a    [B]z                         [A]z   c
 *      /   \                        /   \
 *     b     c                      a     b
 *              Case 2                        Case 3
 *
 *                                              |
 *                              right-rotate(C) |
 *                                              |
 *                                              V
 *
 *                                              |
 *                                             (C)
 *                                            /   \
 *                                           /     \
 *                                          /       \
 *                                         /         \
 *                                       [A]         [B]
 *                                      /   \       /   \
 *                                     a     b     c     d
 *
 * In case 2 and 3, the color of z's uncle y is black. We distinguish the two
 * cases according to whether z is a right or left child of z.p. In case 2,
 * node z is a right child of its parent. We immediately use a left rotation
 * to transform the situation into case 3, in which node z is a left child.
 * Because both z and z.p are red, the rotation affects neither the black-
 * height of nodes nor property 5. Whether we enter case 3 directly or through
 * case 2, z's uncle y is black, since otherwise we would have executed case 1.
 * Additionally, the node z.p.p exists. In case 3, we execute some color
 * changes and a right rotation, which preserve property 5, and then, since we
 * no longer have two red nodes in a row, we are done. The while loop does not
 * iterate another time, since z.p is now black.
 */
static void insert_fixup(struct RedBlackTree* tree,
                         struct RedBlackTreeNode* node) {
    struct RedBlackTreeNode* p;
    struct RedBlackTreeNode* gp;
    struct RedBlackTreeNode* y;
    var z = node;
    Int is_left;
    while (z -> p -> color == RBT_RED) {
        p = z -> p;
        gp = p -> p;
        is_left = p == gp -> child[0] ? 1 : 0;
        y = gp -> child[is_left];
        if (y -> color == RBT_RED) { /* Case 1 */
            y -> color = RBT_BLACK;
            p -> color = RBT_BLACK;
            gp -> color = RBT_RED;
            z = gp;
        } else {
            if (z == p -> child[is_left]) { /* Case 2 */
                z = p;
                rotate(tree, z, is_left ^ 1);
            }
            /* Case 3 */
            z -> p -> color = RBT_BLACK;
            z -> p -> p -> color = RBT_RED;
            rotate(tree, gp, is_left);
        }
    }
    tree -> root -> color = RBT_BLACK;
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

/** Begin: Destroying a tree **/
// TO-DO
/** End: Destroying a tree **/
