part of 'fct_bloc.dart';

class FCTState extends Equatable {
  final String fctId;
  final String query;
  final Map<FCTFoodGroup, List<FCTFoodItem>> fctItems;

  const FCTState(
      {required this.fctId, this.query = '', this.fctItems = const {}});

  FCTState copyWith(
      {String? fctId,
      String? query,
      Map<FCTFoodGroup, List<FCTFoodItem>>? fctItems}) {
    return FCTState(
        fctId: fctId ?? this.fctId,
        query: query ?? this.query,
        fctItems: fctItems ?? this.fctItems);
  }

  @override
  List<Object> get props => [fctId, query, fctItems];
}
