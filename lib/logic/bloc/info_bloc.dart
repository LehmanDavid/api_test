import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../model/info_model.dart';
import '../../model/state_status.dart';
import '../../service/text_service.dart';

part 'info_event.dart';
part 'info_state.dart';

const throttleDuration = Duration(milliseconds: 300);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final TextService textService;

  InfoBloc(this.textService)
      : super(const InfoState(infos: [], status: StateStatus.initial())) {
    on<LoadApiEvent>((event, emit) async {
      emit(state.copyWith(status: const StateStatus.initial()));

      try {
        final service = await textService.getInfo(state.infos.length);
        emit(state.copyWith(
            status: const StateStatus.success(), infos: state.infos + service));
      } catch (error) {
        emit(state.copyWith(status: StateStatus.failure(error.toString())));
      }
    });
  }
}
