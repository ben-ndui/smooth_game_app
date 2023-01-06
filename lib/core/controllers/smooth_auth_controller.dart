import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/common/smooth_handle_error.dart';
import 'package:smooth_game_app/core/common/smooth_snackbar.dart';
import 'package:smooth_game_app/core/controllers/smooth_forms_controller.dart';
import 'package:smooth_game_app/core/controllers/smooth_game_controller.dart';
import 'package:smooth_game_app/core/models/smooth_user.dart';
import 'package:smooth_game_app/core/services/smooth_auth_service.dart';
import 'package:smooth_game_app/core/services/smooth_users_service.dart';
import 'package:smooth_game_app/router/router.gr.dart';

class SmoothAuthController extends ChangeNotifier {
  final SmoothAuthService authService = SmoothAuthService();
  final BuildContext? context;

  SmoothUser? currentUser;

  bool isLoading = false;

  SmoothAuthController({this.context});

  Stream<SmoothUser?> authChange() {
    return authService.authChange().map(userFromFirebase);
  }

  SmoothUser? userFromFirebase(User? user) {
    if (user != null) {
      initUser(context: context!, user: user);
      return currentUser;
    } else {
      return null;
    }
  }

  Future<void> initUser({
    required BuildContext context,
    required User user,
    bool anonymous = false,
  }) async {
    final formController = context.read<SmoothFormsController>();
    final gameController = context.read<SmoothGameController>();

    if (anonymous) {
      currentUser = await authService.getUserByPseudo(formController.pseudo!);
    } else {
      currentUser = await authService.getUserById(user.uid);
    }
    gameController.initCurrentUser(currentUser);
    notifyListeners();
  }

  Future<void> signIn(SmoothFormsController smoothFormsController, BuildContext context) async {
    toggleLoader();
    try {
      if (smoothFormsController.loginFormKey.currentState!.validate()) {
        final res = isLoading
            ? await authService.signIn(
                smoothFormsController.email,
                smoothFormsController.password,
              )
            : null;
        notifyListeners();

        if (res != null) {
          initUser(context: context, user: res, anonymous: false);
          context.router.replace(const AuthRedirection());
          toggleLoader();
        } else {
          toggleLoader();
          SmoothSnackBar(context: context).build(content: "Erreur lors de l'authentification");
        }
      } else {
        SmoothSnackBar(context: context).build(content: "Vous avez pas rempli les champs requis !");
      }
    } on FirebaseException catch (e) {
      SmoothSnackBar(context: context).build(content: e.message);
    }
  }

  Future<void> register(SmoothFormsController smoothFormsController, BuildContext context) async {
    try {
      toggleLoader();
      if (smoothFormsController.registerFormKey.currentState!.validate()) {
        final user = isLoading
            ? await authService.signUp(smoothFormsController.email, smoothFormsController.password)
            : null;
        if (user != null) {
          final usr = SmoothUser(
            userId: user.uid,
            pseudo: smoothFormsController.pseudo!,
            email: user.email,
          );
          final isSaved = SmoothUsersService().saveUser(usr);
          if (isSaved.contains("Saved")) {
            initUser(context: context, user: user, anonymous: false);
            context.router.replace(const AuthRedirection());
            toggleLoader();
          }
        } else {
          toggleLoader();
          SmoothSnackBar(context: context)
              .build(content: "Erreur lors de la création de votre compte");
        }
      } else {
        toggleLoader();
        SmoothSnackBar(context: context).build(content: "Vous avez pas rempli les champs requis !");
      }
    } on FirebaseException catch (e) {
      SmoothSnackBar(context: context).build(content: e.message);
    }
  }

  Future<void> signInAnonymously(
      BuildContext context, SmoothFormsController smoothFormsController) async {
    try {
      toggleLoader();
      if (smoothFormsController.anonymousFormKey.currentState!.validate()) {
        final res = isLoading ? await authService.signInAnonymously() : null;
        if (res != null) {
          initUser(context: context, user: res, anonymous: smoothFormsController.anonymousMode);
          toggleLoader();
          context.router.replace(const AuthRedirection());
        }
      } else {
        toggleLoader();
        SmoothSnackBar(context: context).build(content: "Vous avez pas rempli les champs requis !");
      }
    } on FirebaseException catch (e) {
      SmoothSnackBar(context: context).build(content: e.message);
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      toggleLoader();
      await authService.signOut().whenComplete(() {
        currentUser = null;
        toggleLoader();
      });
      context.router.replace(const Home());
    } on FirebaseException catch (e) {
      SmoothHandleError.classicOne(className: 'SmoothAuthController', line: 123, error: e.message);
    }
  }

  void toggleLoader() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
