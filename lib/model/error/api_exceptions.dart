/// 圏外などのネットワークエラー
class NetworkErrorException implements Exception {}

/// 該当リソースが存在しないエラー(404)
class NotFoundException implements Exception {}

/// メンテナンス中などのサーバエラー(404以外のステータスコード)
class ServerErrorException implements Exception {}
