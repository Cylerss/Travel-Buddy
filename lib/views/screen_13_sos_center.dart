import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/vizag_models.dart';
import '../services/vizag_data.dart';
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

  // SOS State
  bool _isSosActive = false;
  bool _isSending = false;

  // Location Broadcasting State
  Timer? _gpsBroadcastTimer;
  double _currentLat = 17.7102;
  double _currentLng = 83.3184;
  final double _gpsAccuracy = 3.2;
  String _lastGpsUpdateFormatted = 'Not broadcasting';
  int _broadcastCount = 0;

  // Local Buddy Emergency Response State
  bool _buddyAssistanceRequested = false;
  bool _buddySearching = false;
  bool _buddyAccepted = false;
  Timer? _buddyMatchTimer;

  BuddyData? _assignedBuddy;
  double _buddyDistanceKm = 1.2;
  int _buddyEtaMins = 4;

  EmergencyIncident? _activeIncident;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.14).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _gpsBroadcastTimer?.cancel();
    _buddyMatchTimer?.cancel();
    super.dispose();
  }

  void _triggerSosAlert() async {
    if (_isSending || _isSosActive) return;

    setState(() {
      _isSending = true;
    });

    final timestamp = DateTime.now().toIso8601String();
    final incidentId = 'INC-${Random().nextInt(900000) + 100000}';

    _activeIncident = EmergencyIncident(
      incidentId: incidentId,
      userId: VizagDataService.traveller.name,
      status: 'sending',
      createdAt: timestamp,
      lastLocationUpdateAt: timestamp,
      latitude: _currentLat,
      longitude: _currentLng,
      locationAccuracy: _gpsAccuracy,
      liveTrackingActive: true,
      buddyAssistanceEnabled: _buddyAssistanceRequested,
    );

    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;

    setState(() {
      _isSending = false;
      _isSosActive = true;
      _activeIncident?.status = 'active';
      _lastGpsUpdateFormatted = 'Just now';
    });

    _startGpsBroadcasting();

    if (_buddyAssistanceRequested) {
      _initiateNearbyBuddyMatch();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🚨 SOS EMERGENCY ALERT SENT! Main server notified & live GPS active.'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),
      ),
    );
  }

  void _cancelSosAlert() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Emergency SOS?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        content: const Text(
          'Are you sure you want to resolve and stop broadcasting your live GPS location to emergency responders?',
          style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Keep Active', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981), foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(ctx);
              _stopSosAlert();
            },
            child: const Text('Resolve & Stop SOS'),
          ),
        ],
      ),
    );
  }

  void _stopSosAlert() {
    _gpsBroadcastTimer?.cancel();
    _buddyMatchTimer?.cancel();

    setState(() {
      _isSosActive = false;
      _isSending = false;
      _buddySearching = false;
      _buddyAccepted = false;
      _assignedBuddy = null;
      _activeIncident?.status = 'resolved';
      _activeIncident?.liveTrackingActive = false;
      _lastGpsUpdateFormatted = 'Ended';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('SOS Emergency Session resolved. Location broadcasting stopped.'),
        backgroundColor: Color(0xFF10B981),
      ),
    );
  }

  void _startGpsBroadcasting() {
    _gpsBroadcastTimer?.cancel();
    _broadcastCount = 0;

    _gpsBroadcastTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted || !_isSosActive) return;

      final rand = Random();
      setState(() {
        _currentLat += (rand.nextDouble() - 0.5) * 0.0001;
        _currentLng += (rand.nextDouble() - 0.5) * 0.0001;
        _broadcastCount++;

        final now = DateTime.now();
        _lastGpsUpdateFormatted = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')} (Just now)';

        _activeIncident?.latitude = _currentLat;
        _activeIncident?.longitude = _currentLng;
        _activeIncident?.lastLocationUpdateAt = now.toIso8601String();

        if (_buddyAccepted && _buddyDistanceKm > 0.1) {
          _buddyDistanceKm = max(0.1, _buddyDistanceKm - 0.08);
          _buddyEtaMins = max(1, (_buddyDistanceKm * 3).round());
        }
      });
    });
  }

  void _toggleBuddyAssistance(bool enabled) {
    setState(() {
      _buddyAssistanceRequested = enabled;
      _activeIncident?.buddyAssistanceEnabled = enabled;
    });

    if (enabled && _isSosActive && !_buddyAccepted) {
      _initiateNearbyBuddyMatch();
    } else if (!enabled) {
      _buddyMatchTimer?.cancel();
      setState(() {
        _buddySearching = false;
        _buddyAccepted = false;
        _assignedBuddy = null;
      });
    }
  }

  void _initiateNearbyBuddyMatch() {
    if (_buddyAccepted || _buddySearching) return;

    setState(() {
      _buddySearching = true;
    });

    _buddyMatchTimer?.cancel();
    _buddyMatchTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted || !_isSosActive || !_buddyAssistanceRequested) return;

      final nearestBuddy = VizagDataService.buddies.firstWhere(
        (b) => b.isSafeVerified,
        orElse: () => VizagDataService.buddies.first,
      );

      final reqId = 'REQ-${Random().nextInt(90000) + 10000}';
      final nowStr = DateTime.now().toIso8601String();

      BuddyAssistanceRequest(
        requestId: reqId,
        incidentId: _activeIncident?.incidentId ?? 'INC-001',
        buddyId: nearestBuddy.id,
        buddyName: nearestBuddy.name,
        buddyAvatar: nearestBuddy.avatar,
        status: 'accepted',
        createdAt: nowStr,
        respondedAt: nowStr,
        buddyDistanceKm: nearestBuddy.distanceKm,
        lastBuddyLocationUpdateAt: nowStr,
      );

      setState(() {
        _buddySearching = false;
        _buddyAccepted = true;
        _assignedBuddy = nearestBuddy;
        _buddyDistanceKm = nearestBuddy.distanceKm;
        _buddyEtaMins = max(2, (nearestBuddy.distanceKm * 3).round());
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('⚡ Local Buddy ${nearestBuddy.name} accepted your emergency request! On the way.'),
          backgroundColor: Colors.orange.shade800,
          duration: const Duration(seconds: 4),
        ),
      );
    });
  }

  Widget _buildBuddyAssistanceStatus() {
    const primaryColor = Color(0xFFFF8C00);
    const greenColor = Color(0xFF059669);

    if (_buddySearching) {
      return Row(
        children: const [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(color: primaryColor, strokeWidth: 2),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Finding verified Local Buddies near your GPS location...',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: primaryColor),
            ),
          ),
        ],
      );
    }

    if (_buddyAccepted && _assignedBuddy != null) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.orange.shade50.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange.shade200),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(_assignedBuddy!.avatar),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${_assignedBuddy!.name} (Accepted)',
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.verified, color: Color(0xFF10B981), size: 14),
                        ],
                      ),
                      Text(
                        '${_assignedBuddy!.specialty} • ${_assignedBuddy!.rating} ★',
                        style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                      ),
                      Text(
                        'Distance: ${_buddyDistanceKm.toStringAsFixed(1)} km away • ETA: ~$_buddyEtaMins mins',
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: primaryColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: greenColor, borderRadius: BorderRadius.circular(12)),
                  child: const Text('RESPONDING', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Calling ${_assignedBuddy!.name}... (+91 98490 11223)')),
                      );
                    },
                    icon: const Icon(Icons.phone, size: 14, color: primaryColor),
                    label: const Text('Call Buddy', style: TextStyle(fontSize: 11, color: primaryColor)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      side: const BorderSide(color: primaryColor),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Opening chat with ${_assignedBuddy!.name}...')),
                      );
                    },
                    icon: const Icon(Icons.chat_bubble_outline, size: 14, color: Color(0xFF0F2942)),
                    label: const Text('Message', style: TextStyle(fontSize: 11, color: Color(0xFF0F2942))),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      side: const BorderSide(color: Color(0xFF0F2942)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return const Text(
      'Tap toggle above to enable real-time local buddy emergency assistance.',
      style: TextStyle(fontSize: 11, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFFF8C00);
    const emergencyRed = Color(0xFFDC2626);
    const greenColor = Color(0xFF059669);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2942)),
          onPressed: () => widget.onNavigate?.call('back'),
        ),
        title: const Text(
          '24/7 Emergency SOS Command',
          style: TextStyle(color: emergencyRed, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 14),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _isSosActive ? emergencyRed.withValues(alpha: 0.1) : greenColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(
                  _isSosActive ? Icons.warning_amber_rounded : Icons.shield_rounded,
                  size: 14,
                  color: _isSosActive ? emergencyRed : greenColor,
                ),
                const SizedBox(width: 4),
                Text(
                  _isSosActive ? 'ALERT ACTIVE' : 'SYSTEM READY',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _isSosActive ? emergencyRed : greenColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "You're Not Alone 🛡️",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF0F2942)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              const Text(
                'Instant emergency server dispatch, live GPS broadcasting & optional nearby Local Buddy response in Vizag.',
                style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              // SOS Button
              Center(
                child: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    final scale = _isSosActive ? _pulseAnimation.value : 1.0;
                    return Transform.scale(
                      scale: scale,
                      child: GestureDetector(
                        onTap: _isSosActive ? _cancelSosAlert : _triggerSosAlert,
                        child: Container(
                          width: 210,
                          height: 210,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: _isSosActive
                                  ? [const Color(0xFF991B1B), emergencyRed]
                                  : [const Color(0xFFEF4444), emergencyRed],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: emergencyRed.withValues(alpha: _isSosActive ? 0.6 : 0.4),
                                blurRadius: _isSosActive ? 32 : 18,
                                spreadRadius: _isSosActive ? 10 : 4,
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 194,
                                height: 194,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: _isSosActive ? 0.4 : 0.2),
                                    width: 3,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (_isSending) ...[
                                    const SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3.5),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'SENDING...',
                                      style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                                    ),
                                  ] else if (_isSosActive) ...[
                                    const Icon(Icons.warning_rounded, color: Colors.white, size: 44),
                                    const SizedBox(height: 2),
                                    const Text(
                                      'SOS',
                                      style: TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.w900, letterSpacing: 2),
                                    ),
                                    const SizedBox(height: 2),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        'TAP TO CANCEL',
                                        style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1),
                                      ),
                                    ),
                                  ] else ...[
                                    const Icon(Icons.shield, color: Colors.white, size: 44),
                                    const SizedBox(height: 2),
                                    const Text(
                                      'SOS',
                                      style: TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.w900, letterSpacing: 2),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'TAP TO ALERT',
                                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              Text(
                _isSosActive
                    ? '🚨 EMERGENCY ALERT SENT • Live GPS location stream active'
                    : 'Tap large SOS button to instantly alert Main Emergency Server',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _isSosActive ? emergencyRed : const Color(0xFF64748B),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Emergency Status Panel
              if (_isSosActive) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: emergencyRed.withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: emergencyRed.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.rss_feed, color: emergencyRed, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Incident #${_activeIncident?.incidentId ?? "SOS-1001"}',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: greenColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.check_circle, size: 12, color: greenColor),
                                SizedBox(width: 4),
                                Text(
                                  'SERVER CONFIRMED',
                                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: greenColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          const Icon(Icons.cloud_done, color: greenColor, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Main Emergency Server', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                Text('User: ${VizagDataService.traveller.name} • Dispatched', style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                              ],
                            ),
                          ),
                          const Text('Delivered ✓', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: greenColor)),
                        ],
                      ),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const Icon(Icons.location_on, color: primaryColor, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Live GPS: ${_currentLat.toStringAsFixed(4)}° N, ${_currentLng.toStringAsFixed(4)}° E',
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Updated: $_lastGpsUpdateFormatted • Accuracy: ±${_gpsAccuracy}m',
                                  style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: primaryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                            child: Text(
                              'Pings: $_broadcastCount',
                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
              ],

              // Local Buddy Emergency Response Feature
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.people_alt_rounded, color: primaryColor, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Nearby Local Buddy Help',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
                            ),
                          ],
                        ),
                        Switch(
                          value: _buddyAssistanceRequested,
                          activeThumbColor: primaryColor,
                          onChanged: _toggleBuddyAssistance,
                        ),
                      ],
                    ),
                    const Text(
                      'Optionally dispatch certified local companions nearby in addition to main server SOS.',
                      style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                    ),

                    if (_buddyAssistanceRequested) ...[
                      const SizedBox(height: 14),
                      const Divider(height: 1),
                      const SizedBox(height: 14),
                      _buildBuddyAssistanceStatus(),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Live GPS Broadcasting Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: greenColor.withValues(alpha: 0.1),
                      child: const Icon(Icons.share_location_rounded, color: greenColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Live GPS Server Sync', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F2942))),
                          Text(
                            _isSosActive ? 'Broadcasting live to main server' : 'Ready to stream on emergency trigger',
                            style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _isSosActive ? greenColor.withValues(alpha: 0.1) : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _isSosActive ? 'ACTIVE' : 'READY',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _isSosActive ? greenColor : Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SharedBottomNav(activeTab: 'sos', onNavigate: widget.onNavigate),
    );
  }
}
