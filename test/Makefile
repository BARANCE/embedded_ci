# Project settings
TEST_DIR = .
PROJECT_ROOT_DIR = ..

# Include directories
INCLUDES =\
-I ${TEST_DIR}/include\
-I ${PROJECT_ROOT_DIR}/include\
-I "/c/Program Files (x86)/CppUTest/include"\

# Library files
LIBRARIES =\
-L "/c/Program Files (x86)/CppUTest/lib"

LIBRARY_FILES =\
-lCppUTest\
-lpthread\

# Source files
MAIN_SOURCE_DIR = ${PROJECT_ROOT_DIR}/src
TEST_SOURCE_DIR = ${TEST_DIR}/src
MOCK_SOURCE_DIR = ${TEST_DIR}/mock_src

SRCS = ${MAIN_SOURCE_DIR}/*\
${MOCK_SOURCE_DIR}/*\
${TEST_SOURCE_DIR}/*\
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