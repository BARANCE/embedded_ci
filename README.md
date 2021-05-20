# Continuous Integration sample for embedded system

組み込みシステムにおける継続的インテグレーション(CI)構築のサンプルコードです。

継続的インテグレーションについては、Web上に詳しく説明した資料が多数ありますので、そちらを参照して下さい。
組み込みにおけるCIについては、私のブログにて説明しています。
https://iot-entrance.blog.jp/archives/8718967.html

サンプルではArduino UNO用のソフトウェアを構築しています。
ただし、実動作部分はほとんど何も実装していません。
実装しているのは主にmakefileとJenkinsスクリプトになります。

CIツールはOSSのJenkinsを使用しています。
スクリプトはファイル化しているので、Jenkins UI上のスクリプト欄はこれらのファイルを呼び出す動作のみを行っています。

# DEMO

"hoge"の魅力が直感的に伝えわるデモ動画や図解を載せる

# Features

このCIプラクティスは下記の要素を満たします。
ソースコードとテストコードはトップレベルで分離されています。

* コミットトリガによるテストスイートの起動
* 自動テストの実行
    * ビルド
    * ユニットテスト
    * カバレッジ測定
    * インストール(*1)
* slackによる開発者へのリアルタイムなフィードバック

(*1)...開発機上にソフトウェアを転送することです。今回の場合はArduinoにファームウェアを焼き込むことが相当します。

# Requirement

"hoge"を動かすのに必要なライブラリなどを列挙する

* huga 3.5.2
* hogehuga 1.0.2

# Installation

Requirementで列挙したライブラリなどのインストール方法を説明する

```bash
pip install huga_package
```

# Usage

DEMOの実行方法など、"hoge"の基本的な使い方を説明する

```bash
git clone https://github.com/hoge/~
cd examples
python demo.py
```

# Note

注意点などがあれば書く

# Author

作成情報を列挙する

* 作成者
* 所属
* E-mail

# License
ライセンスを明示する

"hoge" is under [MIT license](https://en.wikipedia.org/wiki/MIT_License).

社内向けなら社外秘であることを明示してる

"hoge" is Confidential.