import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/common/smooth_handle_error.dart';
import 'package:smooth_game_app/core/common/smooth_loader.dart';
import 'package:smooth_game_app/core/models/smooth_user.dart';
import 'package:smooth_game_app/core/services/smooth_users_service.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';

class SmoothUserCardWidget extends StatelessWidget {
  final String? userId;
  const SmoothUserCardWidget({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildUserCardWidget();
  }

  Widget buildUserCardWidget() {
    return FadeIn(
      duration: const Duration(seconds: 1),
      child: Container(
        width: 250.0,
        height: 60.0,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 3.0,
          vertical: 2.0,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 30.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(SmoothConfig.screenWidth!),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.08),
              spreadRadius: 4.0,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: FaIcon(
            FontAwesomeIcons.checkDouble,
            color: Colors.green,
          ),
        ),
        if (userId != null && userId!.isNotEmpty)
          FutureBuilder<SmoothUser>(
              future: SmoothUsersService().getUserById(userId!),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SmoothLoader();
                }
                if (snapshot.hasError) {
                  return SmoothHandleError.classicOne(
                      className: "smooth_user_card_widget", line: 72, error: snapshot.error);
                }

                final usr = snapshot.data;

                return usr != null
                    ? Expanded(
                        child: SmoothText(
                          text: "${snapshot.data!.pseudo} est prêt(e)",
                          textAlign: TextAlign.end,
                          style: FontStyle.italic,
                        ),
                      )
                    : Container();
              })
        else
          const Expanded(
            child: SmoothText(
              text: "Jubilette est prêt",
              textAlign: TextAlign.end,
              style: FontStyle.italic,
            ),
          ),
        const AdvancedAvatar(
          size: 45.0,
          child: FaIcon(
            FontAwesomeIcons.user,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
