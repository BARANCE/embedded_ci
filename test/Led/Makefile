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

# Source files
MAIN_SOURCE_DIR = ${MAIN_MODULE_DIR}/src
MAIN_SOURCE_FILES =\
$(wildcard $(MAIN_SOURCE_DIR)/*.c)\

TEST_SOURCE_DIR = ${TEST_MODULE_DIR}/src
TEST_SOURCE_FILES =\
$(wildcard $(TEST_SOURCE_DIR)/*.c)\

# Output object file
OBJECT_DIR = ${TEST_MODULE_DIR}/obj
OBJECT_FILES =\
$(addprefix $(OBJECT_DIR)/, $(notdir $(MAIN_SOURCE_FILES:.c=.o)))\
$(addprefix $(OBJECT_DIR)/, $(notdir $(TEST_SOURCE_FILES:.c=.o)))\

DEPEND_FILES = $(OBJECT_FILES:.o=.d)

# Output library file
TARGET_DIR = $(TEST_MODULE_DIR)/lib
TARGET = $(TARGET_DIR)/libTest${CURRENT_MODULE_NAME}.a

# ==== Tool settings ====
# Settings - g++
COMPILER = g++
COMPILER_FLAGS = -g -c

# Settings - ar
COMMAND_AR = ar
AR_FLAGS = r

# ==== Make targets ====

$(TARGET): $(OBJECT_FILES)
	@mkdir -p $(TARGET_DIR)
	$(COMMAND_AR) $(AR_FLAGS) $(TARGET) $(OBJECT_FILES)

$(OBJECT_DIR)/%.o: $(MAIN_SOURCE_DIR)/%.c
	@mkdir -p $(OBJECT_DIR)
	$(COMPILER) $(COMPILER_FLAGS) $(INCLUDES) -o $@ -c $^ $(LIBRARIES)

$(OBJECT_DIR)/%.o: $(TEST_SOURCE_DIR)/%.c
	@mkdir -p $(OBJECT_DIR)
	$(COMPILER) $(COMPILER_FLAGS) $(INCLUDES) -o $@ -c $^ $(LIBRARIES)


all: $(TARGET)

clean:
	-rm ${OBJECT_FILES}
	-rm ${TARGET}