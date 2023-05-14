part of 'analysis_bloc.dart';

abstract class AnalysisEvent extends Equatable {
  const AnalysisEvent();

  @override
  List<Object> get props => [];
}

class AnalysisStarted extends AnalysisEvent {
  const AnalysisStarted();
}
