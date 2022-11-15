import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GibsonifyRepository _gibsonifyRepository;
  final IsarRepository _isarRepository;

  HomeBloc({
    required GibsonifyRepository gibsonifyRepository,
    required IsarRepository isarRepository,
  })  : _gibsonifyRepository = gibsonifyRepository,
        _isarRepository = isarRepository,
        super(const HomeState()) {
    // TODO: implement a subscription to a stream of GibsonsForms
    on<GibsonsFormsLoaded>(_onGibsonsFormsLoaded);
    on<GibsonsFormDeleted>(_onGibsonsFormDeleted);
  }

  void _onGibsonsFormsLoaded(
      GibsonsFormsLoaded event, Emitter<HomeState> emit) async {
    List<GibsonsForm?> gibsonsFormsLoaded = _gibsonifyRepository.loadForms();
    final households = await _isarRepository.readHouseholds();
    emit(state.copyWith(
        gibsonsForms: gibsonsFormsLoaded, households: households));
  }

  void _onGibsonsFormDeleted(
      GibsonsFormDeleted event, Emitter<HomeState> emit) async {
    _gibsonifyRepository.deleteForm(event.id);
    // TODO: Find a more efficient implementation
    List<GibsonsForm?> gibsonsFormsLoaded = _gibsonifyRepository.loadForms();
    emit(state.copyWith(gibsonsForms: gibsonsFormsLoaded));
  }
}
