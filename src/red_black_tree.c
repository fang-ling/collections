//
//  red_black_tree.c
//  c-collections
//
//  Created by Fang Ling on 2023/2/19.
//

#include "red_black_tree.h"

#define var __auto_type

/** Begin: Private helpers **/
/* Creates a new red black tree node */
static struct RedBlackTreeNode* node_init(void* key,
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

/* Destroys a red black tree node */
static void node_deinit(struct RedBlackTreeNode* node) {
    free(node -> key);
    free(node);
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

/* Replaces one subtree as a child of its parent with another subtree.
 * When transplant(tree, u, v) replaces the subtree rooted at node u with the
 * subtree rooted at node v, node u's parent becomes node v's parent, and u's
 * parent ends up having v as its appropriate child.
 */
static void transplant(struct RedBlackTree* tree,
                       struct RedBlackTreeNode* u,
                       struct RedBlackTreeNode* v) {
    if (u -> p == tree -> nil){
        tree -> root = v;
    } else {
        u -> p -> child[(u == u -> p -> child[0]) ? 0 : 1] = v;
    }
    v -> p = u -> p;
}

/* (Internal use)
 * Returns a node in the search tree whose key is a minimum.
 */
static struct RedBlackTreeNode* minimum(struct RedBlackTree* tree,
                                        struct RedBlackTreeNode* x) {
    while (x -> child[0] != tree -> nil) {
        x = x -> child[0];
    }
    return x;
}

/* Maintain the red black tree property violated by remove. */
/* Notes from CLRS 3e:
 * Case 1: x's sibling w is red, {[A]: red node, (A): black node}
 *
 *           |                                   |
 *          (B)                                 (D)
 *         /   \                               /   \
 *        /     \                             /     \
 *       /       \                           /       \
 *      /         \ w                       /         \
 *  x (A)         [D]    ------------>    [B]         (E)
 *   /   \       /   \                   /   \new w  /   \
 *  a     b    (C)   (E)             x (A)   (C)    e     f
 *             / \   / \               / \   / \
 *            c   d e   f             a   b c   d
 *
 * Since w must have black children, we can switch the colors of w and x.p and
 * then perform a left-rotation on x.p without violating any of the red-black
 * properties. The new sibling of x, which is one of w's children prior to the
 * rotation, is now black, and thus we have converted case 1 into case 2, 3, or
 * 4.
 *
 * Case 2: x's sibling w is black, and both of w's children are black
 *
 *           |                                   | new x
 *         [(B)]                              c[(B)]
 *         /   \                               /   \
 *        /     \                             /     \
 *       /       \                           /       \
 *      /         \ w                       /         \
 *  x (A)         (D)    ------------>    (A)         [D]
 *   /   \       /   \                   /   \       /   \
 *  a     b    (C)   (E)                a     b    (C)   (E)
 *             / \   / \                           / \   / \
 *            c   d e   f                         c   d e   f
 *
 * Since w is also black, we take one black off both x and w, leaving x with
 * only one black and leaving w red. To compensate for removing one black from
 * x and w, we would like to add an extra black to x.p, which originally either
 * red or black. We do so by repeating the while loop with x.p as the new node
 * x.
 *
 * Case 3: x's sibling w is black, w's left child is red, and w's right child
 * is black
 *
 *           |                                   |
 *       c [(B)]                              c[(B)]
 *         /   \                               /   \
 *        /     \                             /     \
 *       /       \                           /       \
 *      /         \ w                       /         \ new w
 *  x (A)         (D)    ------------>  x (A)         (C)
 *   /   \       /   \                   /   \       /   \
 *  a     b    [C]   (E)                a     b     c    [D]
 *             / \   / \                                 / \
 *            c   d e   f                               d  (E)
 *                                                         / \
 *                                                        e   f
 *
 * We can switch the colors of w and its left child w.left and then perform a
 * right rotation on w without violating any of the red-black properties. The
 * new sibling w of x is now a black node with a red right child, and thus we
 * have transformed case 3 into case 4.
 *
 * Case 4: x's sibling w is black, and w's right child is red
 *
 *           |                                   |
 *       c [(B)]                              c[(D)]
 *         /   \                               /   \
 *        /     \                             /     \
 *       /       \                           /       \
 *      /         \ w                       /         \
 *  x (A)         (D)    ------------>    (B)         (E)
 *   /   \    c' /   \                   /   \  c'   /   \
 *  a     b   [(C)]  [E]               (A)  [(C)]    e     f
 *             / \   / \               / \   / \
 *            c   d e   f             a   b c   d    new x = T.root
 *
 * By making some color changes and performing a left rotation on x.p, we can
 * remove the extra black on x, making it singly black, without violating any
 * of the red-black properties. Setting x to be the root causes the while loop
 * to terminate when it tests the loop condition.
 */
static void delete_fixup(struct RedBlackTree* tree,
                         struct RedBlackTreeNode* node) {
    var x = node;
    struct RedBlackTreeNode* p;
    struct RedBlackTreeNode* w;
    Int is_left = 0;
    while (x != tree -> root && x -> color == RBT_BLACK) {
        p = x -> p;
        is_left = x == x -> p -> child[0] ? 1 : 0;
        w = p -> child[is_left];
        if (w -> color == RBT_RED) { /* Case 1 */
            p -> color = RBT_RED;
            w -> color = RBT_BLACK;
            rotate(tree, p, is_left ^ 1);
            w = p -> child[is_left];
        }
        if (w -> child[0] -> color == RBT_BLACK &&
            w -> child[1] -> color == RBT_BLACK) { /* Case 2 */
            w -> color = RBT_RED;
            x = x -> p;
        } else {
            if (w -> child[is_left] -> color == RBT_BLACK) { /* Case 3 */
                w -> color = RBT_RED;
                w -> child[is_left ^ 1] -> color = RBT_BLACK;
                rotate(tree, w, is_left);
                w = p -> child[is_left];
            }
            /* Case 4 */
            w -> color = p -> color;
            p -> color = RBT_BLACK;
            w -> child[is_left] -> color = RBT_BLACK;
            rotate(tree, w -> p, is_left ^ 1);
            x = tree -> root;
        }
    }
    x -> color = RBT_BLACK;
}

/** End: Private helpers **/

/** Begin: Creating a tree **/
/* Creates a new, empty tree. */
struct RedBlackTree *
red_black_tree_init(Int element_size,
                    Int (*compare)(void* lhs, void* rhs)) {
    var tree = (struct RedBlackTree*)malloc(sizeof(struct RedBlackTree));
    tree -> element_size = element_size;
    tree -> count = 0;
    tree -> is_empty = true;
    tree -> compare = compare;

    tree -> nil = node_init(NULL,         /* key */
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

/** Begin: Insertion **/
/* Insert a new item into the tree */
void red_black_tree_insert(struct RedBlackTree* tree,
                           void* key,
                           Bool allow_duplicate_key) {
    /* This works by creating a new red node with the key to where it belongs
     * in the tree, using binary search and then fix red black tree property
     * by calling insert_fixup().
     */
    var x = tree -> root;
    var y = tree -> nil;
    var z = node_init(key,                  /* key */
                      tree -> element_size, /* e_size */
                      1,                    /* size */
                      1,                    /* count */
                      tree -> nil,          /* left */
                      tree -> nil,          /* right */
                      tree -> nil,          /* p */
                      RBT_RED);             /* color */
    while (x != tree -> nil) { /* Find the position to insert */
        y = x;
        y -> size += 1;
        /* If exists, add `count` by 1. */
        if (tree -> compare(x -> key, key) == 0) {
            x -> count += 1;
            return;
        }
        x = x -> child[(tree -> compare(x -> key, key) < 0) ? 1 : 0];
    }
    z -> p = y;
    if (y == tree -> nil) {
        tree -> root = z;
    } else {
        y -> child[(tree -> compare(y -> key, key) < 0) ? 1 : 0] = z;
    }
    insert_fixup(tree, z);
    /* Update tree size */
    tree -> count += 1;
    tree -> is_empty = false;
}
/** End: Insertion **/

/** Begin: Removal **/
Bool red_black_tree_remove(struct RedBlackTree* tree, void* key) {
    if (tree -> is_empty) {
        fatal_error("Can't remove from an empty red black tree");
    }
    var z = tree -> root;
    var w = tree -> nil;
    struct RedBlackTreeNode* y;
    struct RedBlackTreeNode* x;
    struct RedBlackTreeNode* delta;
    enum RedBlackTreeColor old_color;
    while (z != tree -> nil) { /* Find a node z with the specific key. */
        w = z;
        w -> size -= 1;
        if (tree -> compare(key, z -> key) == 0) {
            break;
        }
        z = z -> child[tree -> compare(z -> key, key) < 0 ? 1 : 0];
    }
    if (z != tree -> nil) {
        if (z -> count > 1) {
            z -> count -= 1;
            return true;
        }
        y = z;
        old_color = y -> color;
        if (z -> child[0] == tree -> nil) {
            x = z -> child[1];
            transplant(tree, z, z -> child[1]);
        } else if (z -> child[1] == tree -> nil) {
            x = z -> child[0];
            transplant(tree, z, z -> child[0]);
        } else {
            y = minimum(tree, z -> child[1]);
            old_color = y -> color;
            x = y -> child[1];
            if (y -> p == z) {
                x -> p = y;
            } else {
                delta = y;
                while (delta != z) {
                    delta -> size -= y -> count;
                    delta = delta -> p;
                }
                transplant(tree, y, y -> child[1]);
                y -> child[1] = z -> child[1];
                y -> child[1] -> p = y;
            }
            transplant(tree, z, y);
            y -> child[0] = z -> child[0];
            y -> child[0] -> p = y;
            y -> color = z -> color;
            y -> size =
                y -> child[0] -> size +
                y -> child[1] -> size +
                y -> count;
        }
        if (old_color == RBT_BLACK) {
            delete_fixup(tree, x);
        }
        node_deinit(z);
        tree -> count -= 1;
        tree -> is_empty = tree -> count == 0 ? true : false;
        return true;
    } else { /* No such keys, restore subtree sizes */
        while (w != tree -> nil) {
            w -> size += 1;
            w = w -> p;
        }
        return false;
    }
}
/** End: Removal **/

/** Begin: Lookup **/
/** End: Lookup **/
