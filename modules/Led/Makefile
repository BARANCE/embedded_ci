CURRENT_MODULE_NAME = $(shell basename `readlink -f $(CURDIR)`)

MODULES_DIR = ..
MODULE_DIR = ${MODULES_DIR}/${CURRENT_MODULE_NAME}

# Include file
INCLUDE_DIR = ${MODULE_DIR}/include

INCLUDES=\
$(addprefix -I , $(INCLUDE_DIR))\

# External libraries
LIBRARY_DIR =
LIBRARY_FILES =
LIBRARIES =

# Source files
SOURCE_DIR = ${MODULE_DIR}/src

SOURCE_FILES =\
$(wildcard $(SOURCE_DIR)/*.c)\

# Output object files
OBJECT_DIR = ${MODULE_DIR}/obj
OBJECT_FILES =\
$(addprefix $(OBJECT_DIR)/, $(notdir $(SOURCE_FILES:.c=.o)))\

DEPEND_FILES = $(OBJECT_FILES:.o=.d)

# Output library files
TARGET_DIR = $(MODULE_DIR)/lib
TARGET = $(TARGET_DIR)/lib$(CURRENT_MODULE_NAME).a

# ==== Tool settings ====
# Settings - avr-gcc
COMPILER = avr-gcc
MCU_TYPE = atmega328p

# Generate object files to archive library.
COMPILER_FLAGS = -g -mmcu=${MCU_TYPE} -c

# Settings - avr-ar
COMMAND_AR = avr-ar
AR_FLAGS = r

# ==== MAKE Targets ====

# Generate all files, but not install

$(TARGET): $(OBJECT_FILES)
	@mkdir -p $(TARGET_DIR)
	$(COMMAND_AR) $(AR_FLAGS) $(TARGET) $(OBJECT_FILES)

$(OBJECT_DIR)/%.o: $(SOURCE_DIR)/%.c
	@mkdir -p $(OBJECT_DIR)
	$(COMPILER) $(COMPILER_FLAGS) $(INCLUDES) $(LIBRARIES) -o $@ -c $^

all: $(TARGET)

clean:
	-rm ${OBJECT_FILES}
	-rm ${TARGET}