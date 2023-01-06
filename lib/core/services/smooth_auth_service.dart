import 'package:firebase_auth/firebase_auth.dart';
import 'package:smooth_game_app/core/common/smooth_handle_error.dart';
import 'package:smooth_game_app/core/models/smooth_user.dart';
import 'package:smooth_game_app/core/services/smooth_users_service.dart';

class SmoothAuthService {
  final SmoothUsersService usersDatabase = SmoothUsersService();
  final FirebaseAuth _instance = FirebaseAuth.instance;

  Stream<User?> authChange() {
    return _instance.authStateChanges();
  }

  Future<SmoothUser>? getUserById(String uid) {
    return usersDatabase.getUserById(uid);
  }

  Future<SmoothUser>? getUserByPseudo(String pseudo) {
    return usersDatabase.getUserByPseudo(pseudo);
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final res = await _instance.signInWithEmailAndPassword(email: email, password: password);
      final user = res.user;
      return user;
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(className: 'SmoothAuthService', line: 25, error: e.message);
      return null;
    }
  }

  Future<User?> signUp(String email, String password) async {
    try {
      final res = await _instance.createUserWithEmailAndPassword(email: email, password: password);
      final user = res.user;
      return user;
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(className: 'SmoothAuthService', line: 36, error: e.message);
      return null;
    }
  }

  Future<User?> signInAnonymously() async {
    try {
      final res = await _instance.signInAnonymously();
      final user = res.user;
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(className: 'SmoothAuthService', line: 45, error: e.message);
      return null;
    }
  }

  Future<void> signOut() async {
    await _instance.signOut();
  }
}
