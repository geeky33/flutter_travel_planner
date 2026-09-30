import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../data/trip_data.dart';
import '../dom/dom_helper.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() =>
      _TrackerScreenState();
}

class _TrackerScreenState
    extends State<TrackerScreen> {
  final TripData tripData =
      TripData.instance;

  GoogleMapController? mapController;

  LatLng? currentLocation;

  bool isLoading = true;

  String locationMessage =
      'Getting your location...';

  @override
  void initState() {
    super.initState();

    tripData.addListener(
      _onTripDataChanged,
    );

    _getCurrentLocation();
  }

  @override
  void dispose() {
    tripData.removeListener(
      _onTripDataChanged,
    );

    mapController?.dispose();

    super.dispose();
  }

  void _onTripDataChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  // ==========================================================
  // CURRENT LOCATION
  // ==========================================================

  Future<void>
      _getCurrentLocation() async {
    try {
      final serviceEnabled =
          await Geolocator
              .isLocationServiceEnabled();

      if (!serviceEnabled) {
        setState(() {
          isLoading = false;

          locationMessage =
              'Location services are disabled.';
        });

        DomHelper.updateStatus(
          'Location services are disabled',
        );

        return;
      }

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission ==
          LocationPermission.denied) {
        permission =
            await Geolocator
                .requestPermission();
      }

      if (permission ==
          LocationPermission.denied) {
        setState(() {
          isLoading = false;

          locationMessage =
              'Location permission denied.';
        });

        DomHelper.updateStatus(
          'Location permission denied',
        );

        return;
      }

      if (permission ==
          LocationPermission
              .deniedForever) {
        setState(() {
          isLoading = false;

          locationMessage =
              'Location permission permanently denied.';
        });

        DomHelper.updateStatus(
          'Location permission permanently denied',
        );

        return;
      }

      final position =
          await Geolocator
              .getCurrentPosition(
        locationSettings:
            const LocationSettings(
          accuracy:
              LocationAccuracy.high,
        ),
      );

      final location = LatLng(
        position.latitude,
        position.longitude,
      );

      setState(() {
        currentLocation =
            location;

        isLoading = false;

        locationMessage =
            'Location found';
      });

      DomHelper.updateStatus(
        'Current location obtained successfully',
      );

      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          location,
          11.5,
        ),
      );
    } catch (e) {
      setState(() {
        isLoading = false;

        locationMessage =
            'Unable to get your location.';
      });

      DomHelper.updateStatus(
        'Unable to get current location',
      );
    }
  }

  // ==========================================================
  // MARKERS
  // ==========================================================

  Set<Marker> _buildMarkers() {
    final markers =
        <Marker>{};

    // --------------------------------------------------------
    // CURRENT LOCATION
    // --------------------------------------------------------

    if (currentLocation != null) {
      markers.add(
        Marker(
          markerId:
              const MarkerId(
            'current_location',
          ),

          position:
              currentLocation!,

          icon:
              BitmapDescriptor
                  .defaultMarkerWithHue(
            BitmapDescriptor
                .hueAzure,
          ),

          infoWindow:
              const InfoWindow(
            title:
                'Your Current Location',
          ),

          onTap: () {
            DomHelper.updateStatus(
              'DOM Event: Current location marker selected',
            );
          },
        ),
      );
    }

    // --------------------------------------------------------
    // DESTINATION MARKERS
    // --------------------------------------------------------

    for (final place
        in tripData.places) {
      // Places added manually don't
      // have coordinates yet.
      if (place.latitude == 0 ||
          place.longitude == 0) {
        continue;
      }

      markers.add(
        Marker(
          markerId:
              MarkerId(place.name),

          position: LatLng(
            place.latitude,
            place.longitude,
          ),

          icon:
              BitmapDescriptor
                  .defaultMarkerWithHue(
            place.visited
                ? BitmapDescriptor
                    .hueGreen
                : BitmapDescriptor
                    .hueRed,
          ),

          infoWindow:
              InfoWindow(
            title: place.name,

            snippet: place.visited
                ? '✓ Completed'
                : 'Ready to explore',
          ),

          // Experiment 5:
          // Google Maps marker event triggers
          // a browser DOM update.
          onTap: () {
            DomHelper.updateStatus(
              '${place.name}: '
              '${place.visited ? "Completed" : "Ready to explore"}',
            );
          },
        ),
      );
    }

    return markers;
  }

  // ==========================================================
  // RECENTER
  // ==========================================================

  void _recenter() {
    if (currentLocation ==
            null ||
        mapController ==
            null) {
      DomHelper.updateStatus(
        'Current location is not available yet',
      );

      return;
    }

    mapController!.animateCamera(
      CameraUpdate.newLatLngZoom(
        currentLocation!,
        12.5,
      ),
    );

    DomHelper.updateStatus(
      'Map recentered using current location',
    );
  }

  // ==========================================================
  // MAP
  // ==========================================================

  Widget _map() {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(24),

      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                const CameraPosition(
              target: LatLng(
                15.4909,
                73.8278,
              ),
              zoom: 10.5,
            ),

            onMapCreated:
                (controller) {
              mapController =
                  controller;

              DomHelper.updateStatus(
                'Google Map initialized successfully',
              );
            },

            markers:
                _buildMarkers(),

            myLocationEnabled:
                false,

            myLocationButtonEnabled:
                false,

            zoomControlsEnabled:
                false,

            compassEnabled:
                true,

            mapToolbarEnabled:
                true,
          ),

          // --------------------------------------------------
          // LIVE LOCATION LABEL
          // --------------------------------------------------

          Positioned(
            top: 14,
            left: 14,

            child: Container(
              padding:
                  const EdgeInsets
                      .symmetric(
                horizontal: 14,
                vertical: 9,
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
                        Colors.black
                            .withValues(
                      alpha: 0.10,
                    ),

                    blurRadius: 10,
                  ),
                ],
              ),

              child: Row(
                mainAxisSize:
                    MainAxisSize.min,

                children: [
                  Container(
                    width: 8,
                    height: 8,

                    decoration:
                        const BoxDecoration(
                      color:
                          Color(0xFF10B981),

                      shape:
                          BoxShape.circle,
                    ),
                  ),

                  const SizedBox(
                    width: 7,
                  ),

                  const Text(
                    'Live Location',

                    style: TextStyle(
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --------------------------------------------------
          // RECENTER
          // --------------------------------------------------

          Positioned(
            right: 14,
            bottom: 14,

            child:
                FloatingActionButton(
              mini: true,

              backgroundColor:
                  Colors.white,

              foregroundColor:
                  const Color(
                0xFF2563EB,
              ),

              onPressed:
                  _recenter,

              child: const Icon(
                Icons
                    .my_location_rounded,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // LOCATION CARD
  // ==========================================================

  Widget _locationCard() {
    return Container(
      padding:
          const EdgeInsets.all(20),

      decoration:
          BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(
              alpha: 0.04,
            ),

            blurRadius: 15,

            offset:
                const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Text(
            'Current Location',

            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.w800,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            isLoading
                ? 'Getting your location...'
                : locationMessage,

            style:
                const TextStyle(
              color:
                  Color(0xFF64748B),
            ),
          ),

          const SizedBox(height: 18),

          if (currentLocation !=
              null)
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                14,
              ),

              decoration:
                  BoxDecoration(
                color:
                    const Color(
                  0xFFEFF4FF,
                ),

                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
              ),

              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.all(
                      10,
                    ),

                    decoration:
                        const BoxDecoration(
                      color:
                          Color(0xFFE0EAFF),

                      shape:
                          BoxShape.circle,
                    ),

                    child:
                        const Icon(
                      Icons
                          .my_location_rounded,

                      color:
                          Color(0xFF2563EB),
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [
                      const Text(
                        'GPS Coordinates',

                        style:
                            TextStyle(
                          color:
                              Color(
                            0xFF64748B,
                          ),
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      Text(
                        '${currentLocation!.latitude.toStringAsFixed(5)}°, '
                        '${currentLocation!.longitude.toStringAsFixed(5)}°',

                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight
                                  .w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          const SizedBox(
            height: 18,
          ),

          const Text(
            'Map Controls',

            style: TextStyle(
              fontWeight:
                  FontWeight.w700,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Pan and zoom the map to explore destinations. '
            'Tap a marker to view trip details.',

            style: TextStyle(
              color:
                  Color(0xFF64748B),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // TRIP PROGRESS
  // ==========================================================

  Widget _progressCard() {
    final progress =
        tripData.progress;

    final next =
        tripData.nextDestination;

    return Container(
      padding:
          const EdgeInsets.all(20),

      decoration:
          BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(
              alpha: 0.04,
            ),

            blurRadius: 15,

            offset:
                const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Text(
            'Trip Progress',

            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.w800,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Your journey at a glance',

            style: TextStyle(
              color:
                  Color(0xFF64748B),
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

            children: [
              Text(
                '${tripData.visitedCount} of '
                '${tripData.totalPlaces} places visited',

                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.w600,
                ),
              ),

              Text(
                '${(progress * 100).round()}%',

                style:
                    const TextStyle(
                  color:
                      Color(0xFF2563EB),

                  fontWeight:
                      FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 10,
          ),

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
                  const Color(
                0xFFE2E8F0,
              ),

              valueColor:
                  const AlwaysStoppedAnimation<
                      Color>(
                Color(0xFF2563EB),
              ),
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          if (next != null)
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                14,
              ),

              decoration:
                  BoxDecoration(
                color:
                    const Color(
                  0xFFF8FAFC,
                ),

                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
              ),

              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.all(
                      10,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          next.color
                              .withValues(
                        alpha: 0.1,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),

                    child: Icon(
                      next.icon,
                      color:
                          next.color,
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [
                        const Text(
                          'Next Destination',

                          style:
                              TextStyle(
                            color:
                                Color(
                              0xFF64748B,
                            ),

                            fontSize:
                                12,
                          ),
                        ),

                        const SizedBox(
                          height: 3,
                        ),

                        Text(
                          next.name,

                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight
                                    .w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else
            const Text(
              '🎉 All destinations completed!',

              style: TextStyle(
                color:
                    Color(0xFF10B981),

                fontWeight:
                    FontWeight.w700,
              ),
            ),
        ],
      ),
    );
  }

  // ==========================================================
  // RESPONSIVE CONTENT
  // ==========================================================

  Widget _content() {
    return LayoutBuilder(
      builder:
          (context, constraints) {
        final isWide =
            constraints.maxWidth >= 900;

        return OrientationBuilder(
          builder:
              (context, orientation) {
            final isLandscape =
                orientation ==
                    Orientation.landscape;

            if (isWide ||
                isLandscape) {
              return Row(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  Expanded(
                    flex: 3,

                    child: _map(),
                  ),

                  const SizedBox(
                    width: 18,
                  ),

                  Expanded(
                    flex: 2,

                    child:
                        SingleChildScrollView(
                      child: Column(
                        children: [
                          _locationCard(),

                          const SizedBox(
                            height: 18,
                          ),

                          _progressCard(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                Expanded(
                  flex: 5,

                  child: _map(),
                ),

                const SizedBox(
                  height: 16,
                ),

                _locationCard(),

                const SizedBox(
                  height: 16,
                ),

                _progressCard(),
              ],
            );
          },
        );
      },
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trip Tracker',

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
                  const Color(0xFFE8FFF5),

              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),

            child: const Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 8,
                  color:
                      Color(0xFF10B981),
                ),

                SizedBox(width: 6),

                Text(
                  'ACTIVE',

                  style: TextStyle(
                    color:
                        Color(0xFF059669),

                    fontWeight:
                        FontWeight.w700,

                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      body: Padding(
        padding:
            const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          16,
        ),

        child: _content(),
      ),
    );
  }
}