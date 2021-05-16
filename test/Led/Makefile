# テストフレームワークのヘッダ・ライブラリの共通情報を読み込む
# 次の変数を設定:
# $(TF_INCLUDE) : テストフレームワークのインクルードディレクトリ
# $(TF_LIBRARIES) : テストフレームワークのライブラリ設定
include $(CURDIR)/../definitions_test_framework.mk

# テスト用ビルドツールに関する共通設定を読み込む.
# 次の変数を設定:
# - $(COMPILER) : コンパイラプログラムのコマンド
# - $(COMPILER_FLAGS) : コンパイラプログラムに渡す標準的なフラグ
include $(CURDIR)/../definitions_test_build_tools.mk

# プロジェクトに関する共通設定を読み込む
# 次の変数を設定:
# - $(PROJECT_DIR) : プロジェクトのトップレベルディレクトリ
# - $(MODULES_DIR) : 本体にロードするプログラムソースの基準ディレクトリ
# - $(TEST_DIR) : テスト用プログラムソースの基準ディレクトリ
include $(CURDIR)/../definitions_project.mk
$(call define_project_directory,$(CURDIR)/../..)

# === Module definition ====

CURRENT_MODULE_NAME = $(shell basename `readlink -f $(CURDIR)`)

MAIN_MODULE_DIR = ${MODULES_DIR}/${CURRENT_MODULE_NAME}
TEST_MODULE_DIR = ${TEST_DIR}/${CURRENT_MODULE_NAME}

COVERAGE_TARGET_RATE = 80.0

# ==== Input ====

# Include file
MAIN_INCLUDE_DIR = ${MAIN_MODULE_DIR}/include
TEST_INCLUDE_DIR = ${TEST_MODULE_DIR}/include

INCLUDES =\
$(addprefix -I , $(MAIN_INCLUDE_DIR))\
$(addprefix -I , $(TEST_INCLUDE_DIR))\
$(TF_INCLUDE)\

# External libraries
LIBRARY_DIR =
LIBRARY_FILES =
LIBRARIES =\
$(TF_LIBRARIES)

# Source files
MAIN_SOURCE_DIR = ${MAIN_MODULE_DIR}/src
MAIN_SOURCE_FILES =\
$(wildcard $(MAIN_SOURCE_DIR)/*.c)\

TEST_SOURCE_DIR = ${TEST_MODULE_DIR}/src
TEST_SOURCE_FILES =\
$(wildcard $(TEST_SOURCE_DIR)/*.c)\

SOURCE_FILES = $(MAIN_SOURCE_FILES) $(TEST_SOURCE_FILES)

# ==== Output ====

# Output EXE file
EXE_DIR = $(TEST_MODULE_DIR)/exe
EXE_FILE = $(EXE_DIR)/Test$(CURRENT_MODULE_NAME).exe

# Temporary files for measuring coverage
GCNO_FILES = $(addprefix $(TEST_MODULE_DIR)/, $(notdir $(SOURCE_FILES:.c=.gcno)))
GCDA_FILES = $(addprefix $(TEST_MODULE_DIR)/, $(notdir $(SOURCE_FILES:.c=.gcda)))
TARGET_GCDA_FILES = $(addprefix $(TEST_MODULE_DIR)/, $(notdir $(MAIN_SOURCE_FILES:.c=.gcda)))
GCOV_FILES = $(addsuffix .gcov, $(addprefix $(TEST_MODULE_DIR)/, $(notdir $(MAIN_SOURCE_FILES))))

# gcov result file
GCOV_RESULT_FILES = $(addprefix $(TEST_MODULE_DIR)/, $(notdir $(MAIN_SOURCE_FILES:.c=.gresult)))

# Dummy output target for executing 'test' command
COVERAGE_RESULT_DUMMY = $(addprefix $(TEST_MODULE_DIR)/, $(notdir $(MAIN_SOURCE_FILES:.c=.dummy)))

# ==== Build target ====

$(EXE_FILE) $(GCNO_FILES): $(MAIN_SOURCE_FILES) $(TEST_SOURCE_FILES)
	@mkdir -p $(EXE_DIR)
	$(COMPILER) $(COMPILER_FLAGS) $(INCLUDES) -o $(EXE_FILE) $(SOURCE_FILES) $(LIBRARIES)

.PHONY: $(GCDA_FILES)
$(GCDA_FILES): $(GCNO_FILES) $(EXE_FILE)
	$(EXE_FILE)

%.gresult: %.gcda
	gcov $^ > $@

# '.dummy' file is dummy. It's not created.
# This target is prepared to execute 'test' command every result files.
%.dummy: %.gresult
	test $(shell echo "$(shell grep -o -E [0-9]+\.[0-9]+ $^) >= $(COVERAGE_TARGET_RATE)" | bc) -eq 1

all: $(EXE_FILE)

# 'COBERAGE_RESULT_DUMMY' is dummy target. It's not created.
.PHONY: test
test: $(EXE_FILE)
	$(EXE_FILE)

coverage: $(COVERAGE_RESULT_DUMMY) $(GCOV_RESULT_FILES)

clean:
	-rm $(EXE_FILE)
	-rm $(GCNO_FILES)
	-rm $(GCDA_FILES)
	-rm $(GCOV_FILES)
	-rm $(GCOV_RESULT_FILES)

