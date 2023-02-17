//
//  util.c
//  c-collections
//
//  Created by Fang Ling on 2023/2/17.
//

#include "util.h"

void fatal_error(const char* msg) {
    fprintf(stderr, "Fatal error: %s\n", msg);
    exit(-1);
}
