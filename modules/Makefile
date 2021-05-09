# Project settings

PROJECT_ROOT_DIR = ${CURDIR}/..
MODULES_DIR = ${PROJECT_ROOT_DIR}/modules

# Include directories
INCLUDES=\
-I ${MODULES_DIR}/Led/include\

# Library files
LIBRARIES =

LIBRARY_FILES =

# Source files
SRCS =\
${MODULES_DIR}/Led/src/led.c\
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

# Settings - avrdude
# See: http://www.nongnu.org/avrdude/user-manual/avrdude_4.html#Option-Descriptions
AVRDUDE_CONF_PATH = C:\\arduino-1.8.13\\hardware\\tools\\avr\\etc\\avrdude.conf
PROGRAMMER_ID = arduino
PORT = COM3
BAUD_RATE = 115200

MEMORY_TYPE = flash
OPERATION = w
FILE_FORMAT = i
MEMORY_OPERATION = ${MEMORY_TYPE}:${OPERATION}:${HEX_FILE}:${FILE_FORMAT}

# ==== MAKE Targets ====

# Generate all files, but not install
all: ${HEX_FILE}

# Install hex file to arduino board
install: ${HEX_FILE}
	avrdude -C ${AVRDUDE_CONF_PATH} -v -p ${MCU_TYPE} -c ${PROGRAMMER_ID} -P ${PORT} -b ${BAUD_RATE} -D -U ${MEMORY_OPERATION}

# Generate elf file
${ELF_FILE}: ${SRCS}
	mkdir -p ${OUTPUT_DIR}
	${COMMAND_COMPILER} ${COMPILER_FLAGS} ${INCLUDES} ${SRCS} -o ${ELF_FILE} ${LIBRARIES} ${LIBRARY_FILES}

# Generate hex file
${HEX_FILE}: ${ELF_FILE}
	${COMMAND_OBJCOPY} ${OBJCOPY_FLAGS} ${ELF_FILE} ${HEX_FILE}

# Delete all hex and elf files.
clean:
	-$(RM) ${HEX_FILE}
	-$(RM) ${ELF_FILE}
