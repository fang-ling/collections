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

/** Begin: Creating an array **/
/*Bool test_array_init() {
    var array = array_init(sizeof(Int));
    return
        array -> is_empty == true &&
        array -> capacity == 0 &&
        array -> count == 0;
}

Bool test_array_init2() {
    var array = array_init2(sizeof(Int), 9);
    return
        array -> is_empty == false &&
        array -> capacity == 9 &&
        array -> count == 9;
}

Bool test_array_init3() {
    var repeated_value = 8ll;
    var array = array_init3(sizeof(Int), &repeated_value, 5);
    var data_check = true;
    for (var i = 0; i < 5; i += 1) {
        if (*(Int*)(array -> data + array -> element_size * i) !=
            repeated_value) {
            data_check = false;
            break;
        }
    }
    return
        array -> is_empty == false &&
        array -> capacity == 5 &&
        array -> count == 5 &&
        data_check;
        }*/
/** End: Creating an array **/

/** Begin: Accessing Elements **/
/*Bool test_array_get() {
    var value = 12333ll;
    var array = array_init3(sizeof(Int), &value, 19358);
    return *(Int*)array_get(array, 12333) == value;
}

Bool test_array_set() {
    var value = 12333ll;
    var array = array_init3(sizeof(Int), &value, 19358);
    value = 19348ll;
    array_set(array, 12333, &value);
    return *(Int*)array_get(array, 12333) == value;
}

Bool test_array_first() {
    var array = array_init(sizeof(Int));
    var value = 12333ll;
    var array2 = array_init3(sizeof(Int), &value, 19358);
    return
        array_first(array) == NULL &&
        *(Int*)array_first(array2) == value;
}

Bool test_array_last() {
    var array =	array_init(sizeof(Int));
    var value = 12333ll;
    var array2 = array_init3(sizeof(Int), &value, 19358);
    return
        array_last(array) == NULL &&
        *(Int*)array_last(array2) == value;
}

Bool test_array_random_element() {
    // TO-DO;
    return true;
    }*/
/** End: Accessing Elements **/

/** Begin: Adding Elements **/
/*Bool test_array_append() {
    Int buf[] = {1, 2, 3, 4, 5};
    var delta = 100ll;
    var array = array_init(sizeof(Int));
    for (var i = 0; i < 5; i += 1) {
        array_append(array, &buf[i]);
    }
    array_append(array, &delta);

    for (var i = 0; i < 5; i += 1) {
        if (*(Int*)array_get(array, i) != buf[i]) {
            return false;
        }
    }
    return *(Int*)array_get(array, 5) == delta;
}

Bool test_array_insert() {
    Int buf[] = {19358, 19358, 19358, 100, 19358, 19358, 200};
    var value = 19358ll;
    var array = array_init3(sizeof(Int), &value, 5);
    value = 100;
    array_insert(array, &value, 3);
    value = 200;
    array_insert(array, &value, array -> count);
    for (var i = 0; i < 7; i += 1) {
        if (*(Int*)array_get(array, i) != buf[i]) {
            return false;
        }
    }

    var array2 = array_init(sizeof(Int));
    array_insert(array2, &value, 0);

    if (*(Int*)array_get(array2, 0) != 200) {
        return false;
    }

    var array3 = array_init(sizeof(Int));
    for (int i = 0; i < 7; i += 1) {
        array_insert(array3, &buf[i], 0);
    }
    for (int i = 6; i >= 0; i -= 1) {
        if (*(Int*)array_get(array3, 6 - i) != buf[i]) {
            return false;
        }
    }
    return true;
    }*/
/** End: Adding Elements **/

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
