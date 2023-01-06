import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/controllers/smooth_theme_controller.dart';
import 'package:smooth_game_app/core/widgets/smooth_icon.dart';

class SmoothTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? icon;
  final String label;
  final String placeHolder;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;
  final bool obscure;

  const SmoothTextFormField({
    Key? key,
    this.icon,
    required this.label,
    required this.placeHolder,
    this.validator,
    this.maxLines = 1,
    this.controller,
    this.onChanged,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SmoothThemeController>(
      builder: (context, themeController, child) {
        return Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          child: TextFormField(
            obscureText: obscure,
            controller: controller,
            textAlign: TextAlign.center,
            validator: validator,
            onChanged: onChanged,
            maxLines: maxLines,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
              color: themeController.smoothColor
                  .themeData(!themeController.darkTheme, context)
                  .primaryColor,
            ),
            decoration: InputDecoration(
              alignLabelWithHint: true,
              filled: themeController.smoothColor
                  .themeData(!themeController.darkTheme, context)
                  .inputDecorationTheme
                  .filled,
              fillColor: themeController.smoothColor
                  .themeData(!themeController.darkTheme, context)
                  .inputDecorationTheme
                  .fillColor,
              icon: icon != null ? SmoothIcon(icon: icon!) : null,
              labelText: label,
              hintText: placeHolder,
              hintStyle: themeController.smoothColor
                  .themeData(themeController.darkTheme, context)
                  .inputDecorationTheme
                  .hintStyle,
              labelStyle: themeController.smoothColor
                  .themeData(themeController.darkTheme, context)
                  .inputDecorationTheme
                  .labelStyle,
              border: themeController.smoothColor
                  .themeData(themeController.darkTheme, context)
                  .inputDecorationTheme
                  .border!,
            ),
          ),
        );
      },
    );
  }
}
