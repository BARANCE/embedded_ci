
# ==== Definitions for Test Framework ====

# Inlude
TF_INCLUDE_DIR = "c:/Program Files (x86)/CppUTest/include"
TF_INCLUDE = -I ${TF_INCLUDE_DIR}

# Libraries
TF_LIBRARY_DIR = "c:/Program Files (x86)/CppUTest/lib"
TF_LIBRARY_FILES =\
CppUTest\
pthread\

TF_LIBRARIES =\
-L $(TF_LIBRARY_DIR)\
$(addprefix -l, $(TF_LIBRARY_FILES))