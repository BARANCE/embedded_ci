# ==== Shell Command ====
CC := gcc
AVR_CC := avr-gcc
AVR_OBJCOPY := avr-objcopy
AVRDUDE := avrdude

RM := rm

# ==== Source/Destination files/directories ===

# Global
PROJECT_ROOT_DIR = .
TEST_DIR = ${PROJECT_ROOT_DIR}/test

# include files
INCLUDE_FLAG = -I
MAIN_INCLUDE_DIR = ${PROJECT_ROOT_DIR}/include
TEST_INCLUDE_DIR = ${TEST_DIR}/include

MAIN_INCLUDE =\
${INCLUDE_FLAG}${MAIN_INCLUDE_DIR}

TEST_INCLUDE =\
${INCLUDE_FLAG}${TEST_INCLUDE_DIR}\
${INCLUDE_FLAG}"/c/Program Files (x86)/CppUTest/include"\
${INCLUDE_FLAG}${MAIN_INCLUDE_DIR}\

# Source files
SRC_DIR = ${PROJECT_ROOT_DIR}/src
TEST_SRC_DIR = ${TEST_DIR}/src
TEST_MOC_SRC_DIR = ${TEST_DIR}/mock_src

SRCS =\
${SRC_DIR}/led.c

MAIN_SRCS = ${SRCS}\
${SRC_DIR}/main.c

TEST_MOCK_SRCS =\
${TEST_MOC_SRC_DIR}/io.c

TEST_SRCS = ${SRCS}\
${TEST_MOCK_SRCS}\
${TEST_SRC_DIR}/test_led.c\
${TEST_SRC_DIR}/main.c

# Library files
LIBRARY_DIR_FLAG = -L
LIBRARY_FILE_FLAG = -l

MAIN_LIBRARY_DIR =
TEST_LIBRARY_DIR =\
${LIBRARY_DIR_FLAG}"/c/Program Files (x86)/CppUTest/lib"

TEST_LIBRARY_FILES=\
${LIBRARY_FILE_FLAG}CppUTest\
${LIBRARY_FILE_FLAG}pthread

# Output files
MAIN_OUTPUT_DIR = ${PROJECT_ROOT_DIR}/output
TEST_OUTPUT_DIR = ${TEST_DIR}/output

ELF_FILE = ${MAIN_OUTPUT_DIR}/arduino.elf
HEX_FILE = ${MAIN_OUTPUT_DIR}/arduino.hex

TEST_EXE_FILE = ${TEST_OUTPUT_DIR}/test.exe

# ==== Tool settings ====

# Settings - avr-gcc
MCU_TYPE = atmega328p

# Settings - avrdude
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
	$(AVRDUDE) -C ${AVRDUDE_CONF_PATH} -v -p ${MCU_TYPE} -c ${PROGRAMMER_ID} -P ${PORT} -b ${BAUD_RATE} -D -U ${MEMORY_OPERATION}

# Generate elf file
${ELF_FILE}: ${MAIN_SRCS}
	mkdir -p ${MAIN_OUTPUT_DIR}
	$(AVR_CC) -g -mmcu=${MCU_TYPE} ${MAIN_INCLUDE} ${MAIN_SRCS} -o ${ELF_FILE} ${MAIN_LIBRARY_DIR} ${MAIN_LIBRARY_FILES}

# Generate hex file
${HEX_FILE}: ${ELF_FILE}
	$(AVR_OBJCOPY) -I elf32-avr -O ihex ${ELF_FILE} ${HEX_FILE}

# Delete all hex and elf files.
clean:
	-$(RM) ${HEX_FILE}
	-$(RM) ${ELF_FILE}

# For test
debug: ${TEST_EXE_FILE}
	${TEST_EXE_FILE}

${TEST_EXE_FILE}: ${TEST_SRCS}
	mkdir -p ${TEST_OUTPUT_DIR}
	g++ -g ${TEST_INCLUDE} ${TEST_SRCS} -o ${TEST_EXE_FILE} ${TEST_LIBRARY_DIR} ${TEST_LIBRARY_FILES}

dclean:
	-${RM} ${TEST_EXE_FILE}
