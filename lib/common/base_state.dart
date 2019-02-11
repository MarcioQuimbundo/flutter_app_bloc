class BaseState<T> {
  final bool isLoading;
  final String error;
  final T item;

  BaseState({this.item, this.error, this.isLoading});

  factory BaseState.initial() {
    return BaseState(isLoading: false, error: '', item: null);
  }

  factory BaseState.loading() {
    return BaseState(isLoading: true);
  }

  factory BaseState.success(T listItem) {
    return BaseState(item: listItem, isLoading: false);
  }

  factory BaseState.failure(String error) {
    return BaseState(error: error, isLoading: false);
  }

  bool loadingSucceeded() => this.item != null;

  bool loadingFailed() => this.error.isNotEmpty;
}
