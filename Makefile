
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

all: LS/LS.c CAT/CAT.c DATE/DATE.c RM/RM.c MKDIR/MKDIR.c
	gcc LS/LS.c -o LS/LS
	gcc CAT/CAT.c -o CAT/CAT
	gcc DATE/DATE.c -o DATE/DATE
	gcc RM/RM.c -o RM/RM
	gcc MKDIR/MKDIR.c -o MKDIR/MKDIR
	

clean:
	cp shell.c temp.c
	rm shell*
	cp temp.c shell.c
	rm temp.c
