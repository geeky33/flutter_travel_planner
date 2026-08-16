import 'package:flutter/material.dart';

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
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.flight_takeoff,
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
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Hello, Traveler! 👋',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Plan your next adventure',
              style: TextStyle(
                fontSize: 28,
                height: 1.15,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Everything you need for your journey, in one place.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),

            const SizedBox(height: 24),

            // HERO TRIP CARD
            _buildTripCard(),

            const SizedBox(height: 28),

            // SECTION TITLE
            _sectionTitle(
              'Trip Overview',
              'Your journey at a glance',
            ),

            const SizedBox(height: 14),

            // ROW
            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    icon: Icons.place_rounded,
                    value: '5',
                    title: 'Places',
                    color: const Color(0xFF2563EB),
                    background: const Color(0xFFEFF4FF),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _infoCard(
                    icon: Icons.calendar_month_rounded,
                    value: '4',
                    title: 'Days',
                    color: const Color(0xFF8B5CF6),
                    background: const Color(0xFFF3EEFF),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _infoCard(
                    icon: Icons.check_circle_rounded,
                    value: '2',
                    title: 'Visited',
                    color: const Color(0xFF10B981),
                    background: const Color(0xFFE9FBF4),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            _sectionTitle(
              'Upcoming',
              'Your next destinations',
            ),

            const SizedBox(height: 14),

            _placeCard(
              name: 'Baga Beach',
              time: 'Day 1 • 10:00 AM',
              icon: Icons.beach_access_rounded,
              color: const Color(0xFF0EA5E9),
            ),

            const SizedBox(height: 10),

            _placeCard(
              name: 'Fort Aguada',
              time: 'Day 2 • 11:00 AM',
              icon: Icons.castle_rounded,
              color: const Color(0xFF8B5CF6),
            ),

            const SizedBox(height: 10),

            _placeCard(
              name: 'Dudhsagar Falls',
              time: 'Day 3 • 9:00 AM',
              icon: Icons.water_drop_rounded,
              color: const Color(0xFF10B981),
            ),

            const SizedBox(height: 28),

            // TRAVEL TIP
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFF7ED),
                    Color(0xFFFFF1E6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                borderRadius: BorderRadius.circular(20),

                border: Border.all(
                  color: const Color(0xFFFED7AA),
                ),
              ),

              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(11),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: const Icon(
                      Icons.lightbulb_rounded,
                      color: Color(0xFFF97316),
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Travel Tip',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF9A3412),
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          'Keep some extra time between destinations for unexpected delays.',
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.4,
                            color: Color(0xFF7C2D12),
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
    );
  }

  // ----------------------------------------------------------
  // HERO TRIP CARD
  // ----------------------------------------------------------

  static Widget _buildTripCard() {
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

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.circular(28),

        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withOpacity(0.25),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),

      child: Stack(
        children: [
          // Decorative circle
          Positioned(
            right: -40,
            top: -40,

            child: Container(
              width: 150,
              height: 150,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),

          Positioned(
            right: 30,
            bottom: -60,

            child: Container(
              width: 140,
              height: 140,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(22),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: const Icon(
                        Icons.flight_takeoff_rounded,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: const Text(
                        'UPCOMING',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
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
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Goa, India 🌴',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 5),

                const Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.white70,
                      size: 14,
                    ),

                    SizedBox(width: 7),

                    Text(
                      '15 Aug - 19 Aug 2026',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // SECTION TITLE
  // ----------------------------------------------------------

  static Widget _sectionTitle(
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),

        const SizedBox(height: 3),

        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // INFO CARD
  // ----------------------------------------------------------

  static Widget _infoCard({
    required IconData icon,
    required String value,
    required String title,
    required Color color,
    required Color background,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 17,
        horizontal: 8,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(9),

            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: color,
              size: 21,
            ),
          ),

          const SizedBox(height: 9),

          Text(
            value,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),

          const SizedBox(height: 2),

          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // PLACE CARD
  // ----------------------------------------------------------

  static Widget _placeCard({
    required String name,
    required String time,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 6,
        ),

        leading: Container(
          padding: const EdgeInsets.all(11),

          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
          ),

          child: Icon(
            icon,
            color: color,
          ),
        ),

        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),
        ),

        trailing: Container(
          padding: const EdgeInsets.all(8),

          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(10),
          ),

          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 13,
            color: Color(0xFF64748B),
          ),
        ),
      ),
    );
  }
}