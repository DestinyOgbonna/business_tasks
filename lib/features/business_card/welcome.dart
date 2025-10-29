import 'package:animate_do/animate_do.dart';
import 'package:busniess_search/features/business_card/business_card.dart';
import 'package:busniess_search/features/shopping_cart/presentation/view_items.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          image: const DecorationImage(
            image: AssetImage('assets/image/image2.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 400,
            ),
            FadeInLeft(
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Welcome to Destan\'s Stores',
                  style: GoogleFonts.aDLaMDisplay(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SlideInUp(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: ((context) {
                    return const ItemsListScreen();
                  })));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Shop Now',
                    style: GoogleFonts.aDLaMDisplay(
                      textStyle: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
