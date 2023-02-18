TEST_FLAGS = -g -Wall -std=c11


test:
	clang -Iinclude ${TEST_FLAGS} src/*.c test/test.c -o test.out
	./test.out
.PHONY: test clean
clean:
	rm -r *.out *.dSYM
