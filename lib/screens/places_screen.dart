import 'package:flutter/material.dart';

import '../data/trip_data.dart';
import '../dom/dom_helper.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() =>
      _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  final TextEditingController searchController =
      TextEditingController();

  final TripData tripData = TripData.instance;

  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();

    tripData.addListener(
      _onTripDataChanged,
    );
  }

  void _onTripDataChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    tripData.removeListener(
      _onTripDataChanged,
    );

    searchController.dispose();

    super.dispose();
  }

  // ==========================================================
  // ADD PLACE
  // ==========================================================

  void addPlace() {
    final controller =
        TextEditingController();

    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(24),
          ),

          title: const Text(
            'Add a new place',

            style: TextStyle(
              fontWeight:
                  FontWeight.w800,
            ),
          ),

          content: TextField(
            controller: controller,
            autofocus: true,

            decoration:
                InputDecoration(
              hintText:
                  'e.g. Candolim Beach',

              prefixIcon:
                  const Icon(
                Icons.location_on_outlined,
              ),

              filled: true,

              fillColor:
                  const Color(0xFFF1F5F9),

              border:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  15,
                ),
                borderSide:
                    BorderSide.none,
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },

              child:
                  const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                final name =
                    controller.text.trim();

                if (name.isNotEmpty) {
                  tripData.addPlace(
                    name,
                  );

                  // Experiment 5:
                  // Dynamic DOM update.
                  DomHelper.updateStatus(
                    '$name dynamically added using Dart DOM',
                  );

                  Navigator.pop(
                    dialogContext,
                  );

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    SnackBar(
                      content: Text(
                        '$name added to your trip!',
                      ),

                      behavior:
                          SnackBarBehavior
                              .floating,
                    ),
                  );
                }
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(
                  0xFF2563EB,
                ),

                foregroundColor:
                    Colors.white,
              ),

              child:
                  const Text('Add Place'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // DELETE
  // ==========================================================

  void deletePlace(int index) {
    final removedPlace =
        tripData.places[index];

    tripData.removePlace(index);

    // Experiment 5:
    // Dynamic DOM update.
    DomHelper.updateStatus(
      '${removedPlace.name} dynamically removed',
    );

    ScaffoldMessenger.of(context)
        .clearSnackBars();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          '${removedPlace.name} deleted',
        ),

        behavior:
            SnackBarBehavior.floating,

        action: SnackBarAction(
          label: 'UNDO',

          onPressed: () {
            tripData.restorePlace(
              index,
              removedPlace,
            );

            DomHelper.updateStatus(
              '${removedPlace.name} restored dynamically',
            );
          },
        ),
      ),
    );
  }

  // ==========================================================
  // FILTER
  // ==========================================================

  List<TripPlace> get filteredPlaces {
    final searchText =
        searchController.text.toLowerCase();

    return tripData.places.where(
      (place) {
        final matchesSearch =
            place.name
                .toLowerCase()
                .contains(searchText);

        final matchesFilter =
            selectedFilter == 'All' ||
                (selectedFilter ==
                        'Visited' &&
                    place.visited) ||
                (selectedFilter ==
                        'Pending' &&
                    !place.visited);

        return matchesSearch &&
            matchesFilter;
      },
    ).toList();
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final progress =
        tripData.progress;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Places to Visit',

          style: TextStyle(
            fontWeight:
                FontWeight.w800,
            fontSize: 22,
          ),
        ),

        actions: [
          Container(
            margin:
                const EdgeInsets.only(
              right: 16,
            ),

            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),

            decoration:
                BoxDecoration(
              color:
                  const Color(0xFFE0EAFF),

              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),

            child: Text(
              '${tripData.totalPlaces} Places',

              style: const TextStyle(
                color:
                    Color(0xFF2563EB),
                fontWeight:
                    FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: addPlace,

        backgroundColor:
            const Color(0xFF2563EB),

        foregroundColor:
            Colors.white,

        icon:
            const Icon(Icons.add_rounded),

        label: const Text(
          'Add Place',

          style: TextStyle(
            fontWeight:
                FontWeight.w700,
          ),
        ),
      ),

      body: LayoutBuilder(
        builder:
            (context, constraints) {
          final isWide =
              constraints.maxWidth >= 700;

          return Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.fromLTRB(
                  isWide ? 30 : 20,
                  5,
                  isWide ? 30 : 20,
                  12,
                ),

                child:
                    _progressCard(progress),
              ),

              Padding(
                padding:
                    EdgeInsets.symmetric(
                  horizontal:
                      isWide ? 30 : 20,
                ),

                child: TextField(
                  controller:
                      searchController,

                  onChanged: (_) {
                    setState(() {});
                  },

                  decoration:
                      InputDecoration(
                    hintText:
                        'Search places...',

                    prefixIcon:
                        const Icon(
                      Icons.search_rounded,
                    ),

                    suffixIcon:
                        searchController
                                .text
                                .isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  searchController
                                      .clear();

                                  setState(
                                    () {},
                                  );
                                },

                                icon:
                                    const Icon(
                                  Icons
                                      .close_rounded,
                                ),
                              )
                            : null,
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              Padding(
                padding:
                    EdgeInsets.symmetric(
                  horizontal:
                      isWide ? 30 : 20,
                ),

                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,

                  children: [
                    _filterChip('All'),
                    _filterChip('Visited'),
                    _filterChip('Pending'),
                  ],
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              Expanded(
                child:
                    filteredPlaces.isEmpty
                        ? _emptyState()
                        : isWide
                            ? _widePlacesLayout()
                            : _mobilePlacesLayout(),
              ),
            ],
          );
        },
      ),
    );
  }

  // ==========================================================
  // MOBILE
  // ==========================================================

  Widget _mobilePlacesLayout() {
    return ListView.builder(
      physics:
          const BouncingScrollPhysics(),

      padding:
          const EdgeInsets.fromLTRB(
        20,
        8,
        20,
        100,
      ),

      itemCount:
          filteredPlaces.length,

      itemBuilder:
          (context, index) {
        final place =
            filteredPlaces[index];

        return _placeCard(
          place,
          tripData.places
              .indexOf(place),
        );
      },
    );
  }

  // ==========================================================
  // TABLET / DESKTOP
  // ==========================================================

  Widget _widePlacesLayout() {
    return GridView.builder(
      physics:
          const BouncingScrollPhysics(),

      padding:
          const EdgeInsets.fromLTRB(
        30,
        8,
        30,
        100,
      ),

      gridDelegate:
          const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 450,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 2.7,
      ),

      itemCount:
          filteredPlaces.length,

      itemBuilder:
          (context, index) {
        final place =
            filteredPlaces[index];

        return _placeCard(
          place,
          tripData.places
              .indexOf(place),
        );
      },
    );
  }

  // ==========================================================
  // PROGRESS
  // ==========================================================

  Widget _progressCard(
    double progress,
  ) {
    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.all(18),

      decoration:
          BoxDecoration(
        gradient:
            const LinearGradient(
          colors: [
            Color(0xFF1D4ED8),
            Color(0xFF2563EB),
          ],
        ),

        borderRadius:
            BorderRadius.circular(22),
      ),

      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

            children: [
              const Text(
                'Trip Progress',

                style: TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),

              Text(
                '${(progress * 100).round()}%',

                style:
                    const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight:
                      FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius:
                BorderRadius.circular(
              20,
            ),

            child:
                LinearProgressIndicator(
              value: progress,

              minHeight: 9,

              backgroundColor:
                  Colors.white
                      .withValues(
                alpha: 0.2,
              ),

              valueColor:
                  const AlwaysStoppedAnimation<
                      Color>(
                Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Align(
            alignment:
                Alignment.centerLeft,

            child: Text(
              '${tripData.visitedCount} of ${tripData.totalPlaces} places visited',

              style:
                  const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // FILTER CHIP
  // ==========================================================

  Widget _filterChip(
    String title,
  ) {
    final selected =
        selectedFilter == title;

    return ChoiceChip(
      label: Text(title),

      selected: selected,

      onSelected: (_) {
        setState(() {
          selectedFilter = title;
        });

        DomHelper.updateStatus(
          'DOM Event: $title filter selected',
        );
      },

      selectedColor:
          const Color(0xFF2563EB),

      backgroundColor:
          Colors.white,

      labelStyle:
          TextStyle(
        color: selected
            ? Colors.white
            : const Color(0xFF475569),

        fontWeight:
            FontWeight.w600,
      ),

      side: BorderSide.none,
    );
  }

  // ==========================================================
  // PLACE CARD
  // ==========================================================

  Widget _placeCard(
    TripPlace place,
    int index,
  ) {
    final visited =
        place.visited;

    return Dismissible(
      key: ValueKey(
        '${place.name}_$index',
      ),

      direction:
          DismissDirection.endToStart,

      background: Container(
        margin:
            const EdgeInsets.only(
          bottom: 12,
        ),

        alignment:
            Alignment.centerRight,

        padding:
            const EdgeInsets.only(
          right: 25,
        ),

        decoration:
            BoxDecoration(
          color:
              const Color(0xFFEF4444),

          borderRadius:
              BorderRadius.circular(
            20,
          ),
        ),

        child: const Icon(
          Icons.delete_outline_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),

      onDismissed: (_) {
        deletePlace(index);
      },

      child: Container(
        margin:
            const EdgeInsets.only(
          bottom: 12,
        ),

        decoration:
            BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(
            20,
          ),

          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withValues(
                alpha: 0.035,
              ),

              blurRadius: 12,

              offset:
                  const Offset(0, 5),
            ),
          ],
        ),

        child:
            CheckboxListTile(
          value: visited,

          onChanged: (value) {
            final isVisited =
                value ?? false;

            tripData.toggleVisited(
              index,
              isVisited,
            );

            // Experiment 5:
            // DOM event + dynamic text update.
            DomHelper.updateStatus(
              isVisited
                  ? '${place.name} marked as visited'
                  : '${place.name} marked as pending',
            );
          },

          activeColor:
              const Color(0xFF10B981),

          secondary: Container(
            padding:
                const EdgeInsets.all(
              11,
            ),

            decoration:
                BoxDecoration(
              color:
                  place.color.withValues(
                alpha: 0.1,
              ),

              borderRadius:
                  BorderRadius.circular(
                14,
              ),
            ),

            child: Icon(
              place.icon,
              color: place.color,
            ),
          ),

          title: Text(
            place.name,

            style: TextStyle(
              fontWeight:
                  FontWeight.w700,

              color: visited
                  ? const Color(
                      0xFF94A3B8,
                    )
                  : const Color(
                      0xFF0F172A,
                    ),

              decoration: visited
                  ? TextDecoration
                      .lineThrough
                  : TextDecoration.none,
            ),
          ),

          subtitle: Text(
            visited
                ? '✓ Completed'
                : 'Ready to explore',

            style: TextStyle(
              color: visited
                  ? const Color(
                      0xFF10B981,
                    )
                  : const Color(
                      0xFF64748B,
                    ),

              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // EMPTY
  // ==========================================================

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          Container(
            padding:
                const EdgeInsets.all(22),

            decoration:
                const BoxDecoration(
              color:
                  Color(0xFFEFF4FF),

              shape:
                  BoxShape.circle,
            ),

            child: const Icon(
              Icons.travel_explore_rounded,
              size: 45,
              color:
                  Color(0xFF2563EB),
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'No places found',

            style: TextStyle(
              fontSize: 19,
              fontWeight:
                  FontWeight.w800,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Try another search or add a new destination.',

            textAlign:
                TextAlign.center,

            style: TextStyle(
              color:
                  Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}