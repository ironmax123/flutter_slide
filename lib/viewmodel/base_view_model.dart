import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'base_view_model.freezed.dart';
part 'base_view_model.g.dart';

@freezed
class AppBarState with _$AppBarState {
  const factory AppBarState({
    required String title,
    @Default(false) bool isVisible,
    @Default(true) bool showBackButton,
    @Default(0) int currentPageIndex,
  }) = _AppBarState;
}

@riverpod
class BaseViewModel extends _$BaseViewModel {
  int _totalPages = 0;

  @override
  AppBarState build() => const AppBarState(title: '', isVisible: false);

  void setTotalPages(int total) {
    _totalPages = total;
  }

  void setTitle(String title, {bool showAppBar = true}) {
    state = state.copyWith(title: title, isVisible: showAppBar);
  }

  void hideAppBar() {
    state = state.copyWith(isVisible: false);
  }

  void showAppBar() {
    state = state.copyWith(isVisible: true);
  }

  void nextPage() {
    if (state.currentPageIndex < _totalPages - 1) {
      state = state.copyWith(currentPageIndex: state.currentPageIndex + 1);
    }
  }

  void previousPage() {
    if (state.currentPageIndex > 0) {
      state = state.copyWith(currentPageIndex: state.currentPageIndex - 1);
    }
  }

  void goToPage(int index) {
    if (index >= 0 && index < _totalPages) {
      state = state.copyWith(currentPageIndex: index);
    }
  }
}
