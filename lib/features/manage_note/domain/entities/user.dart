import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String password;
  final String email;
  final String? imageAsBase64;
  final String interestId;
  final String id;
  const User({
    required this.username,
    required this.password,
    required this.email,
    this.imageAsBase64,
    required this.interestId,
    required this.id,
  });
  @override
  List<Object?> get props => [
        username,
        password,
        email,
        imageAsBase64,
        interestId,
        id,
      ];
}
