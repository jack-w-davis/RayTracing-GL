#---------------------------------FOLDERS-------------------------------------
SRC_DIR = SRC
OBJ_DIR = BIN
INC_DIR = INCLUDE
#-----------------------------BASIC SETTINGS----------------------------------
EXEC := prog
SRC  := $(wildcard $(SRC_DIR)/*.cpp)
OBJ  := $(SRC:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

#------------------------------COMP SETTINGS----------------------------------
CC=g++
CFLAGS= -Wall -Wextra -g
LFLAGS= -lglfw -lGL -lX11 -lpthread -lXrandr -lXi -ldl -I INC_DIR
#---------------------------------RULES---------------------------------------
#The following rule is only used to compile glad, it's not needed for
#a generic makefile

$(EXEC):$(OBJ)
	$(CC) $(CFLAGS) -c /usr/include/glad/glad.c -o $(OBJ_DIR)/glad.o
	$(CC) $^ $(OBJ_DIR)/glad.o -o $@ $(LFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(INC_DIR)/%.h
	$(CC) $(CFLAGS) -c $< -o $@ -I $(INC_DIR)

val:
	valgrind --leak-check=full ./$(EXEC) 

clean:
	rm $(OBJ)
	rm $(EXEC)

-include $(OBJ:.o=.d)