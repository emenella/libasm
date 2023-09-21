# Compiler and linker options
CC = gcc
ASM = nasm
ASM_FLAGS = -felf64
CFLAGS = -Wall -Wextra -Werror
LDFLAGS = -fPIE

# Folders
SRC_DIR = srcs
TEST_DIR = test
BUILD_DIR = build
BIN_DIR = bin

# Output binary name
test = $(BIN_DIR)/test
NAME = libasm.a

# List of source files
ASM_SOURCES = $(wildcard $(SRC_DIR)/*.s)
C_SOURCES = $(TEST_DIR)/main.c $(TEST_DIR)/test_atoi_base.c
# List of object files
ASM_OBJECTS = $(patsubst $(SRC_DIR)/%.s, $(BUILD_DIR)/%.o, $(ASM_SOURCES))
C_OBJECTS = $(patsubst $(TEST_DIR)/%.c, $(BUILD_DIR)/%.o, $(C_SOURCES))

# Default rule
all: $(NAME)

# Rule to link the final executable
$(NAME): $(ASM_OBJECTS)
	ar rc ${NAME} ${ASM_OBJECTS}

# Rule to assemble assembly files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.s
	$(ASM) $(ASM_FLAGS) $< -o $@

# Rule to compile C files
$(BUILD_DIR)/%.o: $(TEST_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean intermediate object files
clean:
	rm -f $(BUILD_DIR)/*.o

# Clean all generated files
fclean: clean
	rm -f $(NAME)

# Rebuild the project
re: fclean all

bonus:			$(NAME)

# Rule for running tests (modify as needed)
test: $(NAME) $(C_OBJECTS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(C_OBJECTS) -o $(test) -L. -lasm
	./$(test)
