import 'package:flutter/material.dart';

import 'dom/dom_helper.dart';
import 'screens/home_screen.dart';
import 'screens/places_screen.dart';
import 'screens/tracker_screen.dart';

void main() {
  // Experiment 5: Dart DOM manipulation
  DomHelper.setPageTitle('TravelMate - Dart DOM Application');

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

        scaffoldBackgroundColor: const Color(0xFFF6F8FC),

        colorScheme: const ColorScheme.light(
          primary: Color(0xFF2563EB),
          onPrimary: Colors.white,
          secondary: Color(0xFF06B6D4),
          onSecondary: Colors.white,
          surface: Colors.white,
          onSurface: Color(0xFF0F172A),
          error: Color(0xFFEF4444),
          onError: Colors.white,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6F8FC),
          foregroundColor: Color(0xFF0F172A),
          elevation: 0,
          scrolledUnderElevation: 0,
        ),

        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w800,
          ),
          headlineMedium: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w800,
          ),
          titleLarge: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w700,
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

        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 10,
          indicatorColor: const Color(0xFFE0EAFF),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) {
              final selected =
                  states.contains(WidgetState.selected);

              return TextStyle(
                color: selected
                    ? const Color(0xFF2563EB)
                    : const Color(0xFF64748B),
                fontWeight:
                    selected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 12,
              );
            },
          ),
        ),

        navigationRailTheme:
            const NavigationRailThemeData(
          backgroundColor: Colors.white,
          selectedIconTheme: IconThemeData(
            color: Color(0xFF2563EB),
          ),
          unselectedIconTheme: IconThemeData(
            color: Color(0xFF64748B),
          ),
          selectedLabelTextStyle: TextStyle(
            color: Color(0xFF2563EB),
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelTextStyle: TextStyle(
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
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

  void _handleNavigation(int index) {
    setState(() {
      selectedIndex = index;
    });

    const names = [
      'Home',
      'Places',
      'Tracker',
    ];

    // Experiment 5: DOM event handling
    DomHelper.updateStatus(
      'DOM Event: ${names[index]} selected',
    );
  }

  @override
  Widget build(BuildContext context) {
    // MEDIAQUERY
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 600;
    final isDesktop = width >= 1000;

    return Scaffold(
      body: Row(
        children: [
          // ===================================================
          // TABLET / DESKTOP NAVIGATION
          // ===================================================

          if (!isMobile)
            NavigationRail(
              selectedIndex: selectedIndex,

              onDestinationSelected: _handleNavigation,

              extended: isDesktop,

              backgroundColor: Colors.white,

              leading: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 25,
                ),

                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: const Color(0xFFE0EAFF),
                        borderRadius:
                            BorderRadius.circular(14),
                      ),

                      child: const Icon(
                        Icons.flight_takeoff_rounded,
                        color: Color(0xFF2563EB),
                      ),
                    ),

                    if (isDesktop) ...[
                      const SizedBox(height: 8),

                      const Text(
                        'TravelMate',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon:
                      Icon(Icons.home_rounded),
                  label: Text('Home'),
                ),

                NavigationRailDestination(
                  icon: Icon(Icons.explore_outlined),
                  selectedIcon:
                      Icon(Icons.explore_rounded),
                  label: Text('Places'),
                ),

                NavigationRailDestination(
                  icon: Icon(
                    Icons.location_on_outlined,
                  ),
                  selectedIcon: Icon(
                    Icons.location_on_rounded,
                  ),
                  label: Text('Tracker'),
                ),
              ],
            ),

          // ===================================================
          // SCREEN CONTENT
          // ===================================================

          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: screens,
            ),
          ),
        ],
      ),

      // =====================================================
      // MOBILE NAVIGATION
      // =====================================================

      bottomNavigationBar: isMobile
          ? NavigationBar(
              selectedIndex: selectedIndex,

              onDestinationSelected:
                  _handleNavigation,

              destinations: const [
                NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  selectedIcon:
                      Icon(Icons.home_rounded),
                  label: 'Home',
                ),

                NavigationDestination(
                  icon: Icon(
                    Icons.explore_outlined,
                  ),
                  selectedIcon:
                      Icon(Icons.explore_rounded),
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
            )
          : null,
    );
  }
}