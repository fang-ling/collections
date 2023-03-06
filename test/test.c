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
