// lib/presentation/state/ui_state.dart

abstract class UiState<T> {
  const UiState();
}

class InitialState<T> extends UiState<T> {
  const InitialState();
}

class LoadingState<T> extends UiState<T> {
  const LoadingState();
}

class SuccessState<T> extends UiState<T> {
  final T data;
  const SuccessState(this.data);
}

class ErrorState<T> extends UiState<T> {
  final String message;
  const ErrorState(this.message);
}
