import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:smooth_game_app/core/common/smooth_init.dart';
import 'package:smooth_game_app/core/common/smooth_tools.dart';
import 'package:smooth_game_app/core/controllers/smooth_auth_controller.dart';
import 'package:smooth_game_app/core/controllers/smooth_forms_controller.dart';
import 'package:smooth_game_app/core/controllers/smooth_game_controller.dart';
import 'package:smooth_game_app/core/controllers/smooth_settings_controller.dart';
import 'package:smooth_game_app/core/controllers/smooth_theme_controller.dart';
import 'package:smooth_game_app/firebase_options.dart';
import 'package:smooth_game_app/router/router.gr.dart';

final appRouter = AppRouter();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SmoothInit.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SmoothThemeController themeChangeProvider = SmoothThemeController();
    SmoothTools().loadLocal(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SmoothThemeController()),
        ChangeNotifierProvider(create: (_) => SmoothAuthController()),
        ChangeNotifierProvider(create: (_) => SmoothGameController()),
        ChangeNotifierProvider(create: (_) => SmoothFormsController()),
        ChangeNotifierProvider(create: (_) => SmoothSettingsController()),
      ],
      child: Consumer<SmoothThemeController>(
        builder: (context, themeController, child) {
          return Consumer<SmoothSettingsController>(
            builder: (context, settingsController, child) {
              settingsController.loadLocal(context);
              return MaterialApp.router(
                title: "Smooth Games App",
                theme:
                    themeController.smoothColor.themeData(themeChangeProvider.darkTheme, context),
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                ),
                localizationsDelegates: [
                  settingsController.flutterI18nDelegate,
                  ...GlobalMaterialLocalizations.delegates,
                ],
                locale: settingsController.defaultLocal,
                routerDelegate: appRouter.delegate(),
                routeInformationParser: appRouter.defaultRouteParser(),
                debugShowCheckedModeBanner: false,
              );
            },
          );
        },
      ),
    );
  }
}
