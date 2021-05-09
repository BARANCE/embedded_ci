# ==== Source/Destination files/directories ===

# Global
PROJECT_ROOT_DIR = ${CURDIR}
MODULES_DIR = ${PROJECT_ROOT_DIR}/modules
TEST_DIR = ${PROJECT_ROOT_DIR}/test

# Output files
OUTPUT_DIR = ${PROJECT_ROOT_DIR}/output

HEX_FILE = ${OUTPUT_DIR}/arduino.hex

# ==== Tool settings ====

# Settings - avrdude
AVRDUDE_CONF_PATH = C:\\arduino-1.8.13\\hardware\\tools\\avr\\etc\\avrdude.conf
MCU_TYPE = atmega328p
PROGRAMMER_ID = arduino
PORT = COM3
BAUD_RATE = 115200
MEMORY_TYPE = flash
OPERATION = w
FILE_FORMAT = i
MEMORY_OPERATION = ${MEMORY_TYPE}:${OPERATION}:${HEX_FILE}:${FILE_FORMAT}

# ==== MAKE Targets ====

# Build hex file to run programs on arduino.
.PHONY: all
all ${HEX_FILE}:
	${MAKE} --directory=${MODULES_DIR} all

# Install hex file to arduino board
install: ${HEX_FILE}
	avrdude -C ${AVRDUDE_CONF_PATH} -v -p ${MCU_TYPE} -c ${PROGRAMMER_ID} -P ${PORT} -b ${BAUD_RATE} -D -U ${MEMORY_OPERATION}

# Execute unittest on building machine.
.PHONY: test
test:
	${MAKE} --directory=${TEST_DIR} test

# Delete all output files such as hex, elf, exe.
clean:
	${MAKE} --directory=${MODULES_DIR} $@
	${MAKE} --directory=${TEST_DIR} $@
