import 'package:flutter_architecture_sample/data/local/favorite_local_data_store_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// FavoriteLocalDataStoreのテスト
void main() {
  test("FavoriteLocalDataStore", () async {
    // PC上で単体テストが動くようにするための設定
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    final localDataStore = container.read(favoriteLocalDataStoreProvider);
    // 最初は何も「いいね」をしていない
    expect(await localDataStore.getFavoriteRepoNameSet(), <String>{});
    // flutter_architecture_sampleに「いいね」を付ける
    localDataStore.setFavorite('flutter_architecture_sample', true);
    // flutter_architecture_sampleだけのセットを取得する
    expect(await localDataStore.getFavoriteRepoNameSet(),
        <String>{'flutter_architecture_sample'});
    // android_app_templateに「いいね」を付ける
    localDataStore.setFavorite('android_app_template', true);
    // さっき「いいね」を付けたflutter_architecture_sample
    // android_app_templateのセットを取得する
    expect(await localDataStore.getFavoriteRepoNameSet(),
        <String>{'flutter_architecture_sample', 'android_app_template'});
    // flutter_architecture_sampleから「いいね」を消す
    localDataStore.setFavorite('flutter_architecture_sample', false);
    // さっき「いいね」を付けたandroid_app_templateだけのセットを取得する
    expect(await localDataStore.getFavoriteRepoNameSet(),
        <String>{'android_app_template'});
    // android_app_templateに多重に「いいね」をつける
    localDataStore.setFavorite('android_app_template', true);
    expect(await localDataStore.getFavoriteRepoNameSet(),
        <String>{'android_app_template'});
    // 存在しないリポジトリの「いいね」を消す
    localDataStore.setFavorite('unknown', false);
    expect(await localDataStore.getFavoriteRepoNameSet(),
        <String>{'android_app_template'});
  });
}
