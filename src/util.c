#include "util.h"

void fatal_error(const char* msg) {
    fprintf(stderr, "Fatal error: %s\n", msg);
    exit(-1);
}
