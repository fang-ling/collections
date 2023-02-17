//
//  binary_heap.h
//  binary_heap
//
//  Created by Fang Ling on 2023/2/14.
//

#ifndef binary_heap_h
#define binary_heap_h

#include <stdlib.h>

#include "types.h"
#include "array.h"
#include "util.h"

struct BinaryHeap {
    /* The number of elements in the heap. */
    Int count;
    /* A Boolean value indicating whether or not the heap is empty. */
    Bool is_empty;
    struct Array* storage;

    /* Compare function, like Java */
    Int (*compare)(void* lhs, void* rhs);
};

/** Begin: Creating a heap **/
/* Creates a new, empty heap. */
struct BinaryHeap* binary_heap_init(Int element_size,
                                    Int (*compare)(void* lhs, void* rhs));
/** End: Creaing a heap **/

/** Begin: Destroying a heap **/
/* Destroys all the elements and deallocates all the storage capacity. */
void binary_heap_deinit(struct BinaryHeap* heap);
/** End: Destroying a heap **/

/** Begin: Lookup **/
/* Returns the largest element in a heap in constant time. */
void* binary_heap_max(struct BinaryHeap* heap);
/** End: Lookup **/

/** Begin: Insertion **/
/* Inserts a new item into heap. */
void binary_heap_insert(struct BinaryHeap* heap, void* key);
/** End: Insertion **/

/** Begin: Removal **/
/* Removes and Returns the max item in the heap. */
void* binary_heap_remove(struct BinaryHeap* heap);

/* Removes the max item in the heap */
void binary_heap_removen(struct BinaryHeap *heap);
/** End: Removal **/

#endif /* binary_heap_h */
