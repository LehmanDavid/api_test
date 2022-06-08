abstract class StateStatus {
  const StateStatus();

  const factory StateStatus.initial() = InitialStatus;
  const factory StateStatus.success() = SuccessStatus;
  const factory StateStatus.failure(String message) = FailureStatus;
}

class InitialStatus extends StateStatus {
  const InitialStatus();
}

class SuccessStatus extends StateStatus {
  const SuccessStatus();
}

class FailureStatus extends StateStatus {
  final String message;

  const FailureStatus(this.message);
}
