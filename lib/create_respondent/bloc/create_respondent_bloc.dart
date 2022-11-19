import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'create_respondent_event.dart';
part 'create_respondent_state.dart';

class CreateRespondentBloc
    extends Bloc<CreateRespondentEvent, CreateRespondentState> {
  final IsarRepository _isarRepository;

  CreateRespondentBloc({
    required IsarRepository isarRepository,
    required int id,
  })  : _isarRepository = isarRepository,
        super(CreateRespondentState(id)) {
    on<NewRespondentSaveRequested>(_onNewRespondentSaveRequested);
  }

  void _onNewRespondentSaveRequested(NewRespondentSaveRequested event,
      Emitter<CreateRespondentState> emit) async {
    await _isarRepository.saveNewRespondent(state.id, event.respondent);
  }
}
