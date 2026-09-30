import 'package:flutter/material.dart';

import '../dom/dom_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),

              decoration: BoxDecoration(
                color: const Color(0xFFE0EAFF),
                borderRadius:
                    BorderRadius.circular(12),
              ),

              child: const Icon(
                Icons.flight_takeoff_rounded,
                color: Color(0xFF2563EB),
                size: 22,
              ),
            ),

            const SizedBox(width: 12),

            const Text(
              'TravelMate',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 21,
              ),
            ),
          ],
        ),

        actions: [
          Container(
            margin:
                const EdgeInsets.only(right: 16),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(14),
            ),

            child: IconButton(
              onPressed: () {
                DomHelper.updateStatus(
                  'Notification button clicked - DOM event detected',
                );
              },

              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return _mobileLayout();
          }

          if (constraints.maxWidth < 1024) {
            return _tabletLayout();
          }

          return _desktopLayout();
        },
      ),
    );
  }

  // ==========================================================
  // MOBILE
  // ==========================================================

  Widget _mobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        20,
        10,
        20,
        30,
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          _welcome(),

          const SizedBox(height: 24),

          _tripCard(),

          const SizedBox(height: 24),

          _domDemoCard(),

          const SizedBox(height: 28),

          _sectionTitle(
            'Trip Overview',
            'Your journey at a glance',
          ),

          const SizedBox(height: 14),

          Column(
            children: [
              _statCard(
                Icons.place_rounded,
                '5',
                'Places',
                const Color(0xFF2563EB),
                const Color(0xFFEFF4FF),
              ),

              const SizedBox(height: 12),

              _statCard(
                Icons.calendar_month_rounded,
                '4',
                'Days',
                const Color(0xFF8B5CF6),
                const Color(0xFFF3EEFF),
              ),

              const SizedBox(height: 12),

              _statCard(
                Icons.check_circle_rounded,
                '2',
                'Visited',
                const Color(0xFF10B981),
                const Color(0xFFE9FBF4),
              ),
            ],
          ),

          const SizedBox(height: 28),

          _upcoming(),

          const SizedBox(height: 25),

          _travelTip(),
        ],
      ),
    );
  }

  // ==========================================================
  // TABLET
  // ==========================================================

  Widget _tabletLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          _welcome(),

          const SizedBox(height: 25),

          _tripCard(),

          const SizedBox(height: 24),

          _domDemoCard(),

          const SizedBox(height: 28),

          _sectionTitle(
            'Trip Overview',
            'Your journey at a glance',
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: _statCard(
                  Icons.place_rounded,
                  '5',
                  'Places',
                  const Color(0xFF2563EB),
                  const Color(0xFFEFF4FF),
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: _statCard(
                  Icons.calendar_month_rounded,
                  '4',
                  'Days',
                  const Color(0xFF8B5CF6),
                  const Color(0xFFF3EEFF),
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: _statCard(
                  Icons.check_circle_rounded,
                  '2',
                  'Visited',
                  const Color(0xFF10B981),
                  const Color(0xFFE9FBF4),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          _upcoming(),

          const SizedBox(height: 25),

          _travelTip(),
        ],
      ),
    );
  }

  // ==========================================================
  // DESKTOP
  // ==========================================================

  Widget _desktopLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 45,
        vertical: 25,
      ),

      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(
            maxWidth: 1250,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              _welcome(),

              const SizedBox(height: 25),

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Flexible(
                    flex: 2,
                    child: _tripCard(),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    flex: 1,

                    child: Column(
                      children: [
                        _statCard(
                          Icons.place_rounded,
                          '5',
                          'Places',
                          const Color(0xFF2563EB),
                          const Color(0xFFEFF4FF),
                        ),

                        const SizedBox(height: 12),

                        _statCard(
                          Icons.calendar_month_rounded,
                          '4',
                          'Days',
                          const Color(0xFF8B5CF6),
                          const Color(0xFFF3EEFF),
                        ),

                        const SizedBox(height: 12),

                        _statCard(
                          Icons.check_circle_rounded,
                          '2',
                          'Visited',
                          const Color(0xFF10B981),
                          const Color(0xFFE9FBF4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              _domDemoCard(),

              const SizedBox(height: 35),

              _sectionTitle(
                'Upcoming',
                'Your next destinations',
              ),

              const SizedBox(height: 15),

              Wrap(
                spacing: 15,
                runSpacing: 15,

                children: [
                  SizedBox(
                    width: 380,
                    child: _placeCard(
                      'Baga Beach',
                      'Day 1 • 10:00 AM',
                      Icons.beach_access_rounded,
                      const Color(0xFF0EA5E9),
                    ),
                  ),

                  SizedBox(
                    width: 380,
                    child: _placeCard(
                      'Fort Aguada',
                      'Day 2 • 11:00 AM',
                      Icons.castle_rounded,
                      const Color(0xFF8B5CF6),
                    ),
                  ),

                  SizedBox(
                    width: 380,
                    child: _placeCard(
                      'Dudhsagar Falls',
                      'Day 3 • 9:00 AM',
                      Icons.water_drop_rounded,
                      const Color(0xFF10B981),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              _travelTip(),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // DOM DEMO CARD
  // ==========================================================

  Widget _domDemoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: const Color(0xFFE0EAFF),
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: const Color(0xFFE0EAFF),
                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: const Icon(
                  Icons.code_rounded,
                  color: Color(0xFF2563EB),
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Dart DOM Lab',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    SizedBox(height: 3),

                    Text(
                      'Interact with the browser DOM',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          const Text(
            'Experiment 5: HTML DOM Application',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
            ),
          ),

          const SizedBox(height: 14),

          Wrap(
            spacing: 10,
            runSpacing: 10,

            children: [
              ElevatedButton.icon(
                onPressed: () {
                  DomHelper.updateStatus(
                    'DOM updated successfully from HomeScreen!',
                  );
                },

                icon: const Icon(
                  Icons.edit_rounded,
                ),

                label: const Text(
                  'Update DOM',
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                ),
              ),

              OutlinedButton.icon(
                onPressed: () {
                  DomHelper.setPageTitle(
                    'TravelMate • DOM Updated',
                  );

                  DomHelper.updateStatus(
                    'Browser page title updated using Dart DOM!',
                  );
                },

                icon: const Icon(
                  Icons.title_rounded,
                ),

                label: const Text(
                  'Change Title',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // WELCOME
  // ==========================================================

  Widget _welcome() {
    return const Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Text(
          'Hello, Traveler! 👋',

          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),

        SizedBox(height: 6),

        Text(
          'Plan your next adventure',

          style: TextStyle(
            fontSize: 28,
            height: 1.15,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),

        SizedBox(height: 8),

        Text(
          'Everything you need for your journey, in one place.',

          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // TRIP CARD
  // ==========================================================

  Widget _tripCard() {
    return Container(
      width: double.infinity,
      height: 220,

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1D4ED8),
            Color(0xFF2563EB),
            Color(0xFF0EA5E9),
          ],
        ),

        borderRadius:
            BorderRadius.circular(28),

        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB)
                .withValues(alpha: 0.25),

            blurRadius: 25,

            offset: const Offset(0, 12),
          ),
        ],
      ),

      child: Stack(
        children: [
          Positioned(
            right: -40,
            top: -40,

            child: Container(
              width: 150,
              height: 150,

              decoration:
                  BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
                    .withValues(alpha: 0.08),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(22),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [
                    Container(
                      padding:
                          const EdgeInsets.all(10),

                      decoration:
                          BoxDecoration(
                        color: Colors.white
                            .withValues(alpha: 0.18),

                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),

                      child: const Icon(
                        Icons.flight_takeoff_rounded,
                        color: Colors.white,
                      ),
                    ),

                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),

                      decoration:
                          BoxDecoration(
                        color: Colors.white
                            .withValues(alpha: 0.15),

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),
                      ),

                      child: const Text(
                        'UPCOMING',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight:
                              FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                const Text(
                  'MY NEXT TRIP',

                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Goa, India 🌴',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  '15 Aug - 19 Aug 2026',

                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
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
  // STAT CARD
  // ==========================================================

  Widget _statCard(
    IconData icon,
    String value,
    String title,
    Color color,
    Color background,
  ) {
    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 10,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(alpha: 0.04),

            blurRadius: 12,

            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.all(9),

            decoration: BoxDecoration(
              color: background,
              borderRadius:
                  BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(width: 12),

          Flexible(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  value,

                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight:
                        FontWeight.w800,
                    color:
                        Color(0xFF0F172A),
                  ),
                ),

                Text(
                  title,

                  style: const TextStyle(
                    color:
                        Color(0xFF64748B),
                    fontSize: 11,
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
  // UPCOMING
  // ==========================================================

  Widget _upcoming() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        _sectionTitle(
          'Upcoming',
          'Your next destinations',
        ),

        const SizedBox(height: 14),

        _placeCard(
          'Baga Beach',
          'Day 1 • 10:00 AM',
          Icons.beach_access_rounded,
          const Color(0xFF0EA5E9),
        ),

        const SizedBox(height: 10),

        _placeCard(
          'Fort Aguada',
          'Day 2 • 11:00 AM',
          Icons.castle_rounded,
          const Color(0xFF8B5CF6),
        ),

        const SizedBox(height: 10),

        _placeCard(
          'Dudhsagar Falls',
          'Day 3 • 9:00 AM',
          Icons.water_drop_rounded,
          const Color(0xFF10B981),
        ),
      ],
    );
  }

  Widget _placeCard(
    String name,
    String time,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(alpha: 0.035),

            blurRadius: 12,

            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 6,
        ),

        leading: Container(
          padding:
              const EdgeInsets.all(11),

          decoration: BoxDecoration(
            color:
                color.withValues(alpha: 0.1),

            borderRadius:
                BorderRadius.circular(14),
          ),

          child: Icon(
            icon,
            color: color,
          ),
        ),

        title: Text(
          name,

          style: const TextStyle(
            fontWeight:
                FontWeight.w700,
            color:
                Color(0xFF0F172A),
          ),
        ),

        subtitle: Text(
          time,

          style: const TextStyle(
            fontSize: 12,
            color:
                Color(0xFF64748B),
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 14,
          color: Color(0xFF64748B),
        ),
      ),
    );
  }

  // ==========================================================
  // SECTION TITLE
  // ==========================================================

  Widget _sectionTitle(
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Text(
          title,

          style: const TextStyle(
            fontSize: 20,
            fontWeight:
                FontWeight.w800,
            color:
                Color(0xFF0F172A),
          ),
        ),

        const SizedBox(height: 3),

        Text(
          subtitle,

          style: const TextStyle(
            fontSize: 12,
            color:
                Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // TRAVEL TIP
  // ==========================================================

  Widget _travelTip() {
    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color:
            const Color(0xFFFFF7ED),

        borderRadius:
            BorderRadius.circular(20),

        border: Border.all(
          color:
              const Color(0xFFFED7AA),
        ),
      ),

      child: const Row(
        children: [
          Icon(
            Icons.lightbulb_rounded,
            color: Color(0xFFF97316),
          ),

          SizedBox(width: 14),

          Expanded(
            child: Text(
              'Keep some extra time between destinations for unexpected delays.',

              style: TextStyle(
                color:
                    Color(0xFF7C2D12),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}