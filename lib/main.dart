import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              onPrimary: primaryColor,
              secondary: secondaryColor,
            ),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.poppins(textStyle: textTheme.bodyMedium),
        ),
      ),
      initialRoute: '/home_page',
      routes: {
        '/home_page': (context) => ChangeNotifierProvider<RestaurantProvider>(
              create: (_) => RestaurantProvider(apiService: ApiService()),
              child: const HomePage(),
            ),
        '/detail_page': (context) {
          final restaurantId =
              ModalRoute.of(context)?.settings.arguments as String;
          return ChangeNotifierProvider<RestaurantDetailProvider>(
            create: (_) => RestaurantDetailProvider(
              apiService: ApiService(),
              restaurantId: restaurantId,
            ),
            child: const DetailPage(),
          );
        },
        '/search': (context) {
          return ChangeNotifierProvider<RestaurantSearchProvider>(
            create: (_) => RestaurantSearchProvider(
              apiService: ApiService(),
            ),
            child: const SearchPage(),
          );
        }
      },
    );
  }
}
