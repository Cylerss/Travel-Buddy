import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';

class Screen11BuddyProfile extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen11BuddyProfile({super.key, this.onNavigate});

  @override
  State<Screen11BuddyProfile> createState() => _Screen11BuddyProfileState();
}

class _Screen11BuddyProfileState extends State<Screen11BuddyProfile> {
  int _activeTabIndex = 0; // 0: About Me, 1: Experience, 2: Reviews
  bool _isLiked = false;
  bool _showBookingSheet = false;

  // Booking Modal State
  int _selectedPackage = 0; // 0: Hourly (350), 1: Half-Day (1200), 2: Full-Day (2200)
  int _selectedDate = 0;
  int _selectedSlot = 0;
  int _adultsCount = 1;
  int _childrenCount = 0;

  final List<String> _tags = ['Beaches', 'Trekking', 'Coastal Food', 'Photography', 'Adventure'];

  final List<Map<String, dynamic>> _packages = [
    {
      'title': 'Hourly Guide',
      'price': '₹350/hr',
      'desc': 'Best for short tours & local exploration',
      'rateNum': 350,
    },
    {
      'title': 'Half-Day Tour',
      'price': '₹1,200',
      'desc': '4 Hours (Beaches & City)',
      'rateNum': 1200,
    },
    {
      'title': 'Full-Day Tour',
      'price': '₹2,200',
      'desc': '8 Hours Vizag Exploration with hidden gems',
      'rateNum': 2200,
    },
  ];

  final List<Map<String, String>> _dates = [
    {'day': 'Today', 'date': 'Oct 29'},
    {'day': 'Thu', 'date': 'Oct 30'},
    {'day': 'Fri', 'date': 'Oct 31'},
    {'day': 'Sat', 'date': 'Nov 1'},
    {'day': 'Sun', 'date': 'Nov 2'},
  ];

  final List<Map<String, String>> _slots = [
    {'title': 'Morning', 'time': '09:00 AM - 01:00 PM'},
    {'title': 'Afternoon', 'time': '01:00 PM - 06:00 PM'},
    {'title': 'Evening', 'time': '06:00 PM - 10:00 PM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: _showBookingSheet ? _buildBookWithArjunView() : _buildProfileView(),
      bottomNavigationBar: _showBookingSheet
          ? null
          : SharedBottomNav(
              activeTab: 'buddies',
              onNavigate: widget.onNavigate,
            ),
    );
  }

  // Screen 1: Profile View (Image 2, Top-Middle)
  Widget _buildProfileView() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // App Bar / Cover Photo
        SliverAppBar(
          expandedHeight: 280,
          pinned: true,
          backgroundColor: AppTheme.backgroundLight,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppTheme.textPrimaryLight),
              onPressed: () => widget.onNavigate?.call('10-find-buddy'),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  _isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: _isLiked ? Colors.redAccent : AppTheme.textPrimaryLight,
                  size: 20,
                ),
                onPressed: () => setState(() => _isLiked = !_isLiked),
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&fm=webp&fit=crop&q=80',
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0x9918100C), Colors.transparent, Color(0xDDFAF4EE)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.4, 1.0],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 20,
                  right: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Avatar
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: const [
                                BoxShadow(color: Color(0x26000000), blurRadius: 8, offset: Offset(0, 3)),
                              ],
                            ),
                            child: const CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=200&fm=webp&fit=crop&q=80',
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              child: const Icon(Icons.verified_rounded, color: Color(0xFF1E88E5), size: 18),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Arjun Varma',
                                  style: AppTheme.serifTitle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppTheme.successLight,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '● Available Now',
                                    style: AppTheme.sansBody(fontSize: 9.5, fontWeight: FontWeight.bold, color: AppTheme.successGreen),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Local Guide & Trekker',
                              style: AppTheme.sansBody(fontSize: 12, color: AppTheme.textSecondaryLight),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.star_rounded, color: AppTheme.accentGold, size: 16),
                                const SizedBox(width: 2),
                                Text(
                                  '4.8 (132 reviews)',
                                  style: AppTheme.sansBody(fontSize: 11.5, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' • 142 Trips',
                                  style: AppTheme.sansBody(fontSize: 11.5, color: AppTheme.textSecondaryLight),
                                ),
                              ],
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
        ),

        // Body Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location row
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded, color: AppTheme.primaryColor, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Visakhapatnam, Andhra Pradesh',
                      style: AppTheme.sansBody(fontSize: 12, color: AppTheme.textSecondaryLight),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Mini Gallery
                SizedBox(
                  height: 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=200&fm=webp&fit=crop&q=80',
                      'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=200&fm=webp&fit=crop&q=80',
                      'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=200&fm=webp&fit=crop&q=80',
                      'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=200&fm=webp&fit=crop&q=80',
                    ].map((img) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(img, width: 60, height: 60, fit: BoxFit.cover),
                        ),
                      );
                    }).toList()
                      ..add(
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppTheme.chipBackground,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.chipBorder),
                          ),
                          child: Center(
                            child: Text(
                              '+8',
                              style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                            ),
                          ),
                        ),
                      ),
                  ),
                ),
                const SizedBox(height: 14),

                // Tags Row
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: _tags.map((t) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppTheme.cardBorderColor),
                      ),
                      child: Text(
                        t,
                        style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 18),

                // Tabs: [About Me | Experience | Reviews]
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.cardBorderColor),
                  ),
                  child: Row(
                    children: ['About Me', 'Experience', 'Reviews'].asMap().entries.map((entry) {
                      final idx = entry.key;
                      final title = entry.value;
                      final isSel = _activeTabIndex == idx;
                      return Expanded(
                        child: InkWell(
                          onTap: () => setState(() => _activeTabIndex = idx),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSel ? AppTheme.primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              title,
                              style: AppTheme.sansBody(
                                fontSize: 12,
                                fontWeight: isSel ? FontWeight.bold : FontWeight.w600,
                                color: isSel ? Colors.white : AppTheme.textSecondaryLight,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),

                // Tab Content: About Me
                if (_activeTabIndex == 0) ...[
                  Text(
                    'About Me',
                    style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Hi! I'm Arjun, a local from Visakhapatnam. I love exploring beaches, hidden spots and scenic trails. I enjoy meeting new people and helping travellers experience the real Vizag with safety and fun.",
                    style: AppTheme.sansBody(fontSize: 12.5, color: AppTheme.textSecondaryLight, height: 1.45),
                  ),
                  const SizedBox(height: 16),

                  // Info Icons Grid
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppTheme.cardBorderColor),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _buildInfoItem(Icons.cake_rounded, '24', 'Age'),
                            _buildInfoItem(Icons.school_rounded, 'Graduate', 'Education'),
                            _buildInfoItem(Icons.work_rounded, '3+ Years', 'Experience'),
                          ],
                        ),
                        const Divider(height: 16, color: AppTheme.cardBorderColor),
                        Row(
                          children: [
                            _buildInfoItem(Icons.translate_rounded, 'English, Telugu, Hindi', 'Languages'),
                            _buildInfoItem(Icons.groups_rounded, 'Solo / Group', 'Travelling With'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Why Travel with Me?
                  Text(
                    'Why Travel with Me?',
                    style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.2,
                    children: [
                      _buildWhyCard(Icons.explore_rounded, 'Local Insights', 'Hidden gems & local stories'),
                      _buildWhyCard(Icons.shield_rounded, 'Safe & Friendly', 'Your safety is my priority'),
                      _buildWhyCard(Icons.tune_rounded, 'Flexible Itineraries', 'Customized to your interests'),
                      _buildWhyCard(Icons.camera_alt_rounded, 'Great Photos', 'Capture memorable moments'),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Quote card
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.chipBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.chipBorder),
                    ),
                    child: Center(
                      child: Text(
                        '"Let\'s explore the real Vizag together!"',
                        style: AppTheme.serifTitle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ] else if (_activeTabIndex == 1) ...[
                  Text(
                    'Experience & Certifications',
                    style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '• AP Tourism Certified Local Guide\n• 140+ completed guided tours across Araku, Rushikonda, and Yarada\n• Wilderness First Aid & CPR certified\n• Deep knowledge of tribal culture and coastline trails.',
                    style: AppTheme.sansBody(fontSize: 13, height: 1.6),
                  ),
                  const SizedBox(height: 24),
                ] else ...[
                  Text(
                    'Traveller Reviews (132)',
                    style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildReviewItem('Elena R. (Germany)', 5.0, 'Arjun was wonderful! Showed us scenic spots in Araku that were not in tourist maps. Highly recommended!'),
                  const SizedBox(height: 8),
                  _buildReviewItem('Karan S. (Mumbai)', 4.8, 'Very polite, great driver and photographer. Felt super safe exploring Vizag.'),
                  const SizedBox(height: 24),
                ],

                // Bottom Floating Action Button Bar
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.cardBorderColor),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.chat_bubble_outline_rounded, color: AppTheme.primaryColor),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Starting chat with Arjun Varma...'), duration: Duration(seconds: 1)),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () => setState(() => _showBookingSheet = true),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryColor.withValues(alpha: 0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Book with Arjun',
                                style: AppTheme.sansBody(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Screen 2: "Book with Arjun" (Image 2, Top-Right)
  Widget _buildBookWithArjunView() {
    final pkg = _packages[_selectedPackage];
    final total = pkg['rateNum'] as int;

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => setState(() => _showBookingSheet = false),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Book with Arjun', style: AppTheme.serifTitle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Choose your experience and plan your trip', style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Packages & Charges
            Text('Packages & Charges', style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _packages.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final p = _packages[index];
                  final isSel = _selectedPackage == index;
                  return InkWell(
                    onTap: () => setState(() => _selectedPackage = index),
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      width: 140,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSel ? AppTheme.chipBackground : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isSel ? AppTheme.primaryColor : AppTheme.cardBorderColor,
                          width: isSel ? 1.5 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            index == 0 ? Icons.timer_outlined : (index == 1 ? Icons.wb_sunny_outlined : Icons.explore_outlined),
                            color: AppTheme.primaryColor,
                            size: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p['title'] as String, style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold)),
                              Text(p['price'] as String, style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                            ],
                          ),
                          Text(
                            p['desc'] as String,
                            style: AppTheme.sansBody(fontSize: 9.5, color: AppTheme.textSecondaryLight),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Select Date
            Text('Select Date', style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _dates.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final d = _dates[index];
                        final isSel = _selectedDate == index;
                        return InkWell(
                          onTap: () => setState(() => _selectedDate = index),
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            width: 60,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: isSel ? AppTheme.primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: isSel ? AppTheme.primaryColor : AppTheme.cardBorderColor),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  d['day']!,
                                  style: AppTheme.sansBody(
                                    fontSize: 10,
                                    fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                                    color: isSel ? Colors.white : AppTheme.textSecondaryLight,
                                  ),
                                ),
                                Text(
                                  d['date']!,
                                  style: AppTheme.sansBody(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isSel ? Colors.white : AppTheme.textPrimaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 44,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppTheme.cardBorderColor),
                  ),
                  child: const Icon(Icons.calendar_month_rounded, color: AppTheme.primaryColor, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Select Time Slot
            Text('Select Time Slot', style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ..._slots.asMap().entries.map((entry) {
              final idx = entry.key;
              final slot = entry.value;
              final isSel = _selectedSlot == idx;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () => setState(() => _selectedSlot = idx),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSel ? AppTheme.primaryColor : AppTheme.cardBorderColor,
                        width: isSel ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(slot['title']!, style: AppTheme.sansBody(fontSize: 13, fontWeight: FontWeight.bold)),
                            Text(slot['time']!, style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
                          ],
                        ),
                        Radio<int>(
                          value: idx,
                          groupValue: _selectedSlot,
                          activeColor: AppTheme.primaryColor,
                          onChanged: (val) => setState(() => _selectedSlot = val!),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 14),

            // Number of Guests
            Text('Number of Guests', style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppTheme.cardBorderColor),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person_outline_rounded, size: 18, color: AppTheme.primaryColor),
                          const SizedBox(width: 8),
                          Text('Adults', style: AppTheme.sansBody(fontSize: 13, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      _buildCounter(
                        count: _adultsCount,
                        onDecrement: () {
                          if (_adultsCount > 1) setState(() => _adultsCount--);
                        },
                        onIncrement: () => setState(() => _adultsCount++),
                      ),
                    ],
                  ),
                  const Divider(height: 20, color: AppTheme.cardBorderColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.child_care_rounded, size: 18, color: AppTheme.primaryColor),
                          const SizedBox(width: 8),
                          Text('Children (Below 12)', style: AppTheme.sansBody(fontSize: 13, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      _buildCounter(
                        count: _childrenCount,
                        onDecrement: () {
                          if (_childrenCount > 0) setState(() => _childrenCount--);
                        },
                        onIncrement: () => setState(() => _childrenCount++),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Summary Card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.chipBackground,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppTheme.chipBorder),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=200&fm=webp&fit=crop&q=80',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hourly Guide with Arjun', style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold)),
                        Text(
                          '${_dates[_selectedDate]['day']}, ${_dates[_selectedDate]['date']} • ${_slots[_selectedSlot]['title']} • $_adultsCount Adult',
                          style: AppTheme.sansBody(fontSize: 10.5, color: AppTheme.textSecondaryLight),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '₹$total',
                    style: AppTheme.serifTitle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Add to Cart / Proceed CTA
            InkWell(
              onTap: () {
                setState(() => _showBookingSheet = false);
                widget.onNavigate?.call('booking-confirmation');
              },
              borderRadius: BorderRadius.circular(24),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_cart_checkout_rounded, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Add to Cart ->',
                      style: AppTheme.sansBody(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String subtitle) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primaryColor, size: 20),
          const SizedBox(height: 4),
          Text(title, style: AppTheme.sansBody(fontSize: 11.5, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          Text(subtitle, style: AppTheme.sansBody(fontSize: 10, color: AppTheme.textSecondaryLight), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildWhyCard(IconData icon, String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.cardBorderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryColor, size: 18),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold), maxLines: 1),
                Text(desc, style: AppTheme.sansBody(fontSize: 9, color: AppTheme.textSecondaryLight), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(String name, double rating, String comment) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.cardBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Icon(Icons.star_rounded, size: 14, color: AppTheme.accentGold),
                  Text('$rating', style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(comment, style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
        ],
      ),
    );
  }

  Widget _buildCounter({required int count, required VoidCallback onDecrement, required VoidCallback onIncrement}) {
    return Row(
      children: [
        InkWell(
          onTap: onDecrement,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.cardBorderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.remove, size: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('$count', style: AppTheme.sansBody(fontSize: 14, fontWeight: FontWeight.bold)),
        ),
        InkWell(
          onTap: onIncrement,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.add, size: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
