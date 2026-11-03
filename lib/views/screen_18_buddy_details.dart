import 'package:flutter/material.dart';

class Screen18BuddyDetails extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen18BuddyDetails({super.key, this.onNavigate});

  @override
  State<Screen18BuddyDetails> createState() => _Screen18BuddyDetailsState();
}

class _Screen18BuddyDetailsState extends State<Screen18BuddyDetails> {
  int _selectedPackageIndex = 0; // 0: Hourly (₹350/hr), 1: Half Day (₹1,200), 2: Full Day (₹2,200)
  int _selectedDateIndex = 0; // 0: Today, 1: Tomorrow, 2: Day After
  int _selectedSlotIndex = 0; // 0: Morning, 1: Afternoon, 2: Evening

  final List<Map<String, String>> _packages = [
    {'title': 'Hourly Booking', 'rate': '₹350/hr', 'sub': 'Flexible per hour rate'},
    {'title': 'Half-Day Tour', 'rate': '₹1,200', 'sub': 'Up to 4 hours guide'},
    {'title': 'Full-Day Tour', 'rate': '₹2,200', 'sub': 'Up to 8 hours complete tour'},
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
                          'Review booking details before confirming',
                          style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Summary Details Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('Buddy Name', 'Rajesh Varma ✓'),
                    const Divider(height: 16),
                    _buildSummaryRow('Package', '${pkg['title']} (${pkg['rate']})'),
                    const Divider(height: 16),
                    _buildSummaryRow('Date', '${date['day']}, ${date['date']}'),
                    const Divider(height: 16),
                    _buildSummaryRow('Time Slot', '${slot['slot']} (${slot['time']})'),
                    const Divider(height: 16),
                    _buildSummaryRow('Payment Option', 'Pay After Trip (Cash/UPI)'),
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
                            content: Text('🎉 Booking Confirmed! Connecting with Rajesh...'),
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
                      child: const Text('Confirm Booking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
          'Buddy Booking & Profile',
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
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500&fm=webp&fit=crop&q=60'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -32,
                    left: 20,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 36,
                            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&fm=webp&fit=crop&q=60'),
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.verified_user, color: Colors.white, size: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Profile Name & Tags
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    'Rajesh Varma',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F2942)),
                                  ),
                                  SizedBox(width: 6),
                                  Icon(Icons.verified, color: Color(0xFF10B981), size: 18),
                                ],
                              ),
                              const SizedBox(height: 3),
                              const Text(
                                'Certified Heritage & Culinary Guide • Vizag Native',
                                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.circle, size: 8, color: Color(0xFF10B981)),
                              SizedBox(width: 4),
                              Text(
                                'Available Today',
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF059669)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Ratings & Trips Done
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        const Text('4.98', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F2942))),
                        const SizedBox(width: 4),
                        const Text('(142 reviews)', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                        const SizedBox(width: 12),
                        const Text('•', style: TextStyle(color: Color(0xFF94A3B8))),
                        const SizedBox(width: 12),
                        const Icon(Icons.shield_outlined, color: Color(0xFFFF8C00), size: 16),
                        const SizedBox(width: 4),
                        const Text('Police KYC Approved', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFFFF8C00))),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(height: 1, color: Color(0xFFE2E8F0)),
              ),
              const SizedBox(height: 18),

              // 2. CHARGES & PACKAGES SECTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '1. SELECT CHARGES & PACKAGE',
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
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 3. AVAILABILITY & TIMING SECTION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '2. SELECT DATE & AVAILABILITY',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFFF8C00), letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 10),

                    // Date Selection Chips
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

                    // Time Slot Options
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
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 4. BOOKING SUMMARY & ACTION BAR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
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
                              const Text('Estimated Rate', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_month, size: 20),
                              SizedBox(width: 8),
                              Text('Proceed to Buddy Booking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
