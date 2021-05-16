# Project settings
PROJECT_ROOT_DIR = $(CURDIR)/..
MODULES_DIR = $(PROJECT_ROOT_DIR)/modules
TEST_DIR = $(CURDIR)

# Target module for comipilation
MODULES :=\
Led\

# Include directories
INCLUDE_DIR =\
$(addsuffix /include, $(addprefix $(MODULES_DIR)/, $(MODULES)))\
$(addsuffix /include, $(addprefix $(TEST_DIR)/, $(MODULES)))\

INCLUDES =\
$(addprefix -I , $(INCLUDE_DIR))\
-I "/c/Program Files (x86)/CppUTest/include"\

# Library files
LIBRARY_DIR =\
$(addsuffix /lib, $(addprefix $(TEST_DIR)/, $(MODULES)))\

LIBRARY_FILES =\
$(addprefix Test, $(MODULES))\
CppUTest\
pthread\

LIBRARIES =\
$(addprefix -L , $(LIBRARY_DIR))\
-L "/c/Program Files (x86)/CppUTest/lib"\
$(addprefix -l, $(LIBRARY_FILES))\

# Source files
SOURCE_DIR = $(TEST_DIR)

SOURCE_FILES =\
$(wildcard $(SOURCE_DIR)/*.c)\

# Output files
OUTPUT_DIR = ${TEST_DIR}/output

EXE_FILE = ${OUTPUT_DIR}/test.exe

# ==== Tool settings ====
# Settings - g++
COMPILER = g++
COMPILER_FLAGS = -g

# ==== Make Targets ====

all: $(EXE_FILE)

test: $(EXE_FILE)
	$(EXE_FILE)

# Generate Exe file
.PHONY: ${MODULES}
${EXE_FILE}: ${SOURCE_FILES} ${MODULES}

${MODULES}:
	$(MAKE) --directory=$@
	mkdir -p ${OUTPUT_DIR}
	$(COMPILER) $(COMPILER_FLAGS) $(INCLUDES) -o $(EXE_FILE) $(SOURCE_FILES) $(LIBRARIES)
	
clean:
	for MODULE in ${MODULES};\
	do \
		${MAKE} --directory=$${MODULE} clean;\
	done
	-rm ${EXE_FILE}