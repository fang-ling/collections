//
//  test.c
//  c-collections
//
//  Created by Fang Ling on 2023/1/17.
//

#include <time.h>

#include "binary_heap_test.h"
#include "red_black_tree_test.h"
#include "array_test.h"

#define var __auto_type

/** Begin: Combining Arrays **/
/*Bool test_array_append2() {
    var delta = 12333ll;
    var lhs = array_init3(sizeof(Int), &delta, 3);
    Int buf[] = {12333, 12333, 12333, 19358, 19358,
                 19358, 100, 19358, 19358, 200};
    var rhs = array_init(sizeof(Int));
    for (var i = 3; i < 10; i += 1) {
        array_append(rhs, &buf[i]);
    }
    array_append2(lhs, rhs);
    for (var i = 0; i < 10; i += 1) {
        if (*(Int*)array_get(lhs, i) != buf[i]) {
            return false;
        }
    }
    return true;
    }*/
/** End: Combining Arrays **/

/** Begin: Removing Elements **/
/*Bool test_array_remove() {
    Int buf[] = {12333, 19358, 19348, 12321};
    var array = array_init(sizeof(Int));
*//* Test empty array remove */
    //array_remove(array, 0);
    //array_remove(array, 100);
/*
    for (var i = 0; i < 4; i += 1) {
        array_append(array, &buf[i]);
    }
    free(array_remove(array, 1));
*//* array should contains {12333, 19348, 12321} */
/*  if (*(Int*)array_get(array, 0) != buf[0] ||
        *(Int*)array_get(array, 1) != buf[2] ||
        *(Int*)array_get(array, 2) != buf[3] ||
        array -> count != 3) {
        return false;
    }

    free(array_remove(array, 1));
*/  /* array should contains {12333, 12321} */
/*  if (*(Int*)array_get(array, 0) != buf[0] ||
        *(Int*)array_get(array, 1) != buf[3] ||
        array -> count != 2) {
        return false;
    }

    free(array_remove(array, 1));
*/  /* array should contains {12333} */
/*  if (*(Int*)array_get(array, 0) != buf[0] ||
        array -> count != 1) {
        return false;
    }

*/  /* Test append after remove */
/*  for (var i = 1; i < 4; i += 1) {
        array_append(array, &buf[i]);
    }
    if (array -> count != 4) {
        return false;
    }
    for (var i = 0; i < 4; i += 1) {
        if (*(Int*)array_get(array, i) != buf[i]) {
            return false;
        }
    }

    return true;
}

Bool test_array_remove_first() {
    Int buf[] = {12333, 19358, 19348, 12321, 89, 1989};
    var array = array_init(sizeof(Int));
    for (var i = 0; i < 6; i += 1) {
        array_append(array, &buf[i]);
    }

    var ret = array_remove_first(array);
    if (*(Int*)ret != buf[0] ||
        *(Int*)array_first(array) != buf[1] ||
        array -> count != 5) {
        return false;
    }
    free(ret);
    for (var i = 0; i < 5; i += 1) {
        free(array_remove_first(array));
    }
    if (array -> count != 0 ||
        !array -> is_empty) {
        return false;
    }

    return true;
}

Bool test_array_remove_last() {
    Int buf[] = {12333, 19358, 19348, 12321, 89, 1989};
    var array = array_init(sizeof(Int));
    for (var i = 0; i < 6; i += 1) {
        array_append(array, &buf[i]);
    }

    var ret = array_remove_last(array);
    if (*(Int*)ret != buf[5] ||
        *(Int*)array_last(array) != buf[4] ||
        array -> count != 5) {
        return false;
    }
    free(ret);
    for (var i = 0; i < 5; i += 1) {
        free(array_remove_last(array));
    }
    if (array -> count != 0 ||
        !array -> is_empty) {
        return false;
    }

    return true;
    }*/
/** End: Removing Elements **/

/** Begin: Reordering an Array’s Elements**/
/*Bool test_array_swap_at() {
    Int buf[] = {12333, 19358, 19348, 12321, 12361, 19333};
    var array = array_init(sizeof(Int));
    for (var i = 0; i < 6; i += 1) {
        array_append(array, &buf[i]);
    }
    Int buf2[] = {12333, 19358, 12321, 19348, 12361, 19333};
    array_swap_at(array, 2, 3);
    for (var i = 0; i < 6; i += 1) {
        if (*(Int*)array_get(array, i) != buf2[i]) {
            return false;
        }
    }
    Int buf3[] = {19333, 19358, 12321, 19348, 12361, 12333};
    array_swap_at(array, 0, 5);
    for (var i = 0; i < 6; i += 1) {
        if (*(Int*)array_get(array, i) != buf3[i]) {
            return false;
        }
    }
    return true;
    }*/
/** End: Reordering an Array’s Elements **/

Int32 main(void) {
    char time_buf[26];

    var timer = time(NULL);
    strftime(time_buf, 26, "%Y-%m-%d %H:%M:%S", localtime(&timer));
    printf("Test Suite 'Binary Heap Test' started at %s\n", time_buf);
    binary_heap_test();

    timer = time(NULL);
    strftime(time_buf, 26, "%Y-%m-%d %H:%M:%S", localtime(&timer));
    printf("Test Suite 'Red Black Tree Test' started at %s\n", time_buf);
    red_black_tree_test();

    timer = time(NULL);
    strftime(time_buf, 26, "%Y-%m-%d %H:%M:%S", localtime(&timer));
    printf("Test Suite 'Red Black Tree Test' started at %s\n", time_buf);
    array_test();

    return 0;
}
