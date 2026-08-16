import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/places_screen.dart';
import 'screens/tracker_screen.dart';

void main() {
  runApp(const TravelPlannerApp());
}

class TravelPlannerApp extends StatelessWidget {
  const TravelPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'TravelMate',

      theme: ThemeData(
        useMaterial3: true,

        // =====================================================
        // MAIN APP COLORS
        // =====================================================

        scaffoldBackgroundColor: const Color(0xFFF6F8FC),

        colorScheme: ColorScheme.light(
          primary: const Color(0xFF2563EB),
          onPrimary: Colors.white,

          secondary: const Color(0xFF06B6D4),
          onSecondary: Colors.white,

          surface: Colors.white,
          onSurface: const Color(0xFF0F172A),

          error: const Color(0xFFEF4444),
          onError: Colors.white,
        ),

        // =====================================================
        // APP BAR
        // =====================================================

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6F8FC),
          foregroundColor: Color(0xFF0F172A),

          elevation: 0,

          scrolledUnderElevation: 0,

          centerTitle: false,
        ),

        // =====================================================
        // TEXT
        // =====================================================

        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w800,
          ),

          headlineMedium: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w800,
          ),

          headlineSmall: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w800,
          ),

          titleLarge: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w700,
          ),

          titleMedium: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w600,
          ),

          bodyLarge: TextStyle(
            color: Color(0xFF334155),
          ),

          bodyMedium: TextStyle(
            color: Color(0xFF64748B),
          ),

          bodySmall: TextStyle(
            color: Color(0xFF94A3B8),
          ),
        ),

        // =====================================================
        // CARDS
        // =====================================================

        cardTheme: CardThemeData(
          color: Colors.white,

          elevation: 0,

          margin: EdgeInsets.zero,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        // =====================================================
        // NAVIGATION BAR
        // =====================================================

        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,

          surfaceTintColor: Colors.transparent,

          elevation: 10,

          shadowColor: Colors.black12,

          indicatorColor: const Color(0xFFE0EAFF),

          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(
                  color: Color(0xFF2563EB),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                );
              }

              return const TextStyle(
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              );
            },
          ),

          iconTheme: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(
                  color: Color(0xFF2563EB),
                  size: 24,
                );
              }

              return const IconThemeData(
                color: Color(0xFF64748B),
                size: 23,
              );
            },
          ),
        ),

        // =====================================================
        // INPUT FIELDS
        // =====================================================

        inputDecorationTheme: InputDecorationTheme(
          filled: true,

          fillColor: Colors.white,

          hintStyle: const TextStyle(
            color: Color(0xFF94A3B8),
          ),

          prefixIconColor: const Color(0xFF64748B),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),

            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),

            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),

            borderSide: const BorderSide(
              color: Color(0xFF2563EB),
              width: 1.5,
            ),
          ),
        ),
      ),

      home: const MainScreen(),
    );
  }
}

// =============================================================
// MAIN SCREEN
// =============================================================

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    PlacesScreen(),
    TrackerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),

      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,

        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
            ),

            selectedIcon: Icon(
              Icons.home_rounded,
            ),

            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.explore_outlined,
            ),

            selectedIcon: Icon(
              Icons.explore_rounded,
            ),

            label: 'Places',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.location_on_outlined,
            ),

            selectedIcon: Icon(
              Icons.location_on_rounded,
            ),

            label: 'Tracker',
          ),
        ],
      ),
    );
  }
}