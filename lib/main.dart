import 'package:apple_shop_flutter/data/models/card.dart';
import 'package:apple_shop_flutter/di/di.dart';
import 'package:apple_shop_flutter/ui/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

late Isar isar;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  if (Isar.instanceNames.isEmpty) {
    isar = await Isar.open(
      [CardSchema],
      directory: dir.path,
      name: 'cardsInstance'
    );
  }
 diSetup();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}
