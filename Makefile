
compile: all shell
	

shell: shell.o
	gcc shell.o -o shell

shell.o: shell.s
	gcc -c shell.s

shell.s: shell.i
	gcc -S shell.i

shell.i: shell.c
	gcc -E shell.c -o shell.i

run: all shell
	./shell

all: LS.c CAT.c DATE.c RM.c MKDIR.c
	gcc LS.c -o LS
	gcc CAT.c -o CAT
	gcc DATE.c -o DATE
	gcc RM.c -o RM
	gcc MKDIR.c -o MKDIR
	

clean:
	cp shell.c temp.c
	rm shell*
	cp temp.c shell.c
	rm temp.c
