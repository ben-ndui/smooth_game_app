import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/common/smooth_dialog.dart';
import 'package:smooth_game_app/core/controllers/smooth_auth_controller.dart';
import 'package:smooth_game_app/core/controllers/smooth_forms_controller.dart';
import 'package:smooth_game_app/core/controllers/smooth_game_controller.dart';
import 'package:smooth_game_app/core/controllers/smooth_theme_controller.dart';
import 'package:smooth_game_app/core/enums/game_enums.dart';
import 'package:smooth_game_app/core/models/smooth_user.dart';
import 'package:smooth_game_app/core/widgets/smooth_container.dart';
import 'package:smooth_game_app/core/widgets/smooth_custom_appbar.dart';
import 'package:smooth_game_app/core/widgets/smooth_list_view.dart';
import 'package:smooth_game_app/core/widgets/smooth_scaffold.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';
import 'package:smooth_game_app/core/widgets/smooth_text_button.dart';
import 'package:smooth_game_app/core/widgets/smooth_textform_field.dart';
import 'package:smooth_game_app/core/widgets/smooth_users_slider.dart';

class CreateGameScreen extends StatefulWidget {
  const CreateGameScreen({Key? key}) : super(key: key);

  @override
  State<CreateGameScreen> createState() => _CreateGameScreenState();
}

class _CreateGameScreenState extends State<CreateGameScreen> {
  @override
  Widget build(BuildContext context) {
    return SmoothScaffold(
      body: buildBody(),
    );
  }

  buildBody() {
    return Consumer<SmoothGameController>(
      builder: (context, gameController, child) {
        return SmoothContainer(
          width: SmoothConfig.screenWidth,
          height: SmoothConfig.screenHeight,
          child: SmoothListView(
            children: [
              SmoothCustomAppBar(type: SmoothCustomAppBarType.settings).build(
                title: "Création de partie",
              ),
              buildCreateGameForm(gameController, context),
            ],
          ),
        );
      },
    );
  }

  Widget buildCreateGameForm(SmoothGameController gameController, BuildContext context) {
    return Consumer<SmoothFormsController>(
      builder: (context, smoothFormsController, child) {
        return Form(
          key: gameController.createGameFormKey,
          child: Column(
            children: [
              Consumer<SmoothAuthController>(
                builder: (context, authController, child) {
                  gameController.initPlayers(authController.currentUser);
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SmoothUsersSlider(
                        users: gameController.players,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SmoothText(
                                text: gameController.gameStatus.name.replaceFirst(
                                  gameController.gameStatus.name.substring(0, 1),
                                  gameController.gameStatus.name.substring(0, 1).toUpperCase(),
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                              Switch(
                                value: gameController.isOnline,
                                onChanged: (value) => gameController.toggleGameStatus(value),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: !gameController.isOnline,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SmoothTextButton(
                                    title: "Ajouter un joueur",
                                    action: () {
                                      SmoothDialog(
                                        context: context,
                                        title: "Ajouter un joueur",
                                        height: 550.0,
                                        body: SmoothListView(
                                          children: [
                                            SmoothTextFormField(
                                              controller: smoothFormsController.pseudoController,
                                              label: 'Pseudo',
                                              placeHolder: 'pseudo du joueur',
                                              onChanged: (value) =>
                                                  smoothFormsController.setValue('pseudo', value),
                                            ),
                                            SmoothTextButton(
                                              hPadding: 10.0,
                                              title: 'Ajouter',
                                              action: () {
                                                SmoothUser usr = SmoothUser(
                                                  userId: smoothFormsController.pseudo.hashCode
                                                      .toString(),
                                                  pseudo: smoothFormsController.pseudo!,
                                                );
                                                gameController.addPlayer(usr);
                                                smoothFormsController.reset();
                                              },
                                            )
                                          ],
                                        ),
                                      ).build();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
              gameChoice(gameController),
              buildCustomSpacer(),
              buildTextFormField(gameController),
              buildCustomSpacer(),
              buildGamePlayerNumber(),
              buildSubmitButton(gameController, context),
            ],
          ),
        );
      },
    );
  }

  Widget buildTextFormField(SmoothGameController gameController) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: SmoothTextFormField(
        controller: gameController.gameNameController,
        onChanged: (val) => gameController.setValue('gameName', val),
        validator: (val) {
          if (val == null || val.isEmpty) {
            gameController.setErrorMessage('Please define name for this game');
            return gameController.errorMessage;
          } else {
            return null;
          }
        },
        label: 'Nom de la partie',
        placeHolder: 'ex: partie détente',
      ),
    );
  }

  Widget buildSubmitButton(SmoothGameController gameController, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () => gameController.createGame(context),
        style: TextButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 7.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SmoothConfig.screenWidth!),
          ),
        ),
        child: const SmoothText(
          text: "Créer une partie",
          textColor: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  SizedBox buildCustomSpacer() {
    return const SizedBox(
      height: 10.0,
    );
  }

  Widget buildGamePlayerNumber() {
    return Consumer<SmoothThemeController>(
      builder: (context, themeController, child) {
        return Consumer<SmoothGameController>(
          builder: (context, gameController, child) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SmoothText(
                  textAlign: TextAlign.center,
                  hPadding: 30.0,
                  text: "Nombre de joueur",
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                NumberPicker(
                  value: gameController.gameStatus == SmoothGameStatus.online
                      ? gameController.smoothEngine.maxPlayer
                      : gameController.players.length,
                  minValue: 1,
                  maxValue: gameController.gameStatus == SmoothGameStatus.online
                      ? gameController.smoothEngine.getMaxPlayer()
                      : gameController.players.length,
                  selectedTextStyle: TextStyle(
                    color: themeController.smoothColor
                        .themeData(!themeController.darkTheme, context)
                        .primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                  onChanged: (value) {
                    if (gameController.gameStatus == SmoothGameStatus.online) {
                      gameController.updateMaxVavue(value);
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget gameChoice(SmoothGameController gameController) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SmoothText(
          hPadding: 30.0,
          text: "A quoi veux-tu jouer ?",
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: buildChoiceButton(
                  title: 'Gabo',
                  isSelected: gameController.gameSelected,
                  onTap: () {
                    setState(() {
                      gameController.chooseGameType(
                        SmoothGameType.gabo,
                        context,
                      );
                    });
                  },
                ),
              ),
              Expanded(
                child: buildChoiceButton(
                  title: 'Pyramid',
                  isSelected: !gameController.gameSelected,
                  onTap: () {
                    setState(() {
                      gameController.chooseGameType(
                        SmoothGameType.pyramid,
                        context,
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildChoiceButton({required String title, void Function()? onTap, bool? isSelected}) {
    return Consumer<SmoothThemeController>(
      builder: (context, themeController, child) {
        return GestureDetector(
          onTap: onTap,
          child: ZoomIn(
            duration: const Duration(seconds: 1),
            delay: const Duration(milliseconds: 200),
            child: Container(
              height: 80.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              margin: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                  color: themeController.smoothColor.themeData(isSelected!, context).primaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                      color:
                          themeController.smoothColor.themeData(isSelected, context).primaryColor,
                      width: 2.0)),
              child: SmoothText(
                text: title,
                textColor: themeController.smoothColor.themeData(!isSelected, context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
