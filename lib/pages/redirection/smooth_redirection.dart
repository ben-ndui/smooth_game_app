import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/controllers/smooth_auth_controller.dart';
import 'package:smooth_game_app/core/services/smooth_auth_service.dart';
import 'package:smooth_game_app/pages/profile/profile_screen.dart';
import 'package:smooth_game_app/pages/redirection/login_screen.dart';

class SmoothRedirection extends StatefulWidget {
  const SmoothRedirection({Key? key}) : super(key: key);

  @override
  State<SmoothRedirection> createState() => _SmoothRedirectionState();
}

class _SmoothRedirectionState extends State<SmoothRedirection> {
  @override
  Widget build(BuildContext context) {
    SmoothConfig().init(context);

    return Consumer<SmoothAuthController>(builder: (context, authController, child) {
      return StreamBuilder<User?>(
          stream: SmoothAuthService().authChange(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LoginScreen();
            }

            final user = snapshot.data;

            if (user != null) {
              authController.initUser(context: context, user: user);
              if (authController.currentUser != null) {
                return const ProfileScreen();
              }
            }
            return const LoginScreen();
          });
    });
  }
}
