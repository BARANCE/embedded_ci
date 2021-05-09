# Project settings

PROJECT_ROOT_DIR = $(CURDIR)/..
MODULES_DIR = $(CURDIR)

# Target module for compilation
MODULES :=\
Led\

# Include directories (Additional)
INCLUDE_DIR =\
$(addsuffix /include, $(addprefix $(MODULES_DIR)/, $(MODULES)))

INCLUDES =\
$(addprefix -I , $(INCLUDE_DIR))\

# Library files (Additional)
LIBRARY_DIR =\
$(addsuffix /lib, $(addprefix $(MODULES_DIR)/, $(MODULES)))

LIBRARY_FILES = $(MODULES)

LIBRARIES =\
$(addprefix -L , $(LIBRARY_DIR))\
$(addprefix -l, $(LIBRARY_FILES))\

# Source files (main.c and additional)
SOURCE_DIR = $(MODULES_DIR)

SOURCE_FILES =\
$(wildcard $(SOURCE_DIR)/*.c)\

# Output files
OUTPUT_DIR = ${PROJECT_ROOT_DIR}/output

ELF_FILE = ${OUTPUT_DIR}/arduino.elf
HEX_FILE = ${OUTPUT_DIR}/arduino.hex

# ==== Tool settings ====
# Settings - avr-gcc
COMPILER = avr-gcc
MCU_TYPE = atmega328p

# Generate object files to archive library.
COMPILER_FLAGS = -g -mmcu=${MCU_TYPE}

# Settings - avr-objcopy
COMMAND_OBJCOPY = avr-objcopy
# Supported target format is shown by 'avr-objcopy --help'.
INPUT_TARGET_FORMAT = elf32-avr
OUTPUT_TARGET_FORMAT = ihex

OBJCOPY_FLAGS = -I ${INPUT_TARGET_FORMAT} -O ${OUTPUT_TARGET_FORMAT}

# ==== MAKE Targets ====

# Generate all files, but not install
all: ${HEX_FILE}

# Generate hex file
${HEX_FILE}: ${ELF_FILE}
	${COMMAND_OBJCOPY} ${OBJCOPY_FLAGS} ${ELF_FILE} ${HEX_FILE}

# Generate elf file
.PHONY: ${MODULES}
${ELF_FILE}: ${SOURCE_FILES} ${MODULES}

${MODULES}:
	$(MAKE) --directory=$@
	mkdir -p ${OUTPUT_DIR}
	$(COMPILER) $(COMPILER_FLAGS) ${INCLUDES} ${LIBRARIES} -o ${ELF_FILE} ${SOURCE_FILES}

# Delete all hex and elf files.
clean:
	for MODULE in ${MODULES};\
	do \
		${MAKE} --directory=$${MODULE} clean;\
	done
	-$(RM) ${HEX_FILE}
	-$(RM) ${ELF_FILE}