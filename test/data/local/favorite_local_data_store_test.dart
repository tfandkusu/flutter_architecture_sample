import 'package:flutter_architecture_sample/data/local/favorite_local_data_store_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// FavoriteLocalDataStoreのテスト
void main() {
  test("FavoriteLocalDataStore", () async {
    // テスト用の設定を行う
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    final localDataStore = container.read(favoriteLocalDataStoreProvider);
    // 最初は何もいいねをしていない
    expect(await localDataStore.getFavoriteRepoNameSet(), <String>{});
    // flutter_architecture_sampleに、いいねを付ける
    localDataStore.setFavorite('flutter_architecture_sample', true);
    expect(await localDataStore.getFavoriteRepoNameSet(),
        <String>{'flutter_architecture_sample'});
    // android_app_templateに、いいねを付ける
    localDataStore.setFavorite('android_app_template', true);
    expect(await localDataStore.getFavoriteRepoNameSet(),
        <String>{'flutter_architecture_sample', 'android_app_template'});
    // flutter_architecture_sampleから、いいねを消す
    localDataStore.setFavorite('flutter_architecture_sample', false);
    expect(await localDataStore.getFavoriteRepoNameSet(),
        <String>{'android_app_template'});
    // android_app_templateに多重に、いいねをつける
    localDataStore.setFavorite('android_app_template', true);
    expect(await localDataStore.getFavoriteRepoNameSet(),
        <String>{'android_app_template'});
    // 存在しないリポジトリの、いいねを消す
    localDataStore.setFavorite('unknown', false);
    expect(await localDataStore.getFavoriteRepoNameSet(),
        <String>{'android_app_template'});
  });
}
