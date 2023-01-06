import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_game_app/core/common/smooth_handle_error.dart';
import 'package:smooth_game_app/core/models/smooth_user.dart';

class SmoothUsersService {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final String colName = "user";
  final String all = "all";

  String getNewId() {
    return _instance.collection(colName).doc().id;
  }

  String saveUser(SmoothUser user) {
    try {
      _instance.collection(colName).doc(user.userId).set(user.toJson());
      return "Saved";
    } on FirebaseException catch (e) {
      return SmoothHandleError.classicOne(className: "SmoothUsersService", line: 19, error: e);
    }
  }

  String updateUser(SmoothUser user) {
    try {
      _instance.collection(colName).doc(user.userId).update(user.toJson());
      return "Update";
    } on FirebaseException catch (e) {
      return SmoothHandleError.classicOne(className: "SmoothUsersService", line: 28, error: e);
    }
  }

  String deleteUser(SmoothUser user) {
    try {
      _instance.collection(colName).doc(user.userId).delete();
      return "Delete";
    } on FirebaseException catch (e) {
      return SmoothHandleError.classicOne(className: "SmoothUsersService", line: 37, error: e);
    }
  }

  Future<SmoothUser>? getUserById(String userId) {
    try {
      return _instance
          .collection(colName)
          .where('userId', isEqualTo: userId)
          .get()
          .then((value) => SmoothUser.fromJson(value.docs.first.data()));
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(className: "SmoothUsersService", line: 37, error: e);
      return null;
    }
  }

  Stream<List<SmoothUser>>? allUsers() {
    try {
      return _instance.collection(colName).snapshots().map((event) {
        return event.docs.map((e) => SmoothUser.fromJson(e)).toList();
      });
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(className: "SmoothUsersService", line: 37, error: e);
      return null;
    }
  }

  Future<SmoothUser>? getUserByPseudo(String pseudo) {
    try {
      return _instance
          .collection(colName)
          .where('pseudo', isEqualTo: pseudo)
          .get()
          .then((value) => SmoothUser.fromJson(value.docs.first.data()));
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(className: "SmoothUsersService", line: 37, error: e);
      return null;
    }
  }
}
