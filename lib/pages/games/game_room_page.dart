import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/common/smooth_handle_error.dart';
import 'package:smooth_game_app/core/controllers/smooth_game_controller.dart';
import 'package:smooth_game_app/core/models/smooth_game.dart';
import 'package:smooth_game_app/core/services/smooth_game_service.dart';
import 'package:smooth_game_app/core/widgets/smooth_custom_appbar.dart';
import 'package:smooth_game_app/core/widgets/smooth_list_view.dart';
import 'package:smooth_game_app/core/widgets/smooth_scaffold.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';
import 'package:smooth_game_app/core/widgets/smooth_text_button.dart';
import 'package:smooth_game_app/core/widgets/smooth_user_card_widget.dart';
import 'package:smooth_game_app/core/widgets/smooth_user_ready_message_widget.dart';
import 'package:smooth_game_app/core/widgets/smooth_users_slider.dart';

class GameRoomPage extends StatefulWidget {
  const GameRoomPage({Key? key}) : super(key: key);

  @override
  State<GameRoomPage> createState() => _GameRoomPageState();
}

class _GameRoomPageState extends State<GameRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SmoothGameController>(
      builder: (context, gameController, child) {
        return SmoothScaffold(
          body: SmoothListView(
            children: [
              SmoothCustomAppBar(type: SmoothCustomAppBarType.gameRoom).build(
                title: "Waiting room",
              ),
              buildPlayersStream(gameController),
              buildRoomUserMessage(gameController),
              buildUsersReady(gameController),
            ],
          ),
          floatingActionButton: buildFloatingActionButton(context, gameController),
        );
      },
    );
  }

  Widget buildRoomUserMessage(SmoothGameController gameController) {
    return FadeIn(
      child: Column(
        children: [
          SmoothText(
            textColor: Colors.black.withOpacity(0.5),
            text: "Vous verrez ici tous les joueurs prêt pour commencer ! Sous la forme suivante",
            textAlign: TextAlign.center,
            style: FontStyle.italic,
          ),
          SmoothUserReadyMessageWidget(
            visible: !gameController.showSpecimen,
            showSpecimen: gameController.showSpecimen,
          ),
        ],
      ),
    );
  }

  Widget buildPlayersStream(SmoothGameController gameController) {
    return StreamBuilder<SmoothGame>(
      stream: SmoothGameService().getGameById(gameController.selectedGame!.gameId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        if (snapshot.hasError) {
          SmoothHandleError.classicOne(
              className: 'Game Room', line: 33, error: snapshot.error.toString());
        }

        final game = snapshot.data;

        return game != null && game.playersList.isNotEmpty
            ? SmoothUsersSlider(
                users: game.playersList,
              )
            : Container();
      },
    );
  }

  Widget buildUsersReady(SmoothGameController gameController) {
    return StreamBuilder<SmoothGame>(
        stream: SmoothGameService().getGameById(gameController.selectedGame!.gameId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          if (snapshot.hasError) {
            return SmoothHandleError.classicOne(
                className: 'className', line: 95, error: snapshot.error.toString());
          }

          final game = snapshot.data;

          return Visibility(
            visible: game != null && game.readyPlayersIdsList.isNotEmpty,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: game!.readyPlayersIdsList.length,
              physics: const ScrollPhysics(),
              itemBuilder: (ctx, index) {
                final userId = game.readyPlayersIdsList[index];
                return SmoothUserCardWidget(
                  userId: userId,
                );
              },
            ),
          );
        });
  }

  Widget buildFloatingActionButton(BuildContext context, SmoothGameController gameController) {
    return StreamBuilder<SmoothGame>(
        stream: SmoothGameService().getGameById(gameController.selectedGame!.gameId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SmoothUserCardWidget();
          }
          if (snapshot.hasError) {
            return SmoothHandleError.classicOne(
                className: 'className', line: 92, error: snapshot.error.toString());
          }

          final game = snapshot.data;

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SmoothTextButton(
                hPadding: 10.0,
                vPadding: 6.0,
                bgColor: gameController.isUserReady ? Colors.red : Colors.green,
                title: gameController.isUserReady ? "Je suis pas prêt(e)" : "Je suis prêt(e)",
                action: () {
                  gameController.iamReady(game!);
                },
              ),
              Visibility(
                visible: gameController.isUserReady &&
                    game!.createdBy.contains(
                      gameController.currentUser!.userId,
                    ),
                child: SmoothTextButton(
                  hPadding: 10.0,
                  vPadding: 6.0,
                  bgColor: Colors.blue,
                  title: "Commencer",
                  action: () {
                    gameController.startTheGame(context, game!);
                  },
                ),
              ),
            ],
          );
        });
  }
}
