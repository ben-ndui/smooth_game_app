import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/common/smooth_dialog.dart';
import 'package:smooth_game_app/core/common/smooth_tools.dart';
import 'package:smooth_game_app/core/controllers/smooth_game_controller.dart';
import 'package:smooth_game_app/core/enums/game_enums.dart';
import 'package:smooth_game_app/core/models/smooth_game.dart';
import 'package:smooth_game_app/core/widgets/build_game_created_by_user_widget.dart';
import 'package:smooth_game_app/core/widgets/smooth_icon.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';
import 'package:smooth_game_app/core/widgets/smooth_text_button.dart';

class SmoothGameWidget extends StatelessWidget {
  final SmoothGame game;

  const SmoothGameWidget({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildCardGameItem(context);
  }

  Widget buildCardGameItem(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      width: SmoothConfig.screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 0.0, blurRadius: 10.0),
        ],
      ),
      child: Row(
        children: [
          buildCardLeftBody(context),
          buildCardRightBody(context),
        ],
      ),
    );
  }

  Widget buildCardRightBody(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          buildEyeButton(context),
          buildCardBody(),
          BuildGameCreatedByUserWidget(game: game)
        ],
      ),
    );
  }

  Widget buildEyeButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SmoothIcon(
            icon: FontAwesomeIcons.eye,
            onPressed: () {
              buildGamePlayersListPopup(context).build();
            },
          ),
        ],
      ),
    );
  }

  SmoothDialog buildGamePlayersListPopup(BuildContext context) {
    return SmoothDialog(
        context: context,
        title: 'Joueurs connecté',
        body: Container(
          color: Colors.white,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const ScrollPhysics(),
            children: game.playersList
                .map((player) => Card(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          SmoothConfig.screenWidth!,
                        ),
                      ),
                      color: Colors.white,
                      child: ListTile(
                        leading: AdvancedAvatar(
                          size: 45.0,
                          name: player.pseudo,
                        ),
                        title: SmoothText(
                          text: player.pseudo,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ));
  }

  Widget buildCardLeftBody(BuildContext context) {
    return Consumer<SmoothGameController>(
      builder: (context, gameController, child) {
        return Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            height: SmoothConfig.screenHeight,
            decoration: buildBoxDecoration(),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: SmoothConfig.screenWidth,
                  height: SmoothConfig.screenHeight,
                  padding: EdgeInsets.zero,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                        ),
                        child: Image.asset(
                          'assets/images/${game.gameType == SmoothGameType.pyramid ? 'pyramid.jpg' : 'gabo.jpg'}',
                          width: SmoothConfig.screenWidth,
                          height: SmoothConfig.screenHeight,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: SmoothConfig.screenWidth,
                        height: SmoothConfig.screenHeight,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                SmoothTextButton(
                  title: "Rejoindre",
                  vPadding: 0.0,
                  hPadding: 1.0,
                  action: () {
                    gameController.selectGame(game);
                    gameController.joinGame(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCardBody() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCardGameItemField(val: game.gameType.name, isTitle: true),
          buildCardGameItemField(
            val: 'Partie créée il y a ${SmoothTools().getFormatGameCreatedDate(game.date)}',
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.grey.withOpacity(0.3),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        bottomLeft: Radius.circular(30.0),
      ),
    );
  }

  Widget buildCardGameItemField({required String val, bool isTitle = false}) {
    return Expanded(
      child: SmoothText(
        text: isTitle
            ? val.replaceFirst(val.substring(0, 1), val.substring(0, 1).toUpperCase())
            : val,
        fontWeight: isTitle ? FontWeight.bold : null,
        fontSize: isTitle ? 20.0 : null,
        vPadding: 2.0,
      ),
    );
  }
}
