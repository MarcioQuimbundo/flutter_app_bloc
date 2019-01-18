import 'package:meta/meta.dart';

class ListState<T> {
  final bool isLoading;
  final String error;
  final T listItem;

  ListState({this.listItem, this.error, this.isLoading});

  factory ListState.initial() {
    return ListState(isLoading: false, error: '', listItem: null);
  }

  factory ListState.loading() {
    return ListState(isLoading: true);
  }

  factory ListState.success(T listItem) {
    return ListState(listItem: listItem, isLoading: false);
  }

  factory ListState.failure(String error) {
    return ListState(error: error, isLoading: false);
  }

  bool loadingSucceeded() => this.listItem != null;

  bool loadingFailed() => this.error.isNotEmpty;
}
