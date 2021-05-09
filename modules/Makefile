# Project settings

PROJECT_ROOT_DIR = ${CURDIR}/..
MODULES_DIR = ${PROJECT_ROOT_DIR}/modules

# Target module for compilation
MODULES :=\
Led\

# Include directories (Additional)
INCLUDES=

# Library files (Additional)
LIBRARIES =

LIBRARY_FILES =

# Source files (main.c and additional)
SRCS =\
${MODULES_DIR}/main.c\

# Output files
OUTPUT_DIR = ${PROJECT_ROOT_DIR}/output

ELF_FILE = ${OUTPUT_DIR}/arduino.elf
HEX_FILE = ${OUTPUT_DIR}/arduino.hex

# ==== Tool settings ====
# Settings - avr-gcc
COMMAND_COMPILER = avr-gcc
MCU_TYPE = atmega328p

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
${ELF_FILE}: ${SRCS} ${MODULES}
	mkdir -p ${OUTPUT_DIR}

${MODULES}:
	${MAKE} --directory=$@
	${COMMAND_COMPILER} ${COMPILER_FLAGS} -I ${MODULES_DIR}/${@}/include ${INCLUDES} ${SRCS} -o ${ELF_FILE} -L ${MODULES_DIR}/${@}/lib ${LIBRARIES} -l${@} ${LIBRARY_FILES}

# Delete all hex and elf files.
clean:
	for MODULE in ${MODULES};\
	do \
		${MAKE} --directory=$${MODULE} clean;\
	done
	-$(RM) ${HEX_FILE}
	-$(RM) ${ELF_FILE}