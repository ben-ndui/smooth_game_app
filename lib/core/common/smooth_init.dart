//import 'package:flutter_native_splash/flutter_native_splash.dart';

class SmoothInit {
  SmoothInit._();

  static final instance = SmoothInit._();

  Future<void> initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following smoothndesign because
    // delaying the user experience is a bad design practice!

    await Future.delayed(const Duration(seconds: 3));
    //FlutterNativeSplash.remove();
  }
}
