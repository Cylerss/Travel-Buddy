import 'package:flutter/material.dart';
import '../services/vizag_data.dart';
import '../widgets/bottom_nav.dart';

class Screen16ProfileDashboard extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen16ProfileDashboard({super.key, this.onNavigate});

  @override
  State<Screen16ProfileDashboard> createState() => _Screen16ProfileDashboardState();
}

class _Screen16ProfileDashboardState extends State<Screen16ProfileDashboard> {
  String _selectedBookingTab = 'active'; // 'active' or 'past'

  final List<Map<String, dynamic>> _activeBookings = [
    {
      'id': 'TB-98214',
      'title': 'Araku Valley & Borra Caves Expedition',
      'category': 'Nature & Trekking 🌲',
      'buddyName': 'Rajesh Varma',
      'buddyRole': 'Certified Local Guide & Trekker',
      'buddyRating': '4.98',
      'buddyTrips': 142,
      'buddyAvatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&fm=webp&fit=crop&q=60',
      'buddyPhone': '+91 98480 12345',
      'date': 'Tomorrow, 13 Oct 2026',
      'time': '07:30 AM',
      'status': 'Confirmed',
      'statusColor': const Color(0xFF10B981),
      'statusBg': const Color(0xFFECFDF5),
      'pickup': 'Vizag Central Railway Station, Gate 1',
      'destination': 'Borra Caves & Katiki Waterfalls, Araku',
      'duration': 'Full Day (8 Hours)',
      'otp': '4918',
      'price': '₹1,850',
      'package': 'Custom Araku Valley Tour + Tribal Coffee Tasting',
      'priceBreakdown': [
        {'item': 'Buddy & Guide Service (8 Hrs)', 'amount': '₹1,200'},
        {'item': 'Transit & Hill Route Assist', 'amount': '₹500'},
        {'item': 'Trip Insurance & Safety Gear', 'amount': '₹100'},
        {'item': 'Platform Service Fee', 'amount': '₹50'},
      ],
      'notes': 'Wear comfortable trekking shoes. Packed water bottles & first-aid kit provided.',
      'type': 'active',
    },
    {
      'id': 'TB-77402',
      'title': 'Kailasagiri Sunset Ropeway & Coastal Walk',
      'category': 'Scenic & Heritage 🌅',
      'buddyName': 'Ananya Rao',
      'buddyRole': 'Cultural Historian & Photographer',
      'buddyRating': '4.95',
      'buddyTrips': 118,
      'buddyAvatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&fm=webp&fit=crop&q=60',
      'buddyPhone': '+91 94401 67890',
      'date': 'Today, 12 Oct 2026',
      'time': '04:30 PM',
      'status': 'In Progress',
      'statusColor': const Color(0xFFFF8C00),
      'statusBg': const Color(0xFFFFF7ED),
      'pickup': 'Kailasagiri Foot Hill Ropeway Station',
      'destination': 'Kailasagiri Hill Top & Tenneti Park',
      'duration': '3.5 Hours',
      'otp': '6204',
      'price': '₹750',
      'package': 'Golden Hour Photography & History Walk',
      'priceBreakdown': [
        {'item': 'Local Host & Photo Guide', 'amount': '₹550'},
        {'item': 'Ropeway Fast-Track Pass Assist', 'amount': '₹150'},
        {'item': 'Platform Service Fee', 'amount': '₹50'},
      ],
      'notes': 'Camera gear welcome. Sunset golden hour estimated at 5:48 PM.',
      'type': 'active',
    },
  ];

  final List<Map<String, dynamic>> _pastBookings = [
    {
      'id': 'TB-62189',
      'title': 'INS Kursura Submarine & Naval Heritage Walk',
      'category': 'Heritage & Defense ⚓',
      'buddyName': 'Karthik Naidu',
      'buddyRole': 'Naval Heritage Guide & Historian',
      'buddyRating': '4.91',
      'buddyTrips': 96,
      'buddyAvatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&fm=webp&fit=crop&q=60',
      'buddyPhone': '+91 98852 34567',
      'date': '08 Oct 2026',
      'time': '10:00 AM',
      'status': 'Completed',
      'statusColor': const Color(0xFF64748B),
      'statusBg': const Color(0xFFF1F5F9),
      'userRating': 5,
      'userReview': 'Karthik was incredible! Knew every detail of INS Kursura and TU-142 museum.',
      'pickup': 'RK Beach Submarine Entry Gate',
      'destination': 'RK Beach Coastal Promenade & TU-142 Museum',
      'duration': '2.5 Hours',
      'price': '₹450',
      'package': 'Naval Defense & Maritime History Walk',
      'priceBreakdown': [
        {'item': 'Certified Naval Heritage Guide', 'amount': '₹350'},
        {'item': 'Museum Entry Facilitation', 'amount': '₹70'},
        {'item': 'Platform Service Fee', 'amount': '₹30'},
      ],
      'type': 'past',
    },
    {
      'id': 'TB-58901',
      'title': 'Vizag Seafood & Coastal Culinary Trail',
      'category': 'Food & Culinary 🦐',
      'buddyName': 'Priya Sharma',
      'buddyRole': 'Local Food Historian & Host',
      'buddyRating': '4.89',
      'buddyTrips': 84,
      'buddyAvatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&fm=webp&fit=crop&q=60',
      'buddyPhone': '+91 97003 45678',
      'date': '04 Oct 2026',
      'time': '01:00 PM',
      'status': 'Completed',
      'statusColor': const Color(0xFF64748B),
      'statusBg': const Color(0xFFF1F5F9),
      'userRating': 5,
      'userReview': 'Tasted authentic Royyala Iguru and bamboo chicken at hidden local gems. 10/10!',
      'pickup': 'Siripuram Circle Landmark',
      'destination': 'Daba Gardens & Lawson\'s Bay Coastal Kitchens',
      'duration': '3 Hours',
      'price': '₹950',
      'package': 'Traditional Andhra Seafood Feast & Tasting',
      'priceBreakdown': [
        {'item': 'Culinary Guide & Food Tastings', 'amount': '₹750'},
        {'item': 'Specialty Spice Kitchen Pass', 'amount': '₹150'},
        {'item': 'Platform Fee', 'amount': '₹50'},
      ],
      'type': 'past',
    },
    {
      'id': 'TB-41203',
      'title': 'Rushikonda Beach Surf & Watersports Session',
      'category': 'Adventure & Sports 🏄‍♂️',
      'buddyName': 'Suresh Kumar',
      'buddyRole': 'Surf Instructor & Coastal Adventurer',
      'buddyRating': '4.85',
      'buddyTrips': 72,
      'buddyAvatar': 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=150&fm=webp&fit=crop&q=60',
      'buddyPhone': '+91 99590 87654',
      'date': '28 Sep 2026',
      'time': '06:30 AM',
      'status': 'Completed',
      'statusColor': const Color(0xFF64748B),
      'statusBg': const Color(0xFFF1F5F9),
      'userRating': 5,
      'userReview': 'Super patient and certified instructor. Caught my very first wave safely!',
      'pickup': 'Rushikonda Beach Shack #4',
      'destination': 'Rushikonda Surf Point & Water Zone',
      'duration': '2.5 Hours',
      'price': '₹1,100',
      'package': 'Beginner Surf Coaching + Board Rental',
      'priceBreakdown': [
        {'item': '1-on-1 Surf Coaching', 'amount': '₹800'},
        {'item': 'Surfboard & Life Vest Rental', 'amount': '₹250'},
        {'item': 'Platform Fee', 'amount': '₹50'},
      ],
      'type': 'past',
    },
    {
      'id': 'TB-30812',
      'title': 'Yarada Beach Sunrise Trek & Lighthouse View',
      'category': 'Nature & Trekking ⛰️',
      'buddyName': 'Rajesh Varma',
      'buddyRole': 'Certified Local Guide & Trekker',
      'buddyRating': '4.98',
      'buddyTrips': 142,
      'buddyAvatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&fm=webp&fit=crop&q=60',
      'buddyPhone': '+91 98480 12345',
      'date': '20 Sep 2026',
      'time': '05:30 AM',
      'status': 'Completed',
      'statusColor': const Color(0xFF64748B),
      'statusBg': const Color(0xFFF1F5F9),
      'userRating': 5,
      'userReview': 'Best sunrise view in all of Andhra Pradesh! Rajesh took incredible photos for me.',
      'pickup': 'Dolphin\'s Nose Base Hill',
      'destination': 'Yarada Golden Sand Beach & Lighthouse Ridge',
      'duration': '4 Hours',
      'price': '₹800',
      'package': 'Early Morning Hill Trek & Beach Picnic',
      'priceBreakdown': [
        {'item': 'Trek Guidance & Route Navigation', 'amount': '₹600'},
        {'item': 'Light Refreshments & Photography', 'amount': '₹150'},
        {'item': 'Platform Fee', 'amount': '₹50'},
      ],
      'type': 'past',
    },
  ];

  void _openEditProfileModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EditProfileBottomSheet(
        onSaved: () {
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully! 🎉'),
              backgroundColor: Color(0xFF10B981),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final traveller = VizagDataService.traveller;
    const primaryColor = Color(0xFFFF8C00);

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
          'Profile & Preferences',
          style: TextStyle(color: Color(0xFF0F2942), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: primaryColor),
            tooltip: 'Edit Profile',
            onPressed: _openEditProfileModal,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Profile Header Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 34,
                              backgroundColor: Colors.orange.shade100,
                              backgroundImage: traveller.avatar.isNotEmpty ? NetworkImage(traveller.avatar) : null,
                              child: traveller.avatar.isEmpty
                                  ? const Icon(Icons.person, size: 36, color: primaryColor)
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.verified, color: Color(0xFF10B981), size: 18),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      traveller.name,
                                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.shield, color: Color(0xFF10B981), size: 16),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                traveller.email,
                                style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${traveller.nationality} • ${traveller.phone}',
                                style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),

                              // Passport Status Badge (Sensitive details masked)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: traveller.hasPassportAdded
                                      ? const Color(0xFF10B981).withValues(alpha: 0.1)
                                      : Colors.amber.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      traveller.hasPassportAdded ? Icons.check_circle : Icons.info_outline,
                                      size: 12,
                                      color: traveller.hasPassportAdded ? const Color(0xFF059669) : Colors.amber.shade900,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      traveller.hasPassportAdded
                                          ? 'Passport Status: Added ✓'
                                          : 'Passport Status: Not added',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: traveller.hasPassportAdded ? const Color(0xFF059669) : Colors.amber.shade900,
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
                    const SizedBox(height: 14),

                    // Travel Preferences Chips
                    if (traveller.hobbies.isNotEmpty) ...[
                      const Text(
                        'TRAVEL INTERESTS',
                        style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8), letterSpacing: 0.5),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: traveller.hobbies.map((pref) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.orange.shade200),
                            ),
                            child: Text(
                              pref,
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.orange.shade900),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 14),
                    ],

                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    const SizedBox(height: 12),

                    // Edit Profile Button
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _openEditProfileModal,
                            icon: const Icon(Icons.edit_note_rounded, size: 18),
                            label: const Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatCol('${traveller.tripsCount}', 'Trips Done'),
                        _buildStatCol('${traveller.safetyScore}%', 'Safety Score'),
                        _buildStatCol('1,450', 'Vizag Coins'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Active & Past Bookings Section (Replaces Safety & Emergency)
              _buildBookingsSection(primaryColor),

              const SizedBox(height: 18),

              // Account Options List
              const Text(
                'Account & Preferences',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
              ),
              const SizedBox(height: 10),

              _buildOptionTile(
                icon: Icons.card_membership_rounded,
                title: 'Passport Verification Status',
                subtitle: traveller.hasPassportAdded ? 'Passport Added & Secured' : 'Tap to add passport details',
                trailing: traveller.hasPassportAdded ? 'Verified' : 'Add',
                trailingColor: traveller.hasPassportAdded ? const Color(0xFF10B981) : primaryColor,
                onTap: () => widget.onNavigate?.call('05-passport-verification'),
              ),
              _buildOptionTile(
                icon: Icons.star_outline_rounded,
                title: 'Gamification & Rewards',
                subtitle: 'Level 4 • 1,450 Vizag Coins',
                trailing: 'View',
                trailingColor: primaryColor,
                onTap: () => widget.onNavigate?.call('15-gamification'),
              ),
              _buildOptionTile(
                icon: Icons.leaderboard_rounded,
                title: 'Buddy Leaderboard & Ratings',
                subtitle: 'View top certified local guides',
                trailing: 'Explore',
                trailingColor: primaryColor,
                onTap: () => widget.onNavigate?.call('20-buddy-leaderboard'),
              ),
              _buildOptionTile(
                icon: Icons.my_location_rounded,
                title: 'Live Tracking & Geo Fence',
                subtitle: 'Active monitoring on Beach Road',
                trailing: 'Active',
                trailingColor: const Color(0xFF10B981),
                onTap: () => widget.onNavigate?.call('12-live-tracking'),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SharedBottomNav(activeTab: 'profile', onNavigate: widget.onNavigate),
    );
  }

  Widget _buildStatCol(String val, String label) {
    return Column(
      children: [
        Text(val, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F2942))),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
      ],
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String trailing,
    required Color trailingColor,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFFFF7ED),
          child: Icon(icon, color: const Color(0xFFFF8C00), size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: trailingColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            trailing,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: trailingColor),
          ),
        ),
      ),
    );
  }

  // --- BOOKINGS SECTION (ACTIVE & PAST BOOKINGS) ---

  Widget _buildBookingsSection(Color primaryColor) {
    final isShowingActive = _selectedBookingTab == 'active';
    final currentList = isShowingActive ? _activeBookings : _pastBookings;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.bookmark_added_rounded, color: Color(0xFFFF8C00), size: 18),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buddy Bookings',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Manage upcoming trips & past receipts',
                      style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_activeBookings.length} Active • ${_pastBookings.length} Past',
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Segmented Tabs: Active Bookings vs Past Bookings
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedBookingTab = 'active';
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                      decoration: BoxDecoration(
                        color: isShowingActive ? const Color(0xFFFF8C00) : Colors.transparent,
                        borderRadius: BorderRadius.circular(11),
                        boxShadow: isShowingActive
                            ? [
                                BoxShadow(
                                  color: const Color(0xFFFF8C00).withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bolt_rounded,
                              size: 15,
                              color: isShowingActive ? Colors.white : const Color(0xFF64748B),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Active (${_activeBookings.length})',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isShowingActive ? Colors.white : const Color(0xFF64748B),
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedBookingTab = 'past';
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                      decoration: BoxDecoration(
                        color: !isShowingActive ? const Color(0xFFFF8C00) : Colors.transparent,
                        borderRadius: BorderRadius.circular(11),
                        boxShadow: !isShowingActive
                            ? [
                                BoxShadow(
                                  color: const Color(0xFFFF8C00).withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history_rounded,
                              size: 15,
                              color: !isShowingActive ? Colors.white : const Color(0xFF64748B),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Past (${_pastBookings.length})',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: !isShowingActive ? Colors.white : const Color(0xFF64748B),
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Booking List Cards
          Column(
            children: currentList.map((booking) {
              return _buildBookingItemCard(booking);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingItemCard(Map<String, dynamic> booking) {
    final isActive = booking['type'] == 'active';
    final Color statusColor = booking['statusColor'] as Color;
    final Color statusBg = booking['statusBg'] as Color;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showBookingDetailsBottomSheet(booking),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Tag & Status Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Text(
                          booking['category'] as String,
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 3,
                            backgroundColor: statusColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            booking['status'] as String,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Title
                Text(
                  booking['title'] as String,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F2942),
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 8),

                // Buddy Info Row
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(booking['buddyAvatar'] as String),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '${booking['buddyName']} • ★ ${booking['buddyRating']}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF475569),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      booking['price'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFFF8C00),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Date & Time + Tap hint row
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.access_time_rounded, size: 12, color: Color(0xFF94A3B8)),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${booking['date']} • ${booking['time']}',
                              style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isActive ? 'View Details' : 'View Details',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF8C00),
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 9, color: Color(0xFFFF8C00)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBookingDetailsBottomSheet(Map<String, dynamic> booking) {
    final isActive = booking['type'] == 'active';
    final Color statusColor = booking['statusColor'] as Color;
    final Color statusBg = booking['statusBg'] as Color;
    final List<Map<String, String>> priceItems = List<Map<String, String>>.from(booking['priceBreakdown'] as List);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(ctx).size.height * 0.88,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Drag Handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 6),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Sheet Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(radius: 3.5, backgroundColor: statusColor),
                          const SizedBox(width: 5),
                          Text(
                            booking['status'] as String,
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: statusColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Booking #${booking['id']}',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF64748B)),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

              // Scrollable Booking Body
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title & Category
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7ED),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          booking['category'] as String,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFFF8C00)),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        booking['title'] as String,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF0F2942)),
                      ),
                      const SizedBox(height: 14),

                      // Start OTP Banner (for active bookings)
                      if (isActive && booking['otp'] != null) ...[
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFF7ED), Color(0xFFFFEDD5)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFFED7AA)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF8C00),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.pin_rounded, color: Colors.white, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Trip Verification OTP',
                                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF9A3412)),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'START OTP: ${booking['otp']}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1.5,
                                        color: Color(0xFFC2410C),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    const Text(
                                      'Share this 4-digit code with your Buddy at meeting point to verify & start experience.',
                                      style: TextStyle(fontSize: 10, color: Color(0xFF7C2D12)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],

                      // Assigned Buddy Card
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Assigned Local Buddy',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(booking['buddyAvatar'] as String),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            booking['buddyName'] as String,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF0F2942),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          const Icon(Icons.verified_rounded, size: 14, color: Color(0xFF10B981)),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        booking['buddyRole'] as String,
                                        style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          const Icon(Icons.star_rounded, size: 13, color: Color(0xFFF59E0B)),
                                          const SizedBox(width: 2),
                                          Text(
                                            '${booking['buddyRating']} ★ • ${booking['buddyTrips']} Trips Completed',
                                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Quick Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      ScaffoldMessenger.of(ctx).showSnackBar(
                                        SnackBar(
                                          content: Text('📞 Calling ${booking['buddyName']} (${booking['buddyPhone']})...'),
                                          backgroundColor: const Color(0xFF0F2942),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.phone_rounded, size: 14, color: Color(0xFFFF8C00)),
                                    label: const Text('Call', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFFF8C00))),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: Color(0xFFFF8C00)),
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      ScaffoldMessenger.of(ctx).showSnackBar(
                                        SnackBar(
                                          content: Text('💬 Live Chat connected with ${booking['buddyName']}!'),
                                          backgroundColor: const Color(0xFF10B981),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.chat_bubble_rounded, size: 14, color: Color(0xFF10B981)),
                                    label: const Text('Chat', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF10B981))),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: Color(0xFF10B981)),
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                      widget.onNavigate?.call('11-buddy-profile');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF0F2942),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                    child: const Text('Profile', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Schedule & Itinerary
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Trip Schedule & Locations',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today_rounded, size: 14, color: Color(0xFFFF8C00)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '${booking['date']} at ${booking['time']}',
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF7ED),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    booking['duration'] as String,
                                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFFFF8C00)),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 18, color: Color(0xFFE2E8F0)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.trip_origin_rounded, size: 14, color: Color(0xFF10B981)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Meeting & Pickup Spot', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                                      const SizedBox(height: 2),
                                      Text(
                                        booking['pickup'] as String,
                                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.location_on_rounded, size: 14, color: Color(0xFFDC2626)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Destination', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                                      const SizedBox(height: 2),
                                      Text(
                                        booking['destination'] as String,
                                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Package Included & Notes
                      if (booking['package'] != null || booking['notes'] != null) ...[
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Package Highlights & Notes',
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                              ),
                              const SizedBox(height: 8),
                              if (booking['package'] != null)
                                Row(
                                  children: [
                                    const Icon(Icons.check_circle_rounded, size: 14, color: Color(0xFF10B981)),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        booking['package'] as String,
                                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0F2942)),
                                      ),
                                    ),
                                  ],
                                ),
                              if (booking['notes'] != null) ...[
                                const SizedBox(height: 6),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.info_outline_rounded, size: 14, color: Color(0xFF64748B)),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        booking['notes'] as String,
                                        style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],

                      // Traveller Feedback for Past Bookings
                      if (!isActive && booking['userRating'] != null) ...[
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFFDE68A)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: List.generate(
                                      booking['userRating'] as int,
                                      (i) => const Icon(Icons.star_rounded, size: 16, color: Color(0xFFD97706)),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    'Your Verified Review',
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF92400E)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '"${booking['userReview']}"',
                                style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Color(0xFF78350F)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],

                      // Price Breakdown
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Fare & Payment Breakdown',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                            ),
                            const SizedBox(height: 8),
                            ...priceItems.map((item) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(item['item']!, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                                    Text(item['amount']!, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF0F2942))),
                                  ],
                                ),
                              );
                            }),
                            const Divider(height: 14, color: Color(0xFFE2E8F0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Total Amount Paid', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F2942))),
                                    Text('Paid via UPI • GPay (Txn Verified)', style: TextStyle(fontSize: 9, color: Color(0xFF10B981), fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Text(
                                  booking['price'] as String,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFFFF8C00)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Primary Action Buttons
                      if (isActive) ...[
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(ctx);
                              widget.onNavigate?.call('12-live-tracking');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF8C00),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            icon: const Icon(Icons.navigation_rounded, size: 18),
                            label: const Text('Live Track Buddy on Map', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: OutlinedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(ctx).showSnackBar(
                                const SnackBar(
                                  content: Text('Support request sent for booking. Our concierge will call you shortly! 💬'),
                                  backgroundColor: Color(0xFF0F2942),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Cancel or Reschedule Trip', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold, fontSize: 13)),
                          ),
                        ),
                      ] else ...[
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(ctx);
                              widget.onNavigate?.call('18-buddy-details');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF8C00),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            icon: const Icon(Icons.replay_rounded, size: 18),
                            label: Text('Book Again with ${booking['buddyName']}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(ctx).showSnackBar(
                                SnackBar(
                                  content: Text('📄 Tax Invoice for #${booking['id']} downloaded to device!'),
                                  backgroundColor: const Color(0xFF10B981),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            icon: const Icon(Icons.download_rounded, size: 16, color: Color(0xFF0F2942)),
                            label: const Text('Download Tax Invoice (PDF)', style: TextStyle(color: Color(0xFF0F2942), fontWeight: FontWeight.bold, fontSize: 13)),
                          ),
                        ),
                      ],

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EditProfileBottomSheet extends StatefulWidget {
  final VoidCallback onSaved;

  const _EditProfileBottomSheet({required this.onSaved});

  @override
  State<_EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<_EditProfileBottomSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _nationalityController;
  late final TextEditingController _dobController;
  late final TextEditingController _avatarController;

  late final TextEditingController _passportNumberController;
  late final TextEditingController _passportCountryController;
  late final TextEditingController _passportIssueDateController;
  late final TextEditingController _passportExpiryController;

  late List<String> _selectedHobbies;
  bool _isSaving = false;
  String? _errorText;

  final List<String> _availableHobbies = [
    'Dancing 💃',
    'Beach Walks 🏖️',
    'Coastal Food 🍤',
    'Photography 📸',
    'Heritage Tours 🏛️',
    'Water Sports 🏄‍♀️',
    'Yoga & Sunsets 🧘',
    'Live Music 🎵',
  ];

  @override
  void initState() {
    super.initState();
    final traveller = VizagDataService.traveller;
    _nameController = TextEditingController(text: traveller.name);
    _emailController = TextEditingController(text: traveller.email);
    _phoneController = TextEditingController(text: traveller.phone);
    _nationalityController = TextEditingController(text: traveller.nationality);
    _dobController = TextEditingController(text: traveller.dob);
    _avatarController = TextEditingController(text: traveller.avatar);

    _passportNumberController = TextEditingController(text: traveller.passportNumber);
    _passportCountryController = TextEditingController(text: traveller.passportIssuingCountry);
    _passportIssueDateController = TextEditingController(text: traveller.passportIssueDate);
    _passportExpiryController = TextEditingController(text: traveller.passportExpiry);

    _selectedHobbies = List.from(traveller.hobbies);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nationalityController.dispose();
    _dobController.dispose();
    _avatarController.dispose();
    _passportNumberController.dispose();
    _passportCountryController.dispose();
    _passportIssueDateController.dispose();
    _passportExpiryController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty) {
      setState(() => _errorText = 'Full Name is required.');
      return;
    }
    if (email.isEmpty || !email.contains('@')) {
      setState(() => _errorText = 'Valid Email Address is required.');
      return;
    }

    setState(() {
      _isSaving = true;
      _errorText = null;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    final traveller = VizagDataService.traveller;
    traveller.name = name;
    traveller.email = email;
    traveller.phone = _phoneController.text.trim();
    traveller.nationality = _nationalityController.text.trim();
    traveller.country = _nationalityController.text.trim();
    traveller.dob = _dobController.text.trim();
    if (_avatarController.text.trim().isNotEmpty) {
      traveller.avatar = _avatarController.text.trim();
    }
    traveller.hobbies = List.from(_selectedHobbies);
    traveller.travelPreferences = List.from(_selectedHobbies);

    // Passport details update
    final pNum = _passportNumberController.text.trim();
    if (pNum.isNotEmpty) {
      traveller.passportNumber = pNum;
      traveller.hasPassportAdded = true;
      traveller.passportVerified = true;
    }
    traveller.passportIssuingCountry = _passportCountryController.text.trim();
    traveller.passportIssueDate = _passportIssueDateController.text.trim();
    traveller.passportExpiry = _passportExpiryController.text.trim();

    if (!mounted) return;
    Navigator.pop(context);
    widget.onSaved();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFFF8C00);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
        left: 20,
        right: 20,
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Column(
          children: [
            // Top Handle Bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Edit Profile & Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(height: 1),
            const SizedBox(height: 12),

            if (_errorText != null) ...[
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorText!,
                        style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Personal Information
                    const Text('PERSONAL DETAILS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: primaryColor, letterSpacing: 0.5)),
                    const SizedBox(height: 8),

                    _buildField('Full Name *', _nameController, Icons.person_outline),
                    const SizedBox(height: 12),
                    _buildField('Email Address *', _emailController, Icons.email_outlined),
                    const SizedBox(height: 12),
                    _buildField('Phone Number', _phoneController, Icons.phone_outlined),
                    const SizedBox(height: 12),
                    _buildField('Nationality / Country', _nationalityController, Icons.language_outlined),
                    const SizedBox(height: 12),
                    _buildField('Date of Birth', _dobController, Icons.cake_outlined),
                    const SizedBox(height: 12),
                    _buildField('Profile Photo Image URL', _avatarController, Icons.image_outlined),

                    const SizedBox(height: 18),
                    const Text('TRAVEL PREFERENCES', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: primaryColor, letterSpacing: 0.5)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availableHobbies.map((hobby) {
                        final isSelected = _selectedHobbies.contains(hobby);
                        return FilterChip(
                          label: Text(hobby, style: TextStyle(fontSize: 11, color: isSelected ? Colors.white : Colors.black87)),
                          selected: isSelected,
                          selectedColor: primaryColor,
                          checkmarkColor: Colors.white,
                          onSelected: (val) {
                            setState(() {
                              if (val) {
                                _selectedHobbies.add(hobby);
                              } else {
                                _selectedHobbies.remove(hobby);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),
                    // Passport Details Section (Optional)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.badge_outlined, color: primaryColor, size: 18),
                              SizedBox(width: 8),
                              Text('PASSPORT DETAILS (OPTIONAL)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F2942))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _buildField('Passport Number', _passportNumberController, Icons.numbers),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(child: _buildField('Issuing Country', _passportCountryController, Icons.flag_outlined)),
                              const SizedBox(width: 10),
                              Expanded(child: _buildField('Issue Date', _passportIssueDateController, Icons.calendar_today_outlined)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _buildField('Expiry Date', _passportExpiryController, Icons.event_outlined),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Save and Cancel Action Row
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Cancel', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text('Save Changes', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 18, color: const Color(0xFFFF8C00)),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade200)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
      style: const TextStyle(fontSize: 13),
    );
  }
}
