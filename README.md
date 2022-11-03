# Flutter Architecture Sample

[![codecov](https://codecov.io/gh/tfandkusu/flutter_architecture_sample/branch/main/graph/badge.svg?token=BWEG8OYHZX)](https://codecov.io/gh/tfandkusu/flutter_architecture_sample)

[FlutterKaigi 2022](https://flutterkaigi.jp/2022/)「Flutterアプリの安全な変化と拡大を支えるアーキテクチャと単体テスト」のためのサンプルアプリ

# 登壇資料

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

# 機能

| 私のGitHubリポジトリ一覧を表示 | 詳細画面ではさらにREADME.mdを表示 |
| --- | --- |
| <img src="https://user-images.githubusercontent.com/16898831/199762049-f12717d6-5a54-4d08-9163-352b68c98f69.png" width="300"> | <img src="https://user-images.githubusercontent.com/16898831/199762070-feee603c-7325-4b28-b04f-5e3db55060be.png" width="300">|

## リポジトリ一覧はGitHubのREST APIから取得

https://api.github.com/users/tfandkusu/repos?page=1

## 所謂「いいね問題」に対応

| 詳細画面で「いいね」を付けると | 一覧画面でも「いいね」が付いている |
| --- | --- |
| <img src="https://user-images.githubusercontent.com/16898831/199762737-14b06715-ffc2-4a80-b2a5-ae3697743b49.png" width="300"> | <img src="https://user-images.githubusercontent.com/16898831/199762753-2920dd2b-4d81-4fe9-8efd-4b60cf986f2c.png" width="300"> |

「いいね」を付けた情報はアプリローカルに保存

# 使用技術

## 基本

- [Hooks Riverpod](https://pub.dev/packages/hooks_riverpod)
- [Freezed](https://pub.dev/packages/freezed)

## Webアクセス

- [Retrofit](https://pub.dev/packages/retrofit)
- [Dio](https://pub.dev/packages/dio)

## データ保存

- [shared_preferences](https://pub.dev/packages/shared_preferences)

## 表示

- [sprintf](https://pub.dev/packages/sprintf)
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

[Androidのアプリ アーキテクチャガイド](https://developer.android.com/jetpack/guide)に沿った2レイヤ構成のアーキテクチャです。

![architecture](https://user-images.githubusercontent.com/16898831/199698178-77f2afc4-b1f3-4b54-a142-f216715d9553.png)

## RemoteDataSource

- APIアクセスなどのネットワーク通信を担当します。

## LocalDataSource

- アプリローカルへの情報の読み書きを担当します。

## ModelStateNotifier

- 別の画面で行われた更新をもれなく反映するために、複数の画面から使われるデータは[RiverpodのStateNotifier](https://riverpod.dev/docs/providers/state_notifier_provider/)に持たせています(所謂「いいね問題」対応)。

## Repository

- データレイヤを代表して各種データソースにアクセスして、その結果を返却したり、ModelStateNotifierを更新します。

## UiModelStateNotifier

- 画面固有の状態遷移を担当します。
- 1画面に1つのUiModelクラスがあり、そのインスタンスを状態として持つStateNotifierです。


## UiModelProvider

- 画面の状態をWidgetに提供します。
- UiModelStateNotifierとModelStateNotiferの変更を監視し、両者を合成して画面の状態を作成します。

## EventHandler

- 画面が開かれた時の処理とユーザ操作によって始まる処理は、このクラスに記述します。
- 処理の内容はUiModelStateNotifierとRepositoryのメソッド呼び出しとなります。

# Tips

## 実プロダクトではドメインレイヤが必要

このサンプルアプリのアーキテクチャのまま実プロダクトを作成すると、EventHandlerクラスとその単体テストが巨大ファイルになり、可読性が悪くなる可能性があります。
そこで[ドメインレイヤ](https://developer.android.com/jetpack/guide/domain-layer)を追加して、1処理を1実装クラスと1単体テストファイルにすることで、巨大ファイルの発生を防ぎます。

![domain](https://user-images.githubusercontent.com/16898831/199710979-1a24a428-29d9-4eb9-9c5f-3a2af3eed07f.png)

## 描画パフォーマンスのためにWidgetのリビルド範囲を狭めたい場合

このアーキテクチャは1画面1[HookConsumerWidget](https://pub.dev/documentation/hooks_riverpod/latest/hooks_riverpod/HookConsumerWidget-class.html)構成のため、画面の状態が変わるとconstを付けた要素以外のすべての要素がリビルドされます。もし画面の要素数が多く描画パフォーマンスの問題が発生したがリビルド範囲を狭めることで解決できる場合は、下図の構成にすることでリビルド範囲を限定することができます。このサンプルアプリでは詳細画面の上部分と下部分でリビルド範囲を分割しています。

![header_body](https://user-images.githubusercontent.com/16898831/199765501-08b2c1c8-2cfc-4a14-942e-47a0be72433a.png)

![hook_consumer_widget](https://user-images.githubusercontent.com/16898831/199713866-02c11b2c-cfbc-486d-83bb-13099e899ce1.png)







