import 'package:animate_do/animate_do.dart';
import 'package:busniess_search/features/business_card/theme_provider.dart';
import 'package:busniess_search/features/shopping_cart/presentation/shopping_cart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessCardScreen extends StatelessWidget {
  BusinessCardScreen({super.key});
  final List<String> imageUrls = [
    'assets/image/image1.jpeg',
    'assets/image/image2.jpeg',
    'assets/image/image3.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlideInUp(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 500.0,
                      autoPlay: true,
                      autoPlayInterval:
                          const Duration(seconds: 7), // Slide duration
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      aspectRatio: 16 / 9,
                      initialPage: 0,
                    ),
                    items: imageUrls.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage(
                                      imageUrl,
                                    ),
                                    fit: BoxFit.cover)),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                SlideInRight(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'DESTINY OGBONNA.',
                              style: GoogleFonts.aDLaMDisplay(
                                textStyle: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .toggleTheme();
                              },
                              icon: Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .isDarkMode
                                  ? const Icon(
                                      Icons.light_mode,
                                      color: Colors.yellow,
                                    )
                                  : const Icon(Icons.dark_mode),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.blue[100]),
                            const SizedBox(width: 4),
                            const Text(
                              'PORT-HARCOURT\n RIVERS STATE',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 16),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ShoppingCartScreen()));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  'Mobile Developer',
                                  style: GoogleFonts.aDLaMDisplay(
                                    textStyle: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'My name is Destiny Ogbonna (Destan), a mobile developer with over 4 years of experience in building high-quality mobile applications for both Android and iOS platforms. I specialize in Flutter and have a strong passion for creating user-friendly and visually appealing apps. \nI love music, traveling, and exploring new technologies in the mobile development space. I play the Bass Guitar. A Liverpool FC fan(YNWA).',
                          style: GoogleFonts.aDLaMDisplay(
                            textStyle: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Skills: ',
                              style: GoogleFonts.aDLaMDisplay(
                                textStyle: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Flutter, Dart, Java, Kotlin, RESTful APIs, \nFirebase, Git',
                              style: GoogleFonts.aDLaMDisplay(
                                textStyle: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.phone, color: Colors.blueGrey),
                            const SizedBox(width: 4),
                            Text(
                              '+234 906 922 1135',
                              style: GoogleFonts.aDLaMDisplay(
                                textStyle: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                launchUrl(
                                    Uri.parse("https://x.com/Destan_Ogbonna"));
                              },
                              child: Image(
                                image: const AssetImage('assets/image/x.png'),
                                height: 16,
                                width: 16,
                                color: Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                launchUrl(Uri.parse("https://wa.link/zhk8mb"));
                              },
                              child: Image(
                                image: const AssetImage(
                                    'assets/image/facebook.png'),
                                height: 16,
                                width: 16,
                                color: Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .isDarkMode
                                    ? Colors.blue
                                    : Colors.blue,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                launchUrl(Uri.parse("https://wa.link/zhk8mb"));
                              },
                              child: Image(
                                image: const AssetImage(
                                    'assets/image/whatsapp.png'),
                                height: 16,
                                width: 16,
                                color: Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .isDarkMode
                                    ? Colors.green
                                    : Colors.green,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
