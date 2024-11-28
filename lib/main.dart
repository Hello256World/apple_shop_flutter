import 'package:apple_shop_flutter/data/utils/auth_manager.dart';
import 'package:apple_shop_flutter/di/di.dart';
import 'package:apple_shop_flutter/ui/login_screen.dart';
import 'package:apple_shop_flutter/ui/main_screen.dart';
import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navigateGlobalKey = GlobalKey();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await diSetup();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigateGlobalKey,
      home: AuthManager.isLogin() ? const MainScreen() : LoginScreen(),
    );
  }
}
