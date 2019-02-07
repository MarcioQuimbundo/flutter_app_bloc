class OperationState<T> {
  final bool isLoading;
  final String error;
  final T item;

  OperationState({this.item, this.error, this.isLoading});

  factory OperationState.initial() {
    return OperationState(isLoading: false, error: '', item: null);
  }

  factory OperationState.loading() {
    return OperationState(isLoading: true);
  }

  factory OperationState.success(T listItem) {
    return OperationState(item: listItem, isLoading: false);
  }

  factory OperationState.failure(String error) {
    return OperationState(error: error, isLoading: false);
  }

  bool loadingSucceeded() => this.item != null;

  bool loadingFailed() => this.error.isNotEmpty;
}
