import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/controllers/smooth_theme_controller.dart';
import 'package:smooth_game_app/core/models/smooth_user.dart';

class SmoothUsersSlider extends StatelessWidget {
  final List<SmoothUser> users;

  const SmoothUsersSlider({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildParticipantsWidget();
  }

  Widget buildParticipantsWidget() {
    return Consumer<SmoothThemeController>(
      builder: (context, themeController, child) {
        return Container(
          color: themeController.smoothColor
              .themeData(themeController.darkTheme, context)
              .primaryColor,
          child: CarouselSlider.builder(
            itemCount: users.length,
            itemBuilder: (ctx, index, val) {
              final user = users[index];

              return AdvancedAvatar(
                name: user.pseudo,
                statusColor: user.status.getUserStatus(),
                statusAngle: 45,
              );
            },
            options: CarouselOptions(
              autoPlay: users.length > 1 ? true : false,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              initialPage: 2,
            ),
          ),
        );
      },
    );
  }
}
