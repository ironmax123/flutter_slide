import 'dart:io';
import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:slides_for_mac/service/server_state_service.dart';
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
    @Default(false) bool isConnected,
  }) = _AppBarState;
}

@riverpod
class BaseViewModel extends _$BaseViewModel {
  BaseViewModel() {
    // Listen for server start events from native layer
    ServerStateService.listenForServerStart((port) {
      connectToServer(port);
    });
  }

  int _totalPages = 0;
  Socket? _socket;

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

  Future<void> connectToServer([int port = 8000]) async {
    if (state.isConnected) return;

    const int maxRetries = 5;
    const Duration retryInterval = Duration(seconds: 1);

    for (int i = 0; i < maxRetries; i++) {
      try {
        print(
          "Attempting to connect to server at $port (Attempt ${i + 1}/$maxRetries)...",
        );
        _socket = await Socket.connect('127.0.0.1', port);
        state = state.copyWith(isConnected: true);
        print("Connected to server!");

        _socket!.listen(
          (List<int> event) {
            final message = String.fromCharCodes(event).trim();
            print('Received from server: $message');
            if (message == 'next') {
              nextPage();
            } else if (message == 'previous') {
              previousPage();
            }
          },
          onError: (error) {
            print('Socket error: $error');
            state = state.copyWith(isConnected: false);
            _socket?.destroy();
          },
          onDone: () {
            print('Socket closed');
            state = state.copyWith(isConnected: false);
            _socket?.destroy();
          },
        );
        return; // Success, exit loop
      } catch (e) {
        print("Connection failed: $e");
        if (i < maxRetries - 1) {
          await Future.delayed(retryInterval);
        }
      }
    }
    print("Failed to connect after $maxRetries attempts.");
  }
}
