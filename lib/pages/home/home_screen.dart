import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/common/smooth_config.dart';
import 'package:smooth_game_app/core/common/smooth_loader.dart';
import 'package:smooth_game_app/core/controllers/smooth_auth_controller.dart';
import 'package:smooth_game_app/core/controllers/smooth_theme_controller.dart';
import 'package:smooth_game_app/core/models/smooth_game.dart';
import 'package:smooth_game_app/core/services/smooth_game_service.dart';
import 'package:smooth_game_app/core/widgets/smooth_container.dart';
import 'package:smooth_game_app/core/widgets/smooth_custom_appbar.dart';
import 'package:smooth_game_app/core/widgets/smooth_game_widget.dart';
import 'package:smooth_game_app/core/widgets/smooth_icon.dart';
import 'package:smooth_game_app/core/widgets/smooth_list_view.dart';
import 'package:smooth_game_app/core/widgets/smooth_scaffold.dart';
import 'package:smooth_game_app/core/widgets/smooth_text.dart';
import 'package:smooth_game_app/router/router.gr.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    SmoothConfig().init(context);
    return Consumer<SmoothThemeController>(
      builder: (context, themeController, child) {
        return SmoothScaffold(
          drawer: buildSmoothDrawer(themeController),
          body: buildBody(context),
          floatingActionButton: FloatingActionButton(
            backgroundColor: themeController.smoothColor
                .themeData(!themeController.darkTheme, context)
                .primaryColor,
            onPressed: () {
              final authController = context.read<SmoothAuthController>();

              authController.currentUser != null
                  ? context.router.push(const CreateGame(),
                      onFailure: (failure) => context.router.push(const NotFound()))
                  : context.router.push(const SmoothLogin());
            },
            child: const SmoothIcon(icon: FontAwesomeIcons.plus),
          ),
        );
      },
    );
  }

  Drawer buildSmoothDrawer(SmoothThemeController themeController) {
    return Drawer(
      child: SmoothListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: themeController.smoothColor.primary,
            ),
            child: const Center(
              child: SmoothText(
                text: "Smooth Games",
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
          SmoothListView(
            children: [
              ListTile(
                leading: const SmoothIcon(
                  icon: FontAwesomeIcons.a,
                  fillBackground: false,
                ),
                title: const SmoothText(
                  text: "Admin Settings",
                ),
                onTap: () {
                  context.router.push(const SmoothAdminSettingsScreen());
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return SmoothListView(
      children: [
        SmoothCustomAppBar().build(title: "Smooth Game"),
        buildSmoothSpacer(vertical: 30.0),
        buildHomeMessage(),
        buildGameListView(),
        SmoothListView(
          children: [
            SmoothText(
              text: "Game history",
              fontSize: 20.0,
              hPadding: 30.0,
              textColor: Colors.black.withOpacity(0.3),
              fontWeight: FontWeight.bold,
            ),
            SmoothText(
              text: "Nombre de partie auxquels vous avez participé !",
              fontSize: 14.0,
              vPadding: 0.0,
              hPadding: 30.0,
              textColor: Colors.black.withOpacity(0.5),
              style: FontStyle.italic,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildHomeMessage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        SmoothText(
          text: "Crée ou",
          fontSize: 20.0,
          hPadding: 0.0,
          vPadding: 0.0,
          textAlign: TextAlign.center,
        ),
        SmoothText(
          hPadding: 0.0,
          vPadding: 0.0,
          text: "Rejoins une partie",
          fontSize: 20.0,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget buildGameListView() {
    return StreamBuilder<List<SmoothGame>?>(
      stream: SmoothGameService().allGames(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return emptyGames(context);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SmoothLoader(visible: true);
        }

        if (snapshot.hasError) {
          return const SmoothContainer();
        }

        final allGames = snapshot.data;

        if (allGames != null && allGames.isNotEmpty) {
          return buildGamesList(allGames);
        } else {
          return emptyGames(context);
        }
      },
    );
  }

  Widget buildGamesList(List<SmoothGame> allGames) {
    return Container(
      alignment: Alignment.center,
      width: SmoothConfig.screenWidth,
      padding: EdgeInsets.zero,
      height: 180.0,
      child: CarouselSlider.builder(
        itemCount: allGames.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          final game = allGames[itemIndex];
          return SmoothGameWidget(game: game);
        },
        options: CarouselOptions(
          autoPlay: allGames.length > 1 ? true : false,
          enlargeCenterPage: true,
          viewportFraction: 0.85,
          aspectRatio: 2.2,
        ),
      ),
    );
  }

  Widget emptyGames(BuildContext context) {
    return SmoothContainer(
      alignment: Alignment.center,
      width: SmoothConfig.screenWidth,
      height: 250.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SmoothText(
            textAlign: TextAlign.center,
            style: FontStyle.italic,
            textColor: Colors.black.withOpacity(0.5),
            text: "Aucune partie disponible pour le moment !",
          ),
          TextButton(
            onPressed: () {
              final authController = context.read<SmoothAuthController>();
              authController.currentUser != null
                  ? context.router.push(const CreateGame(), onFailure: (failure) {
                      context.router.push(const NotFound());
                    })
                  : context.router.push(const SmoothLogin());
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(SmoothConfig.screenWidth!),
              ),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            child: const SmoothText(
              text: "Créer une partie",
              textColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  callbackFunction(int index, CarouselPageChangedReason reason) {
    print(reason);
  }

  Widget carrouselItem({required String title, required Color color}) {
    return Container(
      color: color,
      alignment: Alignment.center,
      child: SmoothText(
        textAlign: TextAlign.center,
        text: title,
      ),
    );
  }

  buildSmoothSpacer({double? horizontal, double? vertical}) {
    return SizedBox(
      height: vertical ?? 0.0,
      width: horizontal ?? 0.0,
    );
  }
}
