# paths
INCLUDE = include
MODULES = modules
PROGRAM = program 
MISC = misc

# compiler
CC = gcc

# Compile options. Το -I<dir> λέει στον compiler να αναζητήσει εκεί include files
CFLAGS = -Wall  -g -I$(INCLUDE)
LDFLAGS = -lm

# Αρχεία .o
OBJS1 = $(MODULES)/HP.o $(MISC)/BF_64.a program/HP_main.o
OBJS2 = $(MODULES)/HT.o $(MISC)/BF_64.a program/HT_main.o

# Το εκτελέσιμο πρόγραμμα
EXEC1 = HP_main
EXEC2 = HT_main

# Παράμετροι για δοκιμαστική εκτέλεση
ARGS =

$(EXEC1) $(EXEC2): $(OBJS1) $(OBJS2)
	$(CC) $(OBJS1) -o $(EXEC1) -no-pie
	$(CC) $(OBJS2) -o $(EXEC2) -no-pie


clean:
	rm -f $(EXEC1) $(EXEC2) $(filter-out $(MISC)/BF_64.a,$(OBJS))
	rm -f file*


valgrind: $(EXEC1) $(EXEC2)
	valgrind --leak-check=full ./$(EXEC1)
	# valgrind --leak-check=full --show-leak-kinds=all ./$(EXEC2)
