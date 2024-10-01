import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final String photoURL;

  const User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoURL,
  });

  @override
  List<Object?> get props => [uid, email, displayName, photoURL];
}
