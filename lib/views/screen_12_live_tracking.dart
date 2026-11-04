import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class Screen12LiveTracking extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen12LiveTracking({super.key, this.onNavigate});

  @override
  State<Screen12LiveTracking> createState() => _Screen12LiveTrackingState();
}

class _Screen12LiveTrackingState extends State<Screen12LiveTracking> {
  bool isSharingLocation = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5EEF0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => widget.onNavigate?.call('11-buddy-profile'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dr NTR Beach Rd • Vizag',
              style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Destination: Sea Pearl Coastal Cafe (1.2 km)',
              style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.warning_amber_rounded, color: AppTheme.primaryColor),
            onPressed: () => widget.onNavigate?.call('13-sos-center'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppTheme.cardBorderColor, height: 1),
        ),
      ),
      body: Column(
        children: [
          // Turn-by-turn banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: const Color(0xFFF97316),
            child: Row(
              children: [
                const Icon(Icons.turn_left_rounded, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'In 120 meters',
                        style: AppTheme.sansBody(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70),
                      ),
                      Text(
                        'Turn Left onto Beach Road Boardwalk',
                        style: AppTheme.sansBody(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text('2 min', style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text('120 m', style: AppTheme.sansBody(fontSize: 9, color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Map Area
          Expanded(
            child: Stack(
              children: [
                // Stylized Canvas Map representation
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFE2F1F8), Color(0xFFD6EBF4), Color(0xFFBCE1F2)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Coastline sand area
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          width: 140,
                          child: Container(
                            color: const Color(0xFFF5EADA),
                          ),
                        ),
                        // Road line
                        Positioned(
                          left: 110,
                          top: 0,
                          bottom: 0,
                          width: 24,
                          child: Container(
                            color: const Color(0xFF9E9E9E),
                            child: Center(
                              child: Container(
                                width: 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // Route line
                        Positioned(
                          left: 118,
                          top: 80,
                          bottom: 120,
                          width: 6,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),

                        // Pins
                        Positioned(
                          top: 40,
                          left: 80,
                          child: _buildMapPin(Icons.landscape_rounded, 'Kailasagiri\nView Point', Colors.purple),
                        ),
                        Positioned(
                          top: 130,
                          left: 140,
                          child: _buildMapPin(Icons.surfing_rounded, 'Rushikonda\nBeach', Colors.blue),
                        ),
                        Positioned(
                          top: 220,
                          left: 160,
                          child: _buildMapPin(Icons.restaurant_rounded, 'Sea Pearl\nCoastal Cafe\n1.2 km • 14 min', AppTheme.primaryColor, isDestination: true),
                        ),
                        Positioned(
                          top: 360,
                          left: 40,
                          child: _buildMapPin(Icons.beach_access_rounded, 'RK Beach', Colors.teal),
                        ),

                        // You (Elena) Marker
                        Positioned(
                          bottom: 150,
                          left: 100,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [BoxShadow(color: Color(0x20000000), blurRadius: 4)],
                                ),
                                child: Text('You (Elena)', style: AppTheme.sansBody(fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 2),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E88E5),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 3),
                                  boxShadow: const [BoxShadow(color: Color(0x30000000), blurRadius: 6)],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Buddy (Priya) Marker 300m ahead
                        Positioned(
                          bottom: 230,
                          left: 110,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text('Priya • 300 m', style: AppTheme.sansBody(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                              ),
                              const SizedBox(height: 2),
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 3),
                                  boxShadow: const [BoxShadow(color: Color(0x30000000), blurRadius: 6)],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Bay of Bengal Label
                        Positioned(
                          right: 30,
                          top: 260,
                          child: Text(
                            'Bay of Bengal',
                            style: AppTheme.serifTitle(fontSize: 18, color: const Color(0x600D47A1), fontWeight: FontWeight.bold),
                          ),
                        ),

                        // Weather Widget
                        Positioned(
                          top: 14,
                          right: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 8)],
                            ),
                            child: Row(
                              children: [
                                const Text('☀️ ', style: TextStyle(fontSize: 13)),
                                Text('28°C ', style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold)),
                                Text('Clear Sky', style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
                              ],
                            ),
                          ),
                        ),

                        // Floating map tools
                        Positioned(
                          right: 14,
                          top: 70,
                          child: Column(
                            children: [
                              _buildToolIcon(Icons.layers_rounded),
                              const SizedBox(height: 8),
                              _buildToolIcon(Icons.my_location_rounded),
                              const SizedBox(height: 8),
                              _buildToolIcon(Icons.near_me_rounded),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom Tracking Card
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: AppTheme.cardBorderColor),
                      boxShadow: const [
                        BoxShadow(color: Color(0x14231815), blurRadius: 16, offset: Offset(0, -2)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('14 min', style: AppTheme.serifTitle(fontSize: 20, fontWeight: FontWeight.bold)),
                                Text('1.2 km • Arriving at 10:15 AM', style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
                              ],
                            ),
                            // Buddy Pill
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppTheme.chipBackground,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppTheme.chipBorder),
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 12,
                                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&fm=webp&fit=crop&q=80'),
                                  ),
                                  const SizedBox(width: 6),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Priya', style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold)),
                                      Text('300 m ahead', style: AppTheme.sansBody(fontSize: 9.5, color: AppTheme.primaryColor)),
                                    ],
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.phone_in_talk_rounded, size: 14, color: AppTheme.primaryColor),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Route sequence
                        Row(
                          children: [
                            _buildRoutePill('Your Location', '(Dr NTR Beach Rd)'),
                            const Icon(Icons.arrow_forward_rounded, size: 14, color: AppTheme.textSecondaryLight),
                            _buildRoutePill('En route', 'with Priya'),
                            const Icon(Icons.arrow_forward_rounded, size: 14, color: AppTheme.textSecondaryLight),
                            _buildRoutePill('Destination', 'Sea Pearl Cafe', isLast: true),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Bottom Actions
                        Row(
                          children: [
                            Expanded(
                              child: _buildActionBtn(
                                Icons.share_location_rounded,
                                'Share Live',
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Live GPS tracking link copied to clipboard!')),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildActionBtn(
                                Icons.call_rounded,
                                'Call Buddy',
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildActionBtn(
                                Icons.chat_bubble_outline_rounded,
                                'Chat',
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: InkWell(
                                onTap: () => widget.onNavigate?.call('13-sos-center'),
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppTheme.sosRed,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.shield_rounded, color: Colors.white, size: 14),
                                      const SizedBox(width: 4),
                                      Text('SOS', style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPin(IconData icon, String title, Color color, {bool isDestination = false}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: const [BoxShadow(color: Color(0x20000000), blurRadius: 4)],
          ),
          child: Icon(icon, color: Colors.white, size: 14),
        ),
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            title,
            style: AppTheme.sansBody(
              fontSize: 8.5,
              fontWeight: isDestination ? FontWeight.bold : FontWeight.w600,
              color: isDestination ? AppTheme.primaryColor : AppTheme.textPrimaryLight,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildToolIcon(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 6)],
      ),
      child: Icon(icon, size: 18, color: AppTheme.textPrimaryLight),
    );
  }

  Widget _buildRoutePill(String title, String subtitle, {bool isLast = false}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTheme.sansBody(fontSize: 9.5, color: AppTheme.textSecondaryLight)),
          Text(
            subtitle,
            style: AppTheme.sansBody(fontSize: 10, fontWeight: FontWeight.bold, color: isLast ? AppTheme.primaryColor : AppTheme.textPrimaryLight),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(IconData icon, String label, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppTheme.backgroundLight,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.cardBorderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: AppTheme.textPrimaryLight),
            const SizedBox(width: 3),
            Text(label, style: AppTheme.sansBody(fontSize: 10.5, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
