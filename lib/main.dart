import 'package:busniess_search/features/business_card/theme.dart';
import 'package:busniess_search/features/business_card/theme_provider.dart';
import 'package:busniess_search/features/business_card/welcome.dart';
import 'package:busniess_search/features/business_search/data/business_search_provider.dart';
import 'package:busniess_search/features/shopping_cart/data/add_items_provider.dart';
import 'package:busniess_search/features/shopping_cart/presentation/view_items.dart';
import 'package:busniess_search/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  await Hive.openBox<Item>('items');
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BusinessProvider()),
        ChangeNotifierProvider(create: (_) => AddItemsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Business Search',
        theme: Provider.of<ThemeProvider>(context).themeData,
        darkTheme: darkMode,
        home: const WelcomeScreen(),
      ),
    );
  }
}
