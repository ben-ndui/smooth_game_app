import 'package:flutter/cupertino.dart';
import 'package:smooth_game_app/core/enums/smooth_form.dart';

class SmoothFormsController extends ChangeNotifier {
  SmoothFormType formType = SmoothFormType.login;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController playerNbController = TextEditingController();

  String? name;
  String? lName;
  String email = "contact@smoothandesign.com";
  String password = "Smooth2022+";
  String? confirmPassword;
  String? phone;
  String? pseudo;

  var loginFormKey = GlobalKey<FormState>();
  var registerFormKey = GlobalKey<FormState>();
  var anonymousFormKey = GlobalKey<FormState>();

  bool toggleForm = true;

  bool anonymousMode = false;

  void setValue(String variableName, dynamic value) {
    switch (variableName) {
      case 'email':
        email = value;
        break;
      case 'password':
        password = value;
        break;
      case 'confirm-password':
        confirmPassword = value;
        break;
      case 'phone':
        phone = value;
        break;
      case 'pseudo':
        pseudo = value;
        break;
      case 'name':
        name = value;
        break;
      case 'lName':
        lName = value;
        break;
      default:
        break;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    pseudoController.dispose();
    passwordController.dispose();
    titleController.dispose();
    playerNbController.dispose();

    email = "";
    password = "";
    phone = null;
    pseudo = null;
  }

  void toggleFormType(bool value) {
    toggleForm = value;
    notifyListeners();
    setFormType();
  }

  String getFormSubmitStringType() {
    switch (formType) {
      case SmoothFormType.login:
        return 'Me connecter';
      case SmoothFormType.register:
        return "Je m'inscris";
      case SmoothFormType.update:
        return "Mettre à jour";
      case SmoothFormType.delete:
        return "Supprimer";
      default:
        return "Me connecter";
    }
  }

  void setFormType() {
    switch (toggleForm) {
      case true:
        formType = SmoothFormType.login;
        break;
      case false:
        formType = SmoothFormType.register;
        break;
      default:
        formType = SmoothFormType.login;
        break;
    }
    notifyListeners();
  }

  SmoothFormType getFormType() {
    return formType;
  }

  void toggleAnonymous() {
    anonymousMode = !anonymousMode;
    notifyListeners();
    if (anonymousMode == true) {
      formType = SmoothFormType.anonymous;
    } else {
      formType = SmoothFormType.login;
    }
    notifyListeners();
  }

  void reset() {
    emailController.clear();
    pseudoController.clear();
    passwordController.clear();
    titleController.clear();
    playerNbController.clear();

    email = "";
    password = "";
    phone = null;
    pseudo = null;

    notifyListeners();
  }
}
