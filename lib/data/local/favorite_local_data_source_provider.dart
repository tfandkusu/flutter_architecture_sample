import 'package:flutter_architecture_sample/data/local/favorite_local_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// シングルトンなFavoriteLocalDataSourceのインスタンスを得る
final favoriteLocalDataSourceProvider =
    Provider((ref) => FavoriteLocalDataSource());
