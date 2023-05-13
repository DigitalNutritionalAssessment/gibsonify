import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'fct_event.dart';
part 'fct_state.dart';

class FCTBloc extends Bloc<FCTEvent, FCTState> {
  final FCTRepository _fctRepository;
  final String _fctId;

  FCTBloc({required FCTRepository fctRepository, required String fctId})
      : _fctRepository = fctRepository,
        _fctId = fctId,
        super(FCTState(fctId: fctId)) {
    on<FCTOpened>(_onFCTOpened);
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  void _onFCTOpened(FCTOpened event, Emitter<FCTState> emit) {
    emit(state.copyWith(fctId: _fctId));
  }

  void _onSearchQueryChanged(
      SearchQueryChanged event, Emitter<FCTState> emit) async {
    final fctItems =
        await _fctRepository.search(fctId: _fctId, query: event.query);
    emit(state.copyWith(query: event.query, fctItems: fctItems));
  }
}
