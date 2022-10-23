# 【WIP】flutter_architecture_sample

[![codecov](https://codecov.io/gh/tfandkusu/flutter_architecture_sample/branch/main/graph/badge.svg?token=BWEG8OYHZX)](https://codecov.io/gh/tfandkusu/flutter_architecture_sample)

FlutterKaigi 2022「アプリの安全な変化と拡大を支えるアーキテクチャと単体テスト」のためのサンプルアプリ

# インストール

現在のmainブランチを配布しています。

## Android

[<img src="https://dply.me/5tbyny/button/large" alt="Try it on your device via DeployGate">](https://dply.me/5tbyny#install)

## Web

iOSユーザまたはPCユーザはこちらでご確認ください。

[Webアプリを開く](https://flutter-architecture-sample.web.app/)

# ビルド

[asdf](https://asdf-vm.com/)を使用しています。インストールされていなければ[こちら](https://asdf-vm.com/guide/getting-started.html#_1-install-dependencies)を参考にインストールします。

## ビルドする環境の構築

```sh
asdf plugin add flutter
asdf plugin add ruby
asdf install
gem install cocoapods
```

## ビルドして実行する


```sh
flutter pub get
flutter pub run build_runner build
flutter run
```
