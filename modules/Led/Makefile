
MODULES_DIR = ..

# Include directories
INCLUDES=\
-I ${CURDIR}/include\

# Library files
LIBRARIES =

LIBRARY_FILES =

# Source files
SRCS =\
${CURDIR}/src/led.c

# Output files
OUTPUT_DIR = ${CURDIR}/lib
OBJ_FILE = ${OUTPUT_DIR}/Led.o
LIB_FILE = ${OUTPUT_DIR}/libLed.a

# ==== Tool settings ====
# Settings - avr-gcc
COMMAND_COMPILER = avr-gcc
MCU_TYPE = atmega328p

# Generate object files to archive library.
COMPILER_FLAGS = -g -mmcu=${MCU_TYPE} -c

# Settings - avr-ar
COMMAND_AR = avr-ar
AR_FLAGS = r

# ==== MAKE Targets ====

# Generate all files, but not install
all: ${LIB_FILE}

${LIB_FILE}: ${OBJ_FILE}
	${COMMAND_AR} ${AR_FLAGS} ${LIB_FILE} ${OBJ_FILE}

${OBJ_FILE}: ${SRCS}
	mkdir -p ${OUTPUT_DIR}
	${COMMAND_COMPILER} ${COMPILER_FLAGS} ${INCLUDES} ${SRCS} -o ${OBJ_FILE} ${LIBRARIES} ${LIBRARY_FILES}

clean:
	-rm ${OBJ_FILE}
	-rm ${LIB_FILE}