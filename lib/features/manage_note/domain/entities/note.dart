import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String text;
  final DateTime placeDateTime;
  final String? userId;
  final String id;

  const Note({
    required this.text,
    required this.placeDateTime,
    this.userId,
    required this.id,
  });

  @override
  List<Object?> get props => [
        text,
        placeDateTime,
        userId,
        id,
      ];
}
