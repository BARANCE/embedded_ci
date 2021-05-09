CURRENT_MODULE_NAME = $(shell basename `readlink -f $(CURDIR)`)

MODULES_DIR = ${TEST_DIR}/../modules
MAIN_MODULE_DIR = ${MODULES_DIR}/${CURRENT_MODULE_NAME}

TEST_DIR = ${CURDIR}/..
TEST_MODULE_DIR = ${TEST_DIR}/${CURRENT_MODULE_NAME}

# Include file
MAIN_INCLUDE_DIR = ${MAIN_MODULE_DIR}/include
TEST_INCLUDE_DIR = ${TEST_MODULE_DIR}/include

INCLUDES =\
$(addprefix -I , $(MAIN_INCLUDE_DIR))\
$(addprefix -I , $(TEST_INCLUDE_DIR))\
-I "/c/Program Files (x86)/CppUTest/include"\

# External libraries
LIBRARY_DIR =\
"/c/Program Files (x86)/CppUTest/lib"\

LIBRARY_FILES =\
CppUTest\
pthread\

LIBRARIES =\
-L "/c/Program Files (x86)/CppUTest/lib"\
$(addprefix -l, $(LIBRARY_FILES))\

# Source file
MAIN_SOURCE_DIR = ${MAIN_MODULE_DIR}/src
MAIN_SOURCE_FILES =\
$(wildcard $(MAIN_SOURCE_DIR)/*.c)\

TEST_SOURCE_DIR = ${TEST_MODULE_DIR}/src
TEST_SOURCE_FILES =\
$(wildcard $(TEST_SOURCE_DIR)/*.c)\

# Output object file
OBJECT_DIR = ${CURDIR}/obj
OBJECT_FILES =\
$(addprefix $(OBJECT_DIR)/, $(notdir $(MAIN_SOURCE_FILES:.c=.o)))\
$(addprefix $(OBJECT_DIR)/, $(notdir $(TEST_SOURCE_FILES:.c=.o)))\

DEPEND_FILES = $(OBJECT_FILES:.o=.d)

# Output library file
TARGET_DIR = $(TEST_MODULE_DIR)/lib
TARGET = $(TARGET_DIR)/libTest${CURRENT_MODULE_NAME}.a

COMPILER = g++
COMPILER_FLAGS = -g -c -Wall -Wextra -Os

$(TARGET): $(OBJECT_FILES)
	@mkdir -p $(TARGET_DIR)
	ar r $(TARGET) $(OBJECT_FILES)

$(OBJECT_DIR)/%.o: $(MAIN_SOURCE_DIR)/%.c
	@mkdir -p $(OBJECT_DIR)
	$(COMPILER) $(COMPILER_FLAGS) $(INCLUDES) $(LIBRARIES) -o $@ -c $^

$(OBJECT_DIR)/%.o: $(TEST_SOURCE_DIR)/%.c
	@mkdir -p $(OBJECT_DIR)
	$(COMPILER) $(COMPILER_FLAGS) $(INCLUDES) $(LIBRARIES) -o $@ -c $^


all: $(TARGET)

clean:
	-rm ${OBJECT_FILES}
	-rm ${TARGET}