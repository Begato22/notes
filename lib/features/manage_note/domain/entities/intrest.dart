import 'package:equatable/equatable.dart';

class Intrest extends Equatable {
  final String id;
  final String intrestText;

  const Intrest({
    required this.id,
    required this.intrestText,
  });

  @override
  List<Object?> get props => [
        id,
        intrestText,
      ];
}
