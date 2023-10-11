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
ASM_SOURCES = $(SRC_DIR)/ft_strlen.s $(SRC_DIR)/ft_strcpy.s $(SRC_DIR)/ft_strcmp.s $(SRC_DIR)/ft_write.s $(SRC_DIR)/ft_read.s $(SRC_DIR)/ft_strdup.s $(SRC_DIR)/ft_atoi_base_bonus.s $(SRC_DIR)/ft_list_push_front_bonus.s $(SRC_DIR)/ft_list_size_bonus.s $(SRC_DIR)/ft_list_sort_bonus.s $(SRC_DIR)/ft_list_remove_if_bonus.s
C_SOURCES = $(TEST_DIR)/main.c $(TEST_DIR)/func/ft_atoi_base.c $(TEST_DIR)/func/ft_list_push_front.c $(TEST_DIR)/func/ft_list_remove_if.c $(TEST_DIR)/func/ft_list_size.c $(TEST_DIR)/func/ft_list_sort.c
# List of object files
ASM_OBJECTS = $(patsubst $(SRC_DIR)/%.s, $(BUILD_DIR)/%.o, $(ASM_SOURCES))
C_OBJECTS = $(patsubst $(TEST_DIR)/%.c, $(BUILD_DIR)/%.o, $(C_SOURCES))

mkdir = mkdir -p $(BIN_DIR) $(BUILD_DIR) $(BUILD_DIR)/func

# Default rule
all: $(NAME) $(test)

# Rule to link the final executable
$(NAME): $(ASM_OBJECTS)
	ar rc ${NAME} ${ASM_OBJECTS}

# Rule to assemble assembly files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.s
	$(mkdir)
	$(ASM) $(ASM_FLAGS) $< -o $@

# Rule to compile C files
$(BUILD_DIR)/%.o: $(TEST_DIR)/%.c
	$(mkdir)
	$(CC) $(CFLAGS) -c $< -o $@

# Clean intermediate object files
clean:
	rm -f $(BUILD_DIR)/*.o
	rm -rf $(BUILD_DIR)

# Clean all generated files
fclean: clean
	rm -f $(NAME)
	rm -rf $(BIN_DIR) $(BUILD_DIR)

# Rebuild the project
re: fclean all

bonus:			$(NAME)

# Rule for running tests (modify as needed)
$(test): $(NAME) $(C_OBJECTS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(C_OBJECTS) -o $(test) -L. -lasm
