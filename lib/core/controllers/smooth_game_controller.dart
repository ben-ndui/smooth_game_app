import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/common/engines/smooth_engine.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/common/smooth_constants.dart';
import 'package:smooth_game_app/core/common/smooth_dialog.dart';
import 'package:smooth_game_app/core/common/smooth_handle_error.dart';
import 'package:smooth_game_app/core/common/smooth_snackbar.dart';
import 'package:smooth_game_app/core/controllers/smooth_auth_controller.dart';
import 'package:smooth_game_app/core/enums/game_enums.dart';
import 'package:smooth_game_app/core/models/smooth_game.dart';
import 'package:smooth_game_app/core/models/smooth_user.dart';
import 'package:smooth_game_app/core/services/smooth_game_message_service.dart';
import 'package:smooth_game_app/core/services/smooth_game_service.dart';
import 'package:smooth_game_app/core/widgets/smooth_list_view.dart';
import 'package:smooth_game_app/core/widgets/smooth_spacer.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';
import 'package:smooth_game_app/core/widgets/smooth_text_button.dart';
import 'package:smooth_game_app/router/router.gr.dart';

class SmoothGameController extends ChangeNotifier {
  //Game variables param
  final SmoothGameService _gameService = SmoothGameService();
  final SmoothGameMessageService _gameGameMessageService = SmoothGameMessageService();

  SmoothEngine smoothEngine = SmoothEngine();

  SmoothGameStatus gameStatus = SmoothGameStatus.online;

  int currentMaxPlayer = 1;

  bool showSpecimen = true;

  bool isUserReady = true;

  get getGameService => _gameService;

  //TextEditingController
  TextEditingController gameNameController = TextEditingController();

  //variables
  SmoothGame? selectedGame;

  SmoothUser? currentUser;
  SmoothGameType gameType = SmoothGameType.gabo;
  List<SmoothUser> players = [];

  String? createdBy;
  DateTime? date;
  String? gameName;
  String errorMessage = "";

  bool gameSelected = true;
  bool isOnline = true;

  var createGameFormKey = GlobalKey<FormState>();

  // Show pop on create screen each time user shoose a game
  bool showRulesPopup = true;

  void toggleGameStatus(bool value) {
    isOnline = value;
    notifyListeners();
    switch (isOnline) {
      case true:
        gameStatus = SmoothGameStatus.online;
        break;
      case false:
        gameStatus = SmoothGameStatus.local;
        break;
    }
    notifyListeners();
  }

  void updateRulesPopup() {
    showRulesPopup = !showRulesPopup;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void createGame(BuildContext context) {
    final currUser = context.read<SmoothAuthController>().currentUser;
    if (createGameFormKey.currentState!.validate()) {
      SmoothDialog(
        context: context,
        title: "Création de partie",
        vMargin: 250.0,
        height: 850.0,
        body: SmoothListView(
          children: [
            SmoothText(text: "Vous êtes sur le point de créer une partie de ${gameType.name}"),
            const SmoothText(
              text: "Continuer ?",
              fontWeight: FontWeight.bold,
              vPadding: 18.0,
            ),
            SmoothTextButton(
              title: "Créer",
              action: () {
                if (gameStatus == SmoothGameStatus.online) {
                  final gameId = _gameService.getNewId();
                  final game = SmoothGame(
                    gameId: gameId,
                    createdBy: currUser!.userId,
                    date: DateTime.now(),
                    gameType: gameType,
                    playersList: players,
                    gameSettingsId: '',
                  );
                  var res = _gameService.createGame(game);

                  if (res) {
                    SmoothSnackBar(context: context).build(content: "Création de partie réussi !");
                    selectGame(game);
                    context.router.push(const GameRoom());
                  } else {
                    SmoothSnackBar(context: context).build(
                        content:
                            "Une erreur s'est produite lors de l'initialisation de la partie !");
                    print(game.toJson());
                  }
                }
              },
              hPadding: 20.0,
            ),
          ],
        ),
      ).build();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SmoothConfig.screenWidth!),
          ),
          content: SmoothText(
            text: errorMessage,
            textColor: Colors.white,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  void updateGame() {
    final game = SmoothGame(
      gameId: selectedGame!.gameId,
      createdBy: createdBy ?? selectedGame!.createdBy,
      date: date ?? selectedGame!.date,
      gameType: gameType,
      playersList: players,
      gameSettingsId: selectedGame?.gameSettingsId ?? "",
    );
    _gameService.updateGame(game);
    notifyListeners();
  }

  void joinGame(BuildContext context) {
    if (currentUser != null) {
      if (!selectedGame!.playersList.any((elem) => elem.userId.contains(currentUser!.userId))) {
        final res = selectedGame!.addPlayer(currentUser!);
        notifyListeners();
        if (res) {
          _gameService.updateGame(selectedGame!);
          notifyListeners();
          context.router.push(const GameRoom());
        } else {
          SmoothSnackBar(context: context).build(
              content: "Impossible de rejoindre la partie la partie en cours",
              align: TextAlign.center);
        }
      } else {
        context.router.push(const GameRoom());
      }
    } else {
      SmoothSnackBar(context: context).build(
        content: "Veuillez  s'il vous plait vous identifier avant de rejoindre une partie",
        align: TextAlign.center,
      );
    }
  }

  void leaveGame(BuildContext context, SmoothGame game) {
    if (!game.createdBy.contains(currentUser!.userId)) {
      final res = game.removePlayer(currentUser);
      notifyListeners();
      if (res) {
        _gameService.updateGame(game);
        togglePlayerStatus();
        context.router.push(const AuthRedirection());
      }
    } else {
      SmoothDialog(
        title: 'Quitter',
        context: context,
        height: 500.0,
        body: Column(
          children: [
            const SmoothText(
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
              textColor: Colors.redAccent,
              text:
                  "Vous êtes l'hôte de cette partie, en quittant cette partie, vous supprimerez ce jeu du FeedGame ! Voulez-vous continuez ?",
            ),
            SmoothTextButton(
              title: 'Oui continuer et supprimer cette partie',
              bgColor: Colors.redAccent,
              action: () {},
            )
          ],
        ),
      ).build();
    }
    notifyListeners();
  }

  //Setters
  void chooseGameType(SmoothGameType type, BuildContext context) {
    gameType = type;
    notifyListeners();
    switch (gameType) {
      case SmoothGameType.gabo:
        gameSelected = true;
        break;
      case SmoothGameType.pyramid:
        gameSelected = false;
        break;
      default:
        gameSelected = true;
        break;
    }
    notifyListeners();
    smoothEngine.initEngine(gameType: gameType);
    notifyListeners();
    if (showRulesPopup) {
      buildRulesPopup(context).build();
    }
  }

  SmoothDialog buildRulesPopup(BuildContext context) {
    return SmoothDialog(
      context: context,
      title:
          "${gameType.name.replaceFirst(gameType.name[0], gameType.name[0].toUpperCase())} rules",
      body: StatefulBuilder(builder: (context, setState) {
        return SmoothListView(
          children: [
            SmoothListView(
              children: smoothEngine.sgEngine.rules().map((e) => e).toList(),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  updateRulesPopup();
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                      value: !showRulesPopup,
                      onChanged: (val) {
                        setState(() {
                          updateRulesPopup();
                        });
                      }),
                  const SmoothText(
                    text: "Je ne souhaite plus voir ce message",
                    style: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    hPadding: 0.0,
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  //Dispose
  @override
  void dispose() {
    super.dispose();
  }

  void addPlayer(SmoothUser? usr) {
    if (!players.any((element) => element.pseudo.contains(usr!.pseudo))) {
      players.add(usr!);
    }
    gameStatus == SmoothGameStatus.local ? updateEngineMaxPlayer(players.length) : null;
  }

  void setValue(String s, dynamic val) {
    switch (s) {
      case 'gameName':
        gameName = val;
        break;
      default:
        break;
    }
    notifyListeners();
  }

  void updateEngineMaxPlayer(int value) {
    smoothEngine.updateMaxPlayer(value);
  }

  void initPlayers(SmoothUser? currentUsr) {
    if (currentUsr != null) {
      addPlayer(currentUsr);
    }
  }

  void updateMaxVavue(int value) {
    smoothEngine.updateMaxVavue(value);
    notifyListeners();
  }

  void selectGame(SmoothGame game) {
    selectedGame = game;
    notifyListeners();
  }

  void initCurrentUser(SmoothUser? usr) {
    currentUser = usr;
    notifyListeners();
  }

  void togglePlayerStatus() {
    isUserReady = !isUserReady;
    notifyListeners();
  }

  void iamReady(SmoothGame gamee) {
    togglePlayerStatus();
    if (isUserReady) {
      // récuperer tout les joueur dont l'ID apparait dans le tableau des users ready
      gamee.ready(currentUser!.userId);

      final game = SmoothGame(
        gameId: gamee.gameId,
        createdBy: gamee.createdBy,
        date: gamee.date,
        gameType: gamee.gameType,
        playersList: gamee.playersList,
        gameSettingsId: gamee.gameSettingsId,
        readyPlayersIdsList: gamee.readyPlayersIdsList,
      );
      toggleShowSpecimen();
      _gameService.updateGame(game);
      notifyListeners();
    } else {
      gamee.notReady(currentUser!.userId);
      notifyListeners();

      final game = SmoothGame(
        gameId: gamee.gameId,
        createdBy: gamee.createdBy,
        date: gamee.date,
        gameType: gamee.gameType,
        playersList: gamee.playersList,
        gameSettingsId: gamee.gameSettingsId,
        readyPlayersIdsList: gamee.readyPlayersIdsList,
      );
      toggleShowSpecimen();
      _gameService.updateGame(game);
      notifyListeners();
    }
  }

  void toggleShowSpecimen() {
    showSpecimen = !showSpecimen;
    notifyListeners();
  }

  void startTheGame(BuildContext context, SmoothGame gamee) {
    if (gamee.readyPlayersIdsList.isEmpty) {
      SmoothDialog(
        context: context,
        body: const SmoothListView(
          children: [
            SmoothText(
              text: "Personne n'est prêt, la partie ne peut donc pas commencer",
            ),
          ],
        ),
      ).build();
    } else {
      SmoothDialog(
        context: context,
        height: 500.0,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SmoothText(
                text: "Commencer la partie ?",
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                fontSize: 18.0,
                vPadding: 0.0,
              ),
              SmoothText(
                text:
                    "( Il y a actuellement ${gamee.readyPlayersIdsList.length} joueur(s) prêt ! )",
                textAlign: TextAlign.center,
                fontSize: 18.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SmoothTextButton(
                        title: "Oui",
                        action: () {
                          begin(context: context, game: gamee);
                        },
                        vPadding: 8.0,
                        bgColor: Colors.green,
                      ),
                    ),
                    const SmoothSpacer(
                      horizontal: 10.0,
                    ),
                    Expanded(
                      child: SmoothTextButton(
                        title: "Non",
                        action: () => context.router.pop(),
                        vPadding: 8.0,
                        bgColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ).build();
    }
  }

  void begin({required BuildContext context, required SmoothGame game}) {
    try {
      game.deck.addAll(SmoothConstants.gameCards);
      _gameService.updateGame(game);
      _gameService.startGame(
          state: SGameState.start, to: SmoothGameMessageType.broadcast, game: game);
      notifyListeners();
    } catch (e) {
      SmoothHandleError.classicOne(
          className: 'smooth_game_controller', line: 460, error: e.toString());
    }
  }

  // get user who have to play
  // @param [data] : this parameter is dynanmic so it can takes any value like user id to compare to the current user which supposed to play
  void play({required BuildContext context, required SmoothGame game, required data}) {
    manageSteps(game);
  }

  void manageSteps(SmoothGame game) {
    for (var step in game.steps) {
      switch (step) {
        case SGameStep.step1:
          // TODO: Handle this case.
          break;
        case SGameStep.step2:
          // TODO: Handle this case.
          break;
        case SGameStep.step3:
          // TODO: Handle this case.
          break;
        case SGameStep.step4:
          // TODO: Handle this case.
          break;
        case SGameStep.step5:
          // TODO: Handle this case.
          break;
      }
    }
  }

  void pass({required BuildContext context, required SmoothGame game, required data}) {
    manageSteps(game);
  }

  void listenMessages({required BuildContext context}) {
    _gameGameMessageService.listen(context: context);
  }
}
