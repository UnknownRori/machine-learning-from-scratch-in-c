CC = gcc
FLAG = -Wall -Werror -Wconversion -Wundef -Wshadow -Wdouble-promotion -fno-common -Wformat=2
DEBUG = -g -DDEBUG -DCOLORED -fstack-usage

TEMP = temp
DIST = dist
TEST = tests
SRC  = src

MATRIX_SRC = ./$(SRC)/matrix.c
MATRIX_OUT = ./$(TEMP)/matrix.o
NEURAL_NETWORK_SRC = ./$(SRC)/neural_network.c
NEURAL_NETWORK_OUT = ./$(TEMP)/nn.o

NNLIBS_A = ./$(DIST)/libnn.a
NNLIBS = -lnn

MAIN_SRC = ./main.c
MAIN_OUT = ./temp/main.o

LIBS_OUT = -L./$(DIST)

setup:
	([ ! -e ./$(DIST) ] && mkdir $(DIST)) || [ -e ./$(DIST) ]
	([ ! -e ./$(TEMP) ] && mkdir $(TEMP)) || [ -e ./$(TEMP) ]

clean: setup
	rm -r ./$(TEMP)
	rm -r ./$(DIST)

run: build
	./$(MAIN_OUT)

build: build-libs
	$(CC) -o $(MAIN_OUT) $(MAIN_SRC) $(LIBS_OUT) $(NNLIBS)

build-libs: setup
	$(CC) -c -o $(MATRIX_OUT) $(MATRIX_SRC) $(FLAG)
	$(CC) -c -o $(NEURAL_NETWORK_OUT) $(NEURAL_NETWORK_SRC) $(FLAG)
	ar rcs $(NNLIBS_A) $(MATRIX_OUT) $(NEURAL_NETWORK_OUT)
