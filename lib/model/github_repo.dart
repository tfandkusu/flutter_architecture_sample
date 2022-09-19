import 'package:freezed_annotation/freezed_annotation.dart';
part 'github_repo.freezed.dart';

@freezed
class GithubRepo with _$GithubRepo {
  const factory GithubRepo(
      {required int id,
      required String name,
      required String description,
      required DateTime updatedAt,
      required String language,
      required String htmlUrl,
      required bool fork,
      required bool favorite}) = _GithubRepo;
}
