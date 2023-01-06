import 'package:flutter/material.dart';
import 'package:smooth_game_app/core/common/smooth_handle_error.dart';
import 'package:smooth_game_app/core/models/smooth_game.dart';
import 'package:smooth_game_app/core/models/smooth_user.dart';
import 'package:smooth_game_app/core/services/smooth_users_service.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';

class BuildGameCreatedByUserWidget extends StatelessWidget {
  final SmoothGame game;

  const BuildGameCreatedByUserWidget({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SmoothText(text: 'créée par :'),
          FutureBuilder<SmoothUser?>(
            future: SmoothUsersService().getUserById(game.createdBy),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(color: Colors.yellow);
              }

              if (snapshot.hasError) {
                SmoothHandleError.classicOne(
                  error: 'Impossible de récupérer l\'hote de la partie',
                  className: 'SmoothGameWidget',
                  line: 119,
                );
              }

              final hostUser = snapshot.data;
              return hostUser != null
                  ? SmoothText(
                      text: hostUser.pseudo,
                      fontSize: 12.0,
                      textColor: Colors.deepOrangeAccent,
                    )
                  : Container();
            },
          ),
        ],
      ),
    );
  }
}
