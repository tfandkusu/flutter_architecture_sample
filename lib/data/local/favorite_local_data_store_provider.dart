import 'package:flutter_architecture_sample/data/local/favorite_local_data_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// シングルトンなFavoriteLocalDataStoreのインスタンスを得る
final favoriteLocalDataStoreProvider =
    Provider((ref) => FavoriteLocalDataStore());
