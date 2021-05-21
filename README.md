# Continuous Integration sample for embedded system

組み込みシステムにおける継続的インテグレーション(CI)構築のサンプルコードです。

継続的インテグレーションについては、Web上に詳しく説明した資料が多数ありますので、そちらを参照して下さい。
組み込みにおけるCIについては、私のブログにて説明しています。
https://iot-entrance.blog.jp/archives/8718967.html

サンプルではArduino UNO用のソフトウェアを構築しています。
ただし、実動作部分はほとんど何も実装していません。
実装しているのは主にmakefileとJenkinsスクリプトになります。

CIツールはOSSのJenkinsを使用しています。
ジョブはスクリプトファイル化しているので、Jenkins UI上ではこれらのファイルを呼び出す動作のみを行います。

# FLOW

![Flow](doc/flow.png)

# Features

このCIシステムでは下記が行えます。
ソースコードとテストコードはトップレベルで分離されています。

* コミットトリガによるJenkinsジョブの起動。
* Jenkinsジョブによる下記の各処理の実行
    * ビルド
    * ユニットテスト
    * カバレッジ測定
    * 開発機へのインストール
* ジョブ失敗時、slackにて開発者へリアルタイムにフィードバック。

## ディレクトリ構成

括弧`()`が付与されたファイル・ディレクトリは、ビルド・テスト・Jenkinsジョブ起動後などに生成されることを表します。
GitHub上のファイルには含まれていません。

```
+ embedded_ci
   + .vscode ... VSCodeの設定。
   |  + launch.json ... 実行用コマンドを記述。ビルド・転送を行う。
   |  + tasks.json ... ビルド単体用のコマンドと、テスト用コマンドを記述。
   + doc ... README.md用の画像ファイルを配置。
   + jenkins
   |  + script
   |  |  + build.sh ... ビルド単体を行うシェルスクリプト。
   |  |  + install.sh ... Arduinoへのプロダクトコードの転送を行うシェルスクリプト。
   |  |  + test.sh ... 単体テストとカバレッジ測定を実行するシェルスクリプト。
   |  |  + pipeline.groovy ... Jenkinsパイプライン用のスクリプト(*1)。
   |  + (work) ... Jenkinsでビルド・テストを行う際のワークディレクトリ(*2)
   |     + (build) ... buildジョブ用ワークスペース。
   |     + (install) ... installジョブ用ワークスペース。
   |     + (test) ... testジョブ用ワークスペース。
   + modules ... プロダクトコードが格納されたディレクトリ。モジュール別に分離されている。
   |  + Led ... LED制御モジュールのディレクトリ。
   |  |  + include ... プロダクトコード用のヘッダファイル。
   |  |  |  + led.h
   |  |  + (lib) ... ビルドするとLedモジュールの静的ライブラリが生成される。
   |  |  |  + (libLed.a)
   |  |  + (obj) ... ビルド用一時ファイルを格納するディレクトリ。
   |  |  |  + (led.o)
   |  |  + src .. プロダクトコードのソースファイル。
   |  |     + led.c
   |  + Makefile ... 下位ディレクトリのmakeを再帰的に呼び出してHEXファイルを生成する。
   |  + main.c ... プロダクトコード用のmain()関数のあるソースファイル。
   + test ... テスト・カバレッジ測定用のコードが格納されたディレクトリ。
   |  + Led ... 同名のプロダクトコードのテスト用コードが格納されたディレクトリ。
   |  |  + (exe) ... テスト実行用のexeファイルが格納されるディレクトリ。
   |  |  |  + (TestLed.exe)
   |  |  + include ... mock対象のヘッダが格納されたディレクトリ。
   |  |  |  + avr
   |  |  |     + io.h .. "avr/io.h"のモック用ヘッダ。
   |  |  + src ... テストコードと、mockコードが格納されたディレクトリ。
   |  |  |  + io.c ... "avr/io.h"のモックコード。
   |  |  |  + main.c ... テストプログラムのエントリポイントが含まれるファイル。
   |  |  |  + test_led.c ... Testモジュールのテストコード。
   |  |  + Makefile ... このモジュールの単体テストとカバレッジ測定を行うMakefile。
   |  + definitions_project.mk ... プロジェクト共通設定が記載されたMakefile。
   |  + definitions_test_build_tools.mk ... テスト用のビルド設定が記載されたMakefile。
   |  + definitions_test_framework.mk ... テストフレームワーク(CppUTest)に関する設定。
   |  + Makefile ... 下位ディレクトリのmakeを再帰的に呼び出して全テストを実行する。
   + (output) ... Arduinoに転送するHEXファイルと、それの生成元のELFファイルが含まれる。
   |  + (arduino.elf)
   |  + (arduino.hex)
   + .gitignore ... 一時ファイルを追跡しないようにするGit用設定ファイル。
   + Makefile ... プロダクト全体のビルド・テスト・転送を実行するMakefile。
   + README.md ... 説明書ファイル(今見ているもの)。
```

- (*1)... build.sh, install.sh, test.shを呼び出すJenkinsジョブを起動するスクリプトです。
- (*2)... build.sh, install.sh, test.shを実行すると生成されます。このディレクトリは作業用の一時ファイルが格納されているディレクトリであり、.gitignoreに登録してありますのでGitHub上にはありません。

プロダクトコードのビルドは、makefileによりモジュールごとに独立して行われます。
これにより、変更されていないモジュールのビルドは省略され、ビルド時間が短縮されます。
一方で、単体テストについては、常にすべてのテストコードが実行されます。
また、モジュール単位でのビルド・テストも可能になっています。

# Requirement

* Platform
    * [Arduino UNO](https://www.arduino.cc/) ... 開発マシン。プロダクトコードをこの上で動作させる。
    * Windows 10 ... ビルドマシン。プロダクトコードのコンパイル・転送と、単体テストを実行する。
* CI tools
    * [Jenkins](https://www.jenkins.io/) ... CIツール。ビルド・単体テストなどの各フェーズをジョブとして表現する。
        * Slack notification plugin ... JenkinsからSlackにジョブの失敗を通知する。
    * [Git 2.27.0.windows.1](https://git-scm.com/) ... コミットフックの土台として利用。
        * Git Bash 4.4.23 ... Windows上でシェルスクリプトを動作させる土台として使用。
    * [Slack](https://slack.com/intl/ja-jp/) ... ジョブ失敗をここに通知
* Build tools
    * [GNU make 3.81](http://gnuwin32.sourceforge.net/packages/make.htm) ... ビルド・単体テスト・カバレッジ測定のコマンドを実行させる。
    * [Arduino IDE](https://www.arduino.cc/en/software)
        * avr-gcc ... AVRマイコン用のCクロスコンパイラ。Arduino IDEに付属。
        * avr-ar ... スタティックライブラリを生成するために利用。Arduino IDEに付属。
        * avr-objcopy ... ELFファイルからHEXファイルに変換する。Arduino IDEに付属。
        * avrdude ... HEXファイルをArduinoに転送する。Arduino IDEに付属。
    * [MinGW](http://mingw-w64.org/doku.php) ... Windows用のC言語/C++言語用コンパイラ。
        * g++ 8.1.0 ... Windows上でArduino用コードの単体テストを実行するために利用。カバレッジ測定用のプログラムを埋め込むこともできる。
        * gcov ... カバレッジ測定用ツール。
* Test tools
    * [CppUTest 3.8](http://cpputest.github.io/) ... C言語/C++言語用テストフレームワーク。テスト時、プロダクトコードにリンクして使用する。
    * [bc 1.06](http://gnuwin32.sourceforge.net/packages/bc.htm) ... カバレッジ測定結果を抽出する動作の一部に利用。

# Installation

準備中。
ブログにて記事を掲載する予定。

# Usage

準備中。
ブログにて記事を掲載する予定。

# Note

Windows上でCUIベースビルドを実現するためには色々と準備が必要なのでやや敷居が高いかもしれません。

# Author

不明点は下記までどうぞ。

* 作成者 : BARANCE
* Twitter : https://twitter.com/BARANCE_TW

# License

[MIT license](https://en.wikipedia.org/wiki/MIT_License).