# Project settings
PROJECT_ROOT_DIR = ${CURDIR}/..
MODULES_DIR = ${PROJECT_ROOT_DIR}/modules
TEST_DIR = ${PROJECT_ROOT_DIR}/test


# Include directories
INCLUDES =\
-I ${TEST_DIR}/Led/include\
-I ${MODULES_DIR}/Led/include\
-I "/c/Program Files (x86)/CppUTest/include"\

# Library files
LIBRARIES =\
-L "/c/Program Files (x86)/CppUTest/lib"

LIBRARY_FILES =\
-lCppUTest\
-lpthread\

# Source files
SRCS =\
${MODULES_DIR}/Led/src/led.c\
${TEST_DIR}/Led/src/test_led.c\
${TEST_DIR}/Led/src/io.c\
${TEST_DIR}/main.c\

# Output files
OUTPUT_DIR = ${TEST_DIR}/output

EXE_FILE = ${OUTPUT_DIR}/test.exe

# For test
all: ${EXE_FILE}

test: ${EXE_FILE}
	${EXE_FILE}

${EXE_FILE}: ${SRCS}
	mkdir -p ${OUTPUT_DIR}
	g++ -g ${INCLUDES} ${SRCS} -o ${EXE_FILE} ${LIBRARIES} ${LIBRARY_FILES}

clean:
	-rm ${EXE_FILE}