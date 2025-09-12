import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BusinessSearch(),
    );
  }
}

class BusinessSearch extends StatefulWidget {
  const BusinessSearch({super.key});

  @override
  State<BusinessSearch> createState() => _BusinessSearchState();
}

class _BusinessSearchState extends State<BusinessSearch> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
