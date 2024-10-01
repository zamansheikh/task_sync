import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_sync/core/error/exception/server_exception.dart';
import 'package:task_sync/features/auth/data/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Sign up with email and password.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> signUpWithEmailAndPassword(String email, String password);

  /// Log in with email and password.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> loginWithEmailAndPassword(String email, String password);

  /// Log in with Google.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> loginWithGoogle();

  /// Sign up with Google.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> signUpWithGoogle();

  /// Log out the user.
  Future<void> logout();

  /// Check if the user is logged in.
  Future<bool> isLoggedIn();

  /// Get the current user.
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapFirebaseUserToUserModel(userCredential.user);
    } catch (e) {
      throw ServerException('Failed to sign up with email and password: $e');
    }
  }

  @override
  Future<UserModel> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapFirebaseUserToUserModel(userCredential.user);
    } catch (e) {
      throw ServerException('Failed to log in with email and password: $e');
    }
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw ServerException('Google sign-in was aborted.');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      return _mapFirebaseUserToUserModel(userCredential.user);
    } catch (e) {
      throw ServerException('Failed to log in with Google: $e');
    }
  }

  @override
  Future<UserModel> signUpWithGoogle() async {
    return loginWithGoogle(); // You can handle sign-up logic similarly to login if needed
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      throw ServerException('Failed to log out: $e');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final user = firebaseAuth.currentUser;
    return user != null;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      return _mapFirebaseUserToUserModel(user);
    }
    return null;
  }

  /// Maps Firebase user to the app's [UserModel].
  UserModel _mapFirebaseUserToUserModel(User? user) {
    if (user == null) {
      throw ServerException('User is not logged in');
    }
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
      photoURL: user.photoURL ?? '',
    );
  }
}
