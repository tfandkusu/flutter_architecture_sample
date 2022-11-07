import 'package:flutter_architecture_sample/catalog/github_repo_catalog.dart';
import 'package:flutter_architecture_sample/screen/common/stateholder/error_ui_model.dart';
import 'package:flutter_architecture_sample/screen/home/stateholder/home_ui_model.dart';
import 'package:flutter_architecture_sample/util/check_one_shot_operation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repo = getGithubRepoCatalog()[0];
  HomeUiModel? nullState;
  test("checkOneShotOperation 1", () async {
    // previousがnull
    // 値もnull
    const next = HomeUiModel(
        progress: false,
        repos: [],
        error: ErrorUiModel.noError(),
        callDetailScreen: null);
    var called = false;
    checkOneShotOperation(nullState, next, (state) => state.callDetailScreen,
        (value) {
      called = true;
    });
    expect(called, false);
  });
  test("checkOneShotOperation 2", () async {
    // previousがnull
    // 値が設定された
    final next = HomeUiModel(
        progress: false,
        repos: [],
        error: const ErrorUiModel.noError(),
        callDetailScreen: repo);
    var called = false;
    checkOneShotOperation(nullState, next, (state) => state.callDetailScreen,
        (value) {
      called = true;
    });
    expect(called, true);
  });
  test("checkOneShotOperation 3", () async {
    // previousと同じ値
    final previous = HomeUiModel(
        progress: false,
        repos: [],
        error: const ErrorUiModel.noError(),
        callDetailScreen: repo);
    final next = HomeUiModel(
        progress: false,
        repos: [],
        error: const ErrorUiModel.noError(),
        callDetailScreen: repo);
    var called = false;
    checkOneShotOperation(previous, next, (state) => state.callDetailScreen,
        (value) {
      called = true;
    });
    expect(called, false);
  });
  test("checkOneShotOperation 4", () async {
    // previousと違う値だがnull
    final previous = HomeUiModel(
        progress: false,
        repos: [],
        error: const ErrorUiModel.noError(),
        callDetailScreen: repo);
    const next =
        HomeUiModel(progress: false, repos: [], error: ErrorUiModel.noError());
    var called = false;
    checkOneShotOperation(previous, next, (state) => state.callDetailScreen,
        (value) {
      called = true;
    });
    expect(called, false);
  });
  test("checkOneShotOperation 5", () async {
    // previousと違う値が設定された
    const previous =
        HomeUiModel(progress: false, repos: [], error: ErrorUiModel.noError());
    final next = HomeUiModel(
        progress: false,
        repos: [],
        error: const ErrorUiModel.noError(),
        callDetailScreen: repo);
    var called = false;
    checkOneShotOperation(previous, next, (state) => state.callDetailScreen,
        (value) {
      called = true;
    });
    expect(called, true);
  });
}
