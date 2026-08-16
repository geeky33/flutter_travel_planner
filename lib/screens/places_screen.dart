import 'package:flutter/material.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> places = [
    {
      'name': 'Baga Beach',
      'visited': true,
      'icon': Icons.beach_access_rounded,
      'color': Colors.orange,
    },
    {
      'name': 'Fort Aguada',
      'visited': false,
      'icon': Icons.castle_rounded,
      'color': Colors.deepPurple,
    },
    {
      'name': 'Dudhsagar Falls',
      'visited': false,
      'icon': Icons.water_drop_rounded,
      'color': Colors.blue,
    },
    {
      'name': 'Basilica of Bom Jesus',
      'visited': false,
      'icon': Icons.account_balance_rounded,
      'color': Colors.green,
    },
    {
      'name': 'Palolem Beach',
      'visited': false,
      'icon': Icons.waves_rounded,
      'color': Colors.teal,
    },
  ];

  String selectedFilter = 'All';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ----------------------------------------------------------
  // ADD PLACE
  // ----------------------------------------------------------

  void addPlace() {
    final controller = TextEditingController();

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),

          title: const Text(
            'Add a new place',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),

          content: TextField(
            controller: controller,

            autofocus: true,

            decoration: InputDecoration(
              hintText: 'e.g. Candolim Beach',

              prefixIcon: const Icon(
                Icons.location_on_outlined,
              ),

              filled: true,

              fillColor: const Color(0xFFF1F5F9),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          actionsPadding: const EdgeInsets.fromLTRB(
            16,
            0,
            16,
            16,
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                final name = controller.text.trim();

                if (name.isNotEmpty) {
                  setState(() {
                    places.add({
                      'name': name,
                      'visited': false,
                      'icon': Icons.place_rounded,
                      'color': Colors.blue,
                    });
                  });

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$name added to your trip!'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  );
                }
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
              ),

              child: const Text('Add Place'),
            ),
          ],
        );
      },
    );
  }

  // ----------------------------------------------------------
  // FILTER
  // ----------------------------------------------------------

  List<Map<String, dynamic>> get filteredPlaces {
    final searchText = searchController.text.toLowerCase();

    return places.where((place) {
      final matchesSearch =
          place['name'].toString().toLowerCase().contains(searchText);

      final visited = place['visited'] == true;

      final matchesFilter =
          selectedFilter == 'All' ||
          (selectedFilter == 'Visited' && visited) ||
          (selectedFilter == 'Pending' && !visited);

      return matchesSearch && matchesFilter;
    }).toList();
  }

  int get visitedCount {
    return places.where((place) => place['visited'] == true).length;
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        places.isEmpty ? 0.0 : visitedCount / places.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Places to Visit',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),

        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),

            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),

            decoration: BoxDecoration(
              color: const Color(0xFFE0EAFF),
              borderRadius: BorderRadius.circular(20),
            ),

            child: Text(
              '${places.length} Places',
              style: const TextStyle(
                color: Color(0xFF2563EB),
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: addPlace,

        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,

        icon: const Icon(Icons.add_rounded),

        label: const Text(
          'Add Place',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Column(
        children: [
          // --------------------------------------------------
          // PROGRESS HEADER
          // --------------------------------------------------

          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              5,
              20,
              12,
            ),

            child: Container(
              width: double.infinity,

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1D4ED8),
                    Color(0xFF2563EB),
                  ],
                ),

                borderRadius: BorderRadius.circular(22),

                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB)
                        .withOpacity(0.18),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [
                      const Text(
                        'Trip Progress',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      Text(
                        '${(progress * 100).round()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),

                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 9,

                      backgroundColor:
                          Colors.white.withOpacity(0.2),

                      valueColor:
                          const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 9),

                  Text(
                    '$visitedCount of ${places.length} places visited',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --------------------------------------------------
          // SEARCH
          // --------------------------------------------------

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),

            child: TextField(
              controller: searchController,

              onChanged: (_) {
                setState(() {});
              },

              decoration: InputDecoration(
                hintText: 'Search places...',

                prefixIcon: const Icon(
                  Icons.search_rounded,
                ),

                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                        ),
                      )
                    : null,

                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),

                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // --------------------------------------------------
          // FILTER CHIPS
          // --------------------------------------------------

          SizedBox(
            height: 42,

            child: ListView(
              scrollDirection: Axis.horizontal,

              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              children: [
                _filterChip('All'),
                _filterChip('Visited'),
                _filterChip('Pending'),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // --------------------------------------------------
          // PLACES LIST
          // --------------------------------------------------

          Expanded(
            child: filteredPlaces.isEmpty
                ? _emptyState()
                : ListView.builder(
                    physics:
                        const BouncingScrollPhysics(),

                    padding: const EdgeInsets.fromLTRB(
                      20,
                      8,
                      20,
                      100,
                    ),

                    itemCount: filteredPlaces.length,

                    itemBuilder: (context, index) {
                      final place = filteredPlaces[index];

                      final originalIndex =
                          places.indexOf(place);

                      return _placeCard(
                        place,
                        originalIndex,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // FILTER CHIP
  // ----------------------------------------------------------

  Widget _filterChip(String title) {
    final selected = selectedFilter == title;

    return Padding(
      padding: const EdgeInsets.only(right: 8),

      child: ChoiceChip(
        label: Text(title),

        selected: selected,

        onSelected: (_) {
          setState(() {
            selectedFilter = title;
          });
        },

        selectedColor: const Color(0xFF2563EB),

        backgroundColor: Colors.white,

        labelStyle: TextStyle(
          color: selected
              ? Colors.white
              : const Color(0xFF475569),

          fontWeight: FontWeight.w600,
        ),

        side: BorderSide.none,
      ),
    );
  }

  // ----------------------------------------------------------
  // PLACE CARD
  // ----------------------------------------------------------

  Widget _placeCard(
    Map<String, dynamic> place,
    int index,
  ) {
    final visited = place['visited'] == true;

    final Color color = place['color'];

    return Dismissible(
      key: ValueKey(
        '${place['name']}_$index',
      ),

      direction: DismissDirection.endToStart,

      background: Container(
        margin: const EdgeInsets.only(bottom: 12),

        alignment: Alignment.centerRight,

        padding: const EdgeInsets.only(right: 25),

        decoration: BoxDecoration(
          color: const Color(0xFFEF4444),
          borderRadius: BorderRadius.circular(20),
        ),

        child: const Icon(
          Icons.delete_outline_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),

      onDismissed: (_) {
        final removedPlace = places[index];

        setState(() {
          places.removeAt(index);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${removedPlace['name']} removed',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.035),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: CheckboxListTile(
          value: visited,

          onChanged: (value) {
            setState(() {
              places[index]['visited'] = value ?? false;
            });
          },

          activeColor: const Color(0xFF10B981),

          checkboxShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 7,
          ),

          secondary: Container(
            padding: const EdgeInsets.all(11),

            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(
              place['icon'],
              color: color,
            ),
          ),

          title: Text(
            place['name'],

            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: visited
                  ? const Color(0xFF94A3B8)
                  : const Color(0xFF0F172A),

              decoration: visited
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),

          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),

            child: Text(
              visited
                  ? '✓ Completed'
                  : 'Ready to explore',

              style: TextStyle(
                color: visited
                    ? const Color(0xFF10B981)
                    : const Color(0xFF64748B),

                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // EMPTY STATE
  // ----------------------------------------------------------

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF),
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.travel_explore_rounded,
                size: 45,
                color: Color(0xFF2563EB),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'No places found',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Try another search or add a new destination.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}