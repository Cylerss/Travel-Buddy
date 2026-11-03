import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class Screen11BuddyProfile extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen11BuddyProfile({super.key, this.onNavigate});

  @override
  State<Screen11BuddyProfile> createState() => _Screen11BuddyProfileState();
}

class _Screen11BuddyProfileState extends State<Screen11BuddyProfile> {
  int _selectedPackageIndex = 0; // 0: Hourly (₹350/hr), 1: Half Day (₹1,200), 2: Full Day (₹2,200)
  int _selectedDateIndex = 0; // 0: Today, 1: Tomorrow, 2: Day After
  int _selectedSlotIndex = 0; // 0: Morning, 1: Afternoon, 2: Evening

  final List<Map<String, String>> _packages = [
    {'title': 'Hourly Guide', 'rate': '₹350/hr', 'sub': 'Pay per hour spent'},
    {'title': 'Half-Day Tour', 'rate': '₹1,200', 'sub': '4 Hours Beach & Food'},
    {'title': 'Full-Day Tour', 'rate': '₹2,200', 'sub': '8 Hours Vizag Explorer'},
  ];

  final List<Map<String, String>> _dates = [
    {'day': 'Today', 'date': 'Oct 10'},
    {'day': 'Tomorrow', 'date': 'Oct 11'},
    {'day': 'Sun', 'date': 'Oct 12'},
  ];

  final List<Map<String, String>> _timeSlots = [
    {'slot': 'Morning', 'time': '09:00 AM - 01:00 PM', 'icon': '🌅'},
    {'slot': 'Afternoon', 'time': '02:00 PM - 06:00 PM', 'icon': '☀️'},
    {'slot': 'Evening Jam', 'time': '06:00 PM - 09:30 PM', 'icon': '🌙'},
  ];

  void _showBookingConfirmationModal() {
    final pkg = _packages[_selectedPackageIndex];
    final date = _dates[_selectedDateIndex];
    final slot = _timeSlots[_selectedSlotIndex];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const SizedBox(height: 16),

              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 28),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Confirm Buddy Booking',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
                        ),
                        Text(
                          'Review your selected package & schedule',
                          style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Booking Details Summary Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('Buddy', 'Priya Sharma ✓'),
                    const Divider(height: 16),
                    _buildSummaryRow('Selected Charge', '${pkg['title']} (${pkg['rate']})'),
                    const Divider(height: 16),
                    _buildSummaryRow('Date', '${date['day']}, ${date['date']}'),
                    const Divider(height: 16),
                    _buildSummaryRow('Time Slot', '${slot['slot']} (${slot['time']})'),
                    const Divider(height: 16),
                    _buildSummaryRow('Payment Option', 'Pay directly to buddy (Cash/UPI)'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Cancel', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('🎉 Booking Confirmed! Connecting with Priya...'),
                            backgroundColor: Color(0xFF10B981),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        widget.onNavigate?.call('12-live-tracking');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF8C00),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Confirm & Start Trip', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(String label, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
        Flexible(
          child: Text(
            val,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedPkg = _packages[_selectedPackageIndex];

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
          'Buddy Profile & Booking',
          style: TextStyle(color: Color(0xFF0F2942), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Color(0xFFFF8C00)),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. BUDDY PROFILE SECTION
              SizedBox(
                height: 220,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=500&fm=webp&fit=crop&q=60',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.75),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 14,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Priya Sharma ✓',
                                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Licensed Vizag Guide & Classical Dancer',
                                style: TextStyle(color: Colors.white70, fontSize: 12),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text(
                              '5.0 ★ (142)',
                              style: TextStyle(color: Color(0xFF0F2942), fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Match Score Banner
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7ED),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Row(
                        children: const [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: Color(0xFFFF8C00),
                            child: Text('98%', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Matched on Dancing & Coastal Walks', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F2942))),
                                Text('Shares your passion for beach dance & coastal walks', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Verification Badges Row
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Column(
                              children: const [
                                Icon(Icons.shield_outlined, color: Color(0xFFFF8C00), size: 20),
                                SizedBox(height: 4),
                                Text('Govt. Verified', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF0F2942))),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Column(
                              children: const [
                                Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                                SizedBox(height: 4),
                                Text('5.0 Star Rated', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF0F2942))),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Column(
                              children: const [
                                Icon(Icons.health_and_safety_outlined, color: Color(0xFF10B981), size: 20),
                                SizedBox(height: 4),
                                Text('CPR Certified', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF0F2942))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Bio Text & Interest Tags
                    const Text(
                      'Licensed Vizag guide & Kuchipudi classical dancer. Fluent in English, Telugu, and Hindi.',
                      style: TextStyle(fontSize: 13, color: Color(0xFF475569), height: 1.4),
                    ),
                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: const [
                        Chip(label: Text('Dancing 💃', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)), backgroundColor: Color(0xFFFF8C00)),
                        Chip(label: Text('Coastal Food', style: TextStyle(fontSize: 11)), backgroundColor: Color(0xFFF1F5F9)),
                        Chip(label: Text('English', style: TextStyle(fontSize: 11)), backgroundColor: Color(0xFFF1F5F9)),
                        Chip(label: Text('Telugu', style: TextStyle(fontSize: 11)), backgroundColor: Color(0xFFF1F5F9)),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    const SizedBox(height: 18),

                    // 2. CHARGES SECTION
                    const Text(
                      'CHARGES & PACKAGES',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFFF8C00), letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: List.generate(_packages.length, (idx) {
                        final pkg = _packages[idx];
                        final isSelected = _selectedPackageIndex == idx;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedPackageIndex = idx),
                            child: Container(
                              margin: EdgeInsets.only(right: idx == _packages.length - 1 ? 0 : 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFFFFF7ED) : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected ? const Color(0xFFFF8C00) : const Color(0xFFE2E8F0),
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pkg['title']!,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                      color: isSelected ? const Color(0xFFFF8C00) : const Color(0xFF0F2942),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    pkg['rate']!,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF0F2942)),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    pkg['sub']!,
                                    style: const TextStyle(fontSize: 9, color: Color(0xFF64748B)),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),

                    // 3. AVAILABILITY & SCHEDULING SECTION
                    const Text(
                      'AVAILABILITY & SCHEDULE',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFFF8C00), letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 10),

                    // Dates
                    Row(
                      children: List.generate(_dates.length, (idx) {
                        final d = _dates[idx];
                        final isSelected = _selectedDateIndex == idx;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedDateIndex = idx),
                            child: Container(
                              margin: EdgeInsets.only(right: idx == _dates.length - 1 ? 0 : 8),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFF0F2942) : Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected ? const Color(0xFF0F2942) : const Color(0xFFE2E8F0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    d['day']!,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? Colors.white70 : const Color(0xFF64748B),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    d['date']!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : const Color(0xFF0F2942),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 12),

                    // Time Slots
                    Column(
                      children: List.generate(_timeSlots.length, (idx) {
                        final slot = _timeSlots[idx];
                        final isSelected = _selectedSlotIndex == idx;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedSlotIndex = idx),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFFFF7ED) : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected ? const Color(0xFFFF8C00) : const Color(0xFFE2E8F0),
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(slot['icon']!, style: const TextStyle(fontSize: 18)),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        slot['slot']!,
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
                                      ),
                                      Text(
                                        slot['time']!,
                                        style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                  color: isSelected ? const Color(0xFFFF8C00) : const Color(0xFF94A3B8),
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),

                    // 4. BOOKING SUMMARY & PRIMARY ACTION BUTTON
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Rate & Package', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                                  Text(
                                    selectedPkg['rate']!,
                                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF0F2942)),
                                  ),
                                ],
                              ),
                              OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.chat_bubble_outline, size: 16, color: Color(0xFF0F2942)),
                                label: const Text('Chat First', style: TextStyle(color: Color(0xFF0F2942), fontWeight: FontWeight.bold, fontSize: 12)),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _showBookingConfirmationModal,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF8C00),
                                foregroundColor: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.navigation_rounded, size: 18),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Start Safe Buddy Trip (${selectedPkg['rate']})',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SharedBottomNav(activeTab: 'buddies', onNavigate: widget.onNavigate),
    );
  }
}
