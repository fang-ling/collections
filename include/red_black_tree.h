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
#include "util.h"

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

    Int element_size;
    /* The number of elements in the tree */
    Int count;
    /* A Boolean value indicating whether the tree is empty. */
    Bool is_empty;
    /* A Boolean value indicating whether the tree allows duplicate keys. */
    Bool is_allowed_duplicate;
    /* Compare function, like Java */
    Int (*compare)(const void* lhs, const void* rhs);
};

/** Begin: Creating a tree **/
/* Creates a new, empty tree. */
struct RedBlackTree*
red_black_tree_init(Int element_size,
                    Bool is_allowed_duplicate,
                    Int (*compare)(const void* lhs, const void* rhs));
/** End: Creating a tree **/

/** Begin: Destroying a tree **/
void red_black_tree_deinit(struct RedBlackTree* tree);
/** End: Destroying a tree **/

/** Begin: Insertion **/
/* Insert a new item into the tree */
void red_black_tree_insert(struct RedBlackTree* tree, void* key);
/** End: Insertion **/

/** Begin: Removal **/
// (Returns true if key is in the tree.)
Bool red_black_tree_remove(struct RedBlackTree* tree, void* key);
/** End: Removal **/

/** Begin: Lookup **/
/* Returns the smallest element in a search tree in O(lg n) time. */
void* red_black_tree_min(struct RedBlackTree* tree);

/* Returns the largest element in a search tree in O(lg n) time. */
void* red_black_tree_max(struct RedBlackTree* tree);

/* Returns the smallest key greater than the given key. */
void* red_black_tree_successor(struct RedBlackTree* tree, void* key);

/* Returns the largest key smaller than the given key. */
void* red_black_tree_predecessor(struct RedBlackTree* tree, void* key);

/* Returns the position of x with key in the linear order determined by an
 * inorder tree walk of tree.
 */
Int red_black_tree_rank(struct RedBlackTree* tree, void* key);

/* Returns the i-th smallest key in a tree */
void* red_black_tree_select(struct RedBlackTree* tree, Int i);

/* Returns a Boolean value indicating whether the tree contains the given
 * element.
 */
Bool red_black_tree_contains(struct RedBlackTree* tree, void* key);
/** End: Lookup **/

#endif /* red_black_tree_h */
