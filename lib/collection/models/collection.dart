import 'package:equatable/equatable.dart';

class Collection extends Equatable {
  const Collection({required this.id, required this.title, required this.body});

  final int id;
  final String title;
  final String body;

  Collection copyWith({
    int? id,
    String? title,
    String? body,
  }) {
    return Collection(
        id: id ?? this.id, title: title ?? this.title, body: body ?? this.body);
  }

  @override
  List<Object> get props => [id, title, body];
}
