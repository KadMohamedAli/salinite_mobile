import 'package:flutter/material.dart';
import './pages/home_page.dart';
import './pages/settings_page.dart';
import './services/base_url_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BaseUrlService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Define colors globally to reuse
  static const Color tealColor = Color(0xFF00796B);
  static const Color goldColor = Color(0xFFFFB300);

  static const Color lightBackground = Color(0xFFF5F5F5); // light grey
  static const Color darkBackground = Color(0xFF212121); // dark grey

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salinité App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: tealColor,
          onPrimary: Colors.white, // Text/icon on primary color (teal)
          secondary: goldColor,
          onSecondary: Colors.black87, // Text/icon on gold
          background: lightBackground,
          onBackground: Colors.grey[900]!,
          surface: Colors.white,
          onSurface: Colors.grey[900]!,
          error: Colors.red.shade700,
          onError: Colors.white,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: lightBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: tealColor,
          foregroundColor: Colors.white, // white text & icons on teal appbar
          elevation: 4,
        ),
        cardTheme: CardThemeData(
          color: Colors.white, // white cards on light mode
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: tealColor.withOpacity(0.25),
        ),
        textTheme: Typography.blackMountainView.apply(
          bodyColor: Colors.grey[900],
          displayColor: Colors.grey[900],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: tealColor, // button background
            foregroundColor: Colors.white, // button text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: tealColor,
          onPrimary: Colors.white,
          secondary: goldColor,
          onSecondary: Colors.black87,
          background: darkBackground,
          onBackground: Colors.grey[300]!,
          surface: Color(0xFF424242), // dark card color
          onSurface: Colors.grey[300]!,
          error: Colors.red.shade400,
          onError: Colors.black,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: darkBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: tealColor,
          foregroundColor: Colors.white, // white text/icons on teal appbar
          elevation: 4,
        ),
        cardTheme: CardThemeData(
          color: Color(0xFF424242), // dark grey cards
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: Colors.black54,
        ),
        textTheme: Typography.whiteMountainView.apply(
          bodyColor: Colors.grey[300],
          displayColor: Colors.grey[300],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: goldColor, // gold buttons in dark mode
            foregroundColor: Colors.black87, // dark text on gold button
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/settings': (_) => const SettingsPage(),
      },
    );
  }
}
