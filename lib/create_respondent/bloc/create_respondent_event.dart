part of 'create_respondent_bloc.dart';

abstract class CreateRespondentEvent extends Equatable {
  const CreateRespondentEvent();

  @override
  List<Object> get props => [];
}

class NewRespondentSaveRequested extends CreateRespondentEvent {
  final Respondent respondent;

  const NewRespondentSaveRequested({required this.respondent});

  @override
  List<Object> get props => [respondent];
}
