TEST_FLAGS = -g -Wall -std=c11


test:
	clang -Iinclude ${TEST_FLAGS} src/array.c src/util.c test/test.c -o test.out
	./test.out
.PHONY: test clean
clean:
	rm -r *.out *.dSYM
