part of 'info_bloc.dart';

class InfoState extends Equatable {
  final List<Info> infos;
  final StateStatus status;

  const InfoState({required this.infos, required this.status});

  @override
  List<Object> get props => [infos, status];

  InfoState copyWith({
    List<Info>? infos,
    StateStatus? status,
  }) {
    return InfoState(
      infos: infos ?? this.infos,
      status: status ?? this.status,
    );
  }
}
