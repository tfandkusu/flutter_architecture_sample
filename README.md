# Flutter　

[![codecov](https://codecov.io/gh/tfandkusu/flutter_architecture_sample/branch/main/graph/badge.svg?token=BWEG8OYHZX)](https://codecov.io/gh/tfandkusu/flutter_architecture_sample)

[FlutterKaigi 2022](https://flutterkaigi.jp/2022/)「Flutterアプリの安全な変化と拡大を支えるアーキテクチャと単体テスト」のためのサンプルアプリ

# FlutterKaigi 2022での登壇資料

- **TODO** 動画
- **TODO** スライド

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

# 仕様技術

## 基本

- [Hooks Riverpod](https://pub.dev/packages/hooks_riverpod)
- [Freezed](https://pub.dev/packages/freezed)

## Webアクセス

- [Retrofit](https://pub.dev/packages/retrofit)
- [Dio](https://pub.dev/packages/dio)

## データ保存

- [shared_preferences](https://pub.dev/packages/shared_preferences)

## 表示

- [flutter_markdown](https://pub.dev/packages/flutter_markdown)
- [url_launcher](https://pub.dev/packages/url_launcher)

## テスト

- [mockito](https://pub.dev/packages/mockito)

## CI/CD

- [GitHub Actions](https://github.co.jp/features/actions)
  - [Flutter action](https://github.com/marketplace/actions/flutter-action)
  - [Gradle Build Action](https://github.com/marketplace/actions/gradle-build-action)
- [Codecov](https://about.codecov.io/)
- [DeployGate](https://deploygate.com/)
- [Firebase Hosting](https://firebase.google.com/docs/hosting)

# アーキテクチャ

[Androidのアプリ アーキテクチャガイド](https://developer.android.com/jetpack/guide)に沿った2レイヤー構成のアーキテクチャです。

![architecture](https://user-images.githubusercontent.com/16898831/199698178-77f2afc4-b1f3-4b54-a142-f216715d9553.png)

## RemoteDataStore

- APIアクセスなどのネットワーク通信を担当します。

## LocalDataStore

- アプリローカルへの情報の読み書きを担当します。

## ModelStateNotifier

- 複数の画面から使われるデータは別の画面で行われたデータ更新をもれなく反映するために、[RiverpodのStateNotifier](https://riverpod.dev/docs/providers/state_notifier_provider/)に持たせています。

# 描画パフォーマンスについて

