import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';

class Screen13SosCenter extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen13SosCenter({super.key, this.onNavigate});

  @override
  State<Screen13SosCenter> createState() => _Screen13SosCenterState();
}

class _Screen13SosCenterState extends State<Screen13SosCenter> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  bool _isSosActive = true;
  String _incidentId = 'INC-714338';
  final double _lat = 17.7102;
  final double _lng = 83.3184;
  int _nearbyBuddiesNotified = 3;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _toggleSos() {
    setState(() {
      _isSosActive = !_isSosActive;
    });
    if (!_isSosActive) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('SOS Alert Cancelled'),
          backgroundColor: AppTheme.textPrimaryLight,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🚨 SOS Alert Dispatched! Main server & nearby buddies notified.'),
          backgroundColor: AppTheme.sosRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => widget.onNavigate?.call('07-home'),
        ),
        title: Text(
          '24/7 Emergency SOS',
          style: AppTheme.serifTitle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (_isSosActive)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.sosRed,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, size: 12, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    'ALERT ACTIVE',
                    style: AppTheme.sansBody(fontSize: 9.5, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppTheme.cardBorderColor, height: 1),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          children: [
            // Header text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You're Not Alone",
                  style: AppTheme.serifTitle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.shield_rounded, color: AppTheme.primaryColor, size: 20),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Instant emergency server dispatch, live GPS broadcasting & optional nearby Local Buddy response in Vizag.',
              style: AppTheme.sansBody(fontSize: 11.5, color: AppTheme.textSecondaryLight),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Pulsing SOS Button
            Center(
              child: ScaleTransition(
                scale: _isSosActive ? _pulseAnimation : const AlwaysStoppedAnimation(1.0),
                child: GestureDetector(
                  onTap: _toggleSos,
                  child: Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: _isSosActive
                            ? [const Color(0xFFFF416C), AppTheme.sosRed, const Color(0xFF8B0000)]
                            : [Colors.grey.shade400, Colors.grey.shade600],
                        stops: const [0.3, 0.7, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (_isSosActive ? AppTheme.sosRed : Colors.grey).withValues(alpha: 0.4),
                          blurRadius: 24,
                          spreadRadius: 6,
                          offset: const Offset(0, 6),
                        ),
                      ],
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.warning_rounded, color: Colors.white, size: 38),
                        const SizedBox(height: 4),
                        Text(
                          'SOS',
                          style: AppTheme.sansBody(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          _isSosActive ? 'TAP TO CANCEL' : 'TAP TO ACTIVATE',
                          style: AppTheme.sansBody(
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Ticker Banner
            if (_isSosActive)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.sosLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.sosRed.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.sensors_rounded, color: AppTheme.sosRed, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'EMERGENCY ALERT SENT • Live GPS location stream active',
                      style: AppTheme.sansBody(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.sosRed,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 18),

            // Incident Details Cards
            _buildInfoCard(
              icon: Icons.receipt_long_rounded,
              iconColor: AppTheme.primaryColor,
              title: 'Incident #$_incidentId',
              subtitle: 'Reported just now',
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.successLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_rounded, size: 12, color: AppTheme.successGreen),
                    const SizedBox(width: 4),
                    Text(
                      'SERVER CONFIRMED',
                      style: AppTheme.sansBody(fontSize: 9, fontWeight: FontWeight.bold, color: AppTheme.successGreen),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            _buildInfoCard(
              icon: Icons.cloud_done_rounded,
              iconColor: Colors.blue,
              title: 'Main Emergency Server',
              subtitle: 'Vizag Control Center • Dispatch active',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Delivered',
                    style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.successGreen),
                  ),
                  const SizedBox(width: 3),
                  const Icon(Icons.check_rounded, size: 14, color: AppTheme.successGreen),
                ],
              ),
            ),
            const SizedBox(height: 10),

            _buildInfoCard(
              icon: Icons.my_location_rounded,
              iconColor: AppTheme.primaryColor,
              title: 'Live GPS: $_lat° N, $_lng° E',
              subtitle: 'Updated just now • Accuracy ±3.2m',
              trailing: InkWell(
                onTap: () => widget.onNavigate?.call('12-live-tracking'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppTheme.chipBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.chipBorder),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.navigation_rounded, size: 12, color: AppTheme.primaryColor),
                      const SizedBox(width: 4),
                      Text(
                        'Track Live',
                        style: AppTheme.sansBody(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            _buildInfoCard(
              icon: Icons.groups_rounded,
              iconColor: Colors.deepPurple,
              title: 'Nearby Support',
              subtitle: 'Local Buddies in your area are being notified',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppTheme.chipBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$_nearbyBuddiesNotified',
                      style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppTheme.textSecondaryLight),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Red Emergency Action Bar
            if (_isSosActive)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.sosRed,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.sosRed.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.notifications_active_rounded, color: Colors.white, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'SOS EMERGENCY ALERT SENT!\nMain server notified & live GPS active.',
                        style: AppTheme.sansBody(fontSize: 11.5, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 14),
                  ],
                ),
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: SharedBottomNav(
        activeTab: 'sos',
        onNavigate: widget.onNavigate,
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.cardBorderColor),
        boxShadow: const [
          BoxShadow(color: Color(0x06231815), blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.sansBody(fontSize: 12.5, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTheme.sansBody(fontSize: 10.5, color: AppTheme.textSecondaryLight)),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
