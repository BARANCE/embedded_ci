# プロジェクトの基準ディレクトリに関する変数を設定する.
# $1: プロジェクトの基準ディレクトリのパス
define define_project_directory
$(eval PROJECT_DIR := $1)\
$(eval MODULES_DIR := $1/modules)\
$(eval TEST_DIR := $1/test)
endef