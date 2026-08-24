import 'package:flutter/material.dart';

class TrackerScreen extends StatelessWidget {
  const TrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth =
        MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trip Tracker',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),

        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 16,
            ),

            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 7,
            ),

            decoration: BoxDecoration(
              color: const Color(0xFFE9FBF4),
              borderRadius: BorderRadius.circular(20),
            ),

            child: const Row(
              children: [
                Icon(
                  Icons.circle,
                  color: Color(0xFF10B981),
                  size: 8,
                ),

                SizedBox(width: 6),

                Text(
                  'ACTIVE',
                  style: TextStyle(
                    color: Color(0xFF059669),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 700;

          return OrientationBuilder(
            builder: (context, orientation) {
              final isLandscape =
                  orientation == Orientation.landscape;

              return SingleChildScrollView(
                physics:
                    const BouncingScrollPhysics(),

                padding: EdgeInsets.all(
                  isWide ? 30 : 20,
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Where are you now?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF64748B),
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'Current Location',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // =================================================
                    // RESPONSIVE ORIENTATION LAYOUT
                    // =================================================

                    if (isLandscape || isWide)
                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          Expanded(
                            flex: 3,
                            child: _locationCard(),
                          ),

                          const SizedBox(width: 20),

                          Expanded(
                            flex: 2,
                            child: _progressCard(),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          _locationCard(),

                          const SizedBox(height: 25),

                          _progressCard(),
                        ],
                      ),

                    const SizedBox(height: 28),

                    _nextDestination(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // ==========================================================
  // LOCATION CARD
  // ==========================================================

  Widget _locationCard() {
    return Container(
      width: double.infinity,
      height: 300,

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0F172A),
            Color(0xFF1E3A8A),
            Color(0xFF2563EB),
          ],

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.circular(28),

        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A8A)
                .withOpacity(0.25),

            blurRadius: 25,

            offset: const Offset(0, 12),
          ),
        ],
      ),

      child: Stack(
        children: [
          Positioned(
            right: -50,
            top: -50,

            child: Container(
              width: 170,
              height: 170,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          Positioned(
            left: -70,
            bottom: -70,

            child: Container(
              width: 190,
              height: 190,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Colors.cyan.withOpacity(0.05),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const Text(
                  'YOU ARE CURRENTLY IN',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Goa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const Text(
                  'India 🇮🇳',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),

                const Spacer(),

                Container(
                  padding: const EdgeInsets.all(14),

                  decoration: BoxDecoration(
                    color:
                        Colors.white.withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(16),
                  ),

                  child: const Row(
                    children: [
                      Icon(
                        Icons.gps_fixed_rounded,
                        color: Colors.cyanAccent,
                        size: 20,
                      ),

                      SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [
                            Text(
                              'GPS Coordinates',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                            ),

                            SizedBox(height: 3),

                            Text(
                              '15.2993° N, 74.1240° E',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight:
                                    FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            right: 25,
            top: 25,

            child: Container(
              padding: const EdgeInsets.all(13),

              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,

                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: const Icon(
                Icons.location_on_rounded,
                color: Color(0xFFEF4444),
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // PROGRESS CARD
  // ==========================================================

  Widget _progressCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 12,
            offset: const Offset(0, 5),
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
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'You are making great progress!',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [
              const Text(
                'Places visited',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF334155),
                ),
              ),

              const Text(
                '40%',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),

            child: const LinearProgressIndicator(
              value: 0.4,
              minHeight: 10,

              backgroundColor:
                  Color(0xFFE2E8F0),

              valueColor:
                  AlwaysStoppedAnimation<Color>(
                Color(0xFF10B981),
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            '2 of 5 places visited',
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 20),

          // FLEXIBLE / EXPANDED ROW
          Row(
            children: [
              Expanded(
                child: _miniStat(
                  'Days',
                  '4',
                  Icons.calendar_month_rounded,
                  const Color(0xFF8B5CF6),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _miniStat(
                  'Visited',
                  '2',
                  Icons.check_circle_rounded,
                  const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // MINI STAT
  // ==========================================================

  Widget _miniStat(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),

          const SizedBox(width: 8),

          Flexible(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),

                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // NEXT DESTINATION
  // ==========================================================

  Widget _nextDestination() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        const Text(
          'Next Destination',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),

        const SizedBox(height: 5),

        const Text(
          'Your upcoming stop',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF64748B),
          ),
        ),

        const SizedBox(height: 14),

        Container(
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),

            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(0.035),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(13),

                decoration: BoxDecoration(
                  color: const Color(0xFFEFF4FF),
                  borderRadius:
                      BorderRadius.circular(15),
                ),

                child: const Icon(
                  Icons.castle_rounded,
                  color: Color(0xFF2563EB),
                ),
              ),

              const SizedBox(width: 14),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Fort Aguada',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Next stop • 11:00 AM',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: Color(0xFF64748B),
              ),
            ],
          ),
        ),
      ],
    );
  }
}