stencil: stencil.c
	gcc -O3 -std=c99 -Wall $^ -o $@

