import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/common/smooth_loader.dart';
import 'package:smooth_game_app/core/controllers/smooth_auth_controller.dart';
import 'package:smooth_game_app/core/controllers/smooth_forms_controller.dart';
import 'package:smooth_game_app/core/controllers/smooth_theme_controller.dart';
import 'package:smooth_game_app/core/enums/smooth_form.dart';
import 'package:smooth_game_app/core/widgets/smooth_column.dart';
import 'package:smooth_game_app/core/widgets/smooth_custom_appbar.dart';
import 'package:smooth_game_app/core/widgets/smooth_scaffold.dart';
import 'package:smooth_game_app/core/widgets/smooth_spacer.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';
import 'package:smooth_game_app/core/widgets/smooth_text_button.dart';
import 'package:smooth_game_app/core/widgets/smooth_textform_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmoothScaffold(
      body: Consumer<SmoothAuthController>(
        builder: (context, authController, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Consumer<SmoothFormsController>(
                builder: (context, smoothFormsController, child) {
                  return Column(
                    children: [
                      SmoothCustomAppBar(type: SmoothCustomAppBarType.login)
                          .build(title: 'Smooth Games'),
                      buildBody(smoothFormsController, authController, context),
                    ],
                  );
                },
              ),
              SmoothLoader(visible: authController.isLoading),
            ],
          );
        },
      ),
    );
  }

  Widget buildBody(
    SmoothFormsController smoothFormsController,
    SmoothAuthController authController,
    BuildContext context,
  ) {
    final themeController = context.read<SmoothThemeController>();
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 100.0),
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: buildBoxDecoration(),
            child: SmoothColumn(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getRightForm(smoothFormsController),
                const SmoothSpacer(
                  vertical: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SmoothTextButton(
                          title: smoothFormsController.getFormSubmitStringType(),
                          hPadding: 12.0,
                          vPadding: 10.0,
                          action: () {
                            if (!smoothFormsController.anonymousMode) {
                              smoothFormsController.getFormType() == SmoothFormType.login
                                  ? authController.signIn(smoothFormsController, context)
                                  : authController.register(smoothFormsController, context);
                            } else {
                              authController.signInAnonymously(context, smoothFormsController);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SmoothSpacer(
            vertical: 30.0,
          ),
          Visibility(
            visible: !smoothFormsController.anonymousMode,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SmoothText(
                    text: smoothFormsController.formType.name.replaceFirst(
                      smoothFormsController.formType.name.substring(0, 1),
                      smoothFormsController.formType.name.substring(0, 1).toUpperCase(),
                    ),
                  ),
                  Switch(
                    value: smoothFormsController.toggleForm,
                    inactiveTrackColor: Colors.black.withOpacity(0.3),
                    activeColor: themeController.smoothColor
                        .themeData(!themeController.darkTheme, context)
                        .primaryColor,
                    onChanged: (value) => smoothFormsController.toggleFormType(value),
                  ),
                ],
              ),
            ),
          ),
          buildAnonymousLoginButton(smoothFormsController),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(40.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.095),
          spreadRadius: 0.0,
          blurRadius: 10.0,
        ),
      ],
    );
  }

  Widget buildAnonymousLoginButton(SmoothFormsController smoothFormsController) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SmoothTextButton(
            title: smoothFormsController.anonymousMode
                ? "J'ai un compte SG"
                : "Me connecter anonymement",
            hPadding: 30.0,
            vPadding: 10.0,
            action: () {
              smoothFormsController.toggleAnonymous();
            },
          ),
        ],
      ),
    );
  }

  Widget getRightForm(SmoothFormsController smoothFormsController) {
    switch (smoothFormsController.formType) {
      case SmoothFormType.login:
        return buildLoginForm(smoothFormsController);
      case SmoothFormType.register:
        return buildRegisterForm(smoothFormsController);
      case SmoothFormType.anonymous:
        return buildAnonymousLogin(smoothFormsController);
      default:
        return buildLoginForm(smoothFormsController);
    }
  }

  Widget buildLoginForm(SmoothFormsController smoothFormController) {
    return Form(
      key: smoothFormController.loginFormKey,
      child: SmoothColumn(
        children: [
          SmoothTextFormField(
            controller: smoothFormController.emailController,
            label: 'Email',
            placeHolder: 'votre pseudo',
            validator: (str) =>
                str == null || str.isEmpty ? "Veuillez choisir votre pseudo s'il vous plait" : null,
            onChanged: (value) => smoothFormController.setValue('email', value),
          ),
          SmoothTextFormField(
            obscure: true,
            controller: smoothFormController.passwordController,
            label: 'Mot de passe',
            placeHolder: 'votre mot de passe',
            validator: (str) => str == null || str.isEmpty
                ? "Veuillez saisir votre pot de passe s'il vous plait"
                : null,
            onChanged: (value) => smoothFormController.setValue('password', value),
          ),
        ],
      ),
    );
  }

  Widget buildRegisterForm(SmoothFormsController smoothFormsController) {
    return Form(
      key: smoothFormsController.registerFormKey,
      child: SmoothColumn(
        children: [
          SmoothTextFormField(
            controller: smoothFormsController.pseudoController,
            label: 'Pseudo',
            placeHolder: 'pseudo',
            validator: (value) => value == null || value.isEmpty
                ? "Veuillez choisir un pseudo s'il vous plait"
                : null,
            onChanged: (value) => smoothFormsController.setValue('pseudo', value),
          ),
          SmoothTextFormField(
            controller: smoothFormsController.emailController,
            label: 'Email',
            placeHolder: 'email',
            validator: (value) => value == null || value.isEmpty
                ? "Veuillez saisir votre adresse email s'il vous plait"
                : null,
            onChanged: (value) => smoothFormsController.setValue('email', value),
          ),
          SmoothTextFormField(
            obscure: true,
            controller: smoothFormsController.passwordController,
            label: 'Password',
            placeHolder: 'password',
            validator: (value) => value == null || value.isEmpty
                ? "Veuillez choisir un mot de passe s'il vous plait"
                : null,
            onChanged: (value) => smoothFormsController.setValue('password', value),
          ),
          SmoothTextFormField(
            obscure: true,
            controller: smoothFormsController.confirmPasswordController,
            label: 'Confirm password',
            placeHolder: 'confirm your password',
            validator: (value) => value == null || value.isEmpty
                ? "Veuillez confirmer votre mot de passe s'il vous plait"
                : null,
            onChanged: (value) => smoothFormsController.setValue('confirm-password', value),
          ),
        ],
      ),
    );
  }

  Widget buildAnonymousLogin(SmoothFormsController smoothFormsController) {
    return Form(
      key: smoothFormsController.anonymousFormKey,
      child: SmoothColumn(
        children: [
          SmoothTextFormField(
            controller: smoothFormsController.pseudoController,
            label: 'Pseudo',
            placeHolder: 'pseudo',
            validator: (value) => value == null || value.isEmpty
                ? "Veuillez choisir un pseudo s'il vous plait"
                : null,
            onChanged: (value) => smoothFormsController.setValue('pseudo', value),
          ),
        ],
      ),
    );
  }

  Widget buildBackground({required String path}) {
    return Container(
      padding: EdgeInsets.zero,
      width: SmoothConfig.screenWidth,
      height: SmoothConfig.screenHeight,
      child: Image.asset(
        path,
        width: SmoothConfig.screenWidth,
        height: SmoothConfig.screenHeight,
        fit: BoxFit.cover,
      ),
    );
  }
}
