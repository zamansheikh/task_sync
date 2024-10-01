import 'package:task_sync/features/auth/domain/user.dart';

class UserModel extends User {
  const UserModel({
    required super.uid,
    required super.email,
    required super.displayName,
    required super.photoURL,
  });

  UserModel.fromMap(Map<String, dynamic> res)
      : super(
          uid: res['uid'],
          email: res['email'],
          displayName: res['displayName'],
          photoURL: res['photoURL'],
        );

  Map<String, Object?> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
    };
  }

  @override
  List<Object?> get props => [uid, email, displayName, photoURL];
}
