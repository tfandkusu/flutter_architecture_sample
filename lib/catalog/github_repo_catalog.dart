import 'package:flutter_architecture_sample/model/github_repo.dart';

List<GithubRepo> getGithubRepoCatalog() {
  final repo1 = GithubRepo(
      id: 229475311,
      name: "observe_room",
      description: "Check how to use Room to observe SQLite database "
          "and reflect the changes in the RecyclerView.",
      updatedAt: DateTime.parse("2021-10-29T00:15:46Z"),
      language: "Kotlin",
      htmlUrl: "https://github.com/tfandkusu/observe_room",
      fork: false,
      defaultBranch: "master",
      favorite: false);
  final repo2 = GithubRepo(
      id: 343133709,
      name: "conference-app-2021",
      description: "The Official App for DroidKaigi 2021",
      updatedAt: DateTime.parse("2021-09-21T16:56:04Z"),
      language: "Kotlin",
      htmlUrl: "https://github.com/tfandkusu/conference-app-2021",
      fork: true,
      defaultBranch: "main",
      favorite: false);
  final repo3 = GithubRepo(
      id: 320900929,
      name: "groupie_sticky_header_sample",
      description: "Sample app for sticky header on the groupie",
      updatedAt: DateTime.parse("2021-01-19T19:46:27Z"),
      language: "Java",
      htmlUrl: "https://github.com/tfandkusu/groupie_sticky_header_sample",
      fork: false,
      defaultBranch: "main",
      favorite: false);
  return [repo1, repo2, repo3];
}
