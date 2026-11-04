import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';

class Screen19BuddyRatings extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen19BuddyRatings({super.key, this.onNavigate});

  @override
  State<Screen19BuddyRatings> createState() => _Screen19BuddyRatingsState();
}

class _Screen19BuddyRatingsState extends State<Screen19BuddyRatings> {
  String _selectedTab = 'All'; // All, Pending, Accepted, Rejected
  bool _showBookingDetails = false;
  Map<String, dynamic>? _selectedBooking;

  final List<Map<String, dynamic>> _bookings = [
    {
      'id': 'b1',
      'title': 'Visakhapatnam City Tour',
      'location': 'Visakhapatnam, AP',
      'timeAgo': '2 hours ago',
      'date': '12 Nov 2026',
      'travellers': '2 Travellers',
      'duration': 'Full Day',
      'travellerName': 'Rahul Mehta',
      'travellerRating': '4.8 (12 reviews)',
      'travellerAvatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&fm=webp&fit=crop&q=80',
      'status': 'Pending',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=200&fm=webp&fit=crop&q=80',
    },
    {
      'id': 'b2',
      'title': 'Araku Valley Day Trip',
      'location': 'Araku Valley, AP',
      'timeAgo': '5 hours ago',
      'date': '18 Nov 2026',
      'travellers': '4 Travellers',
      'duration': 'Full Day',
      'travellerName': 'Sneha Reddy',
      'travellerRating': '5.0 (28 reviews)',
      'travellerAvatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&fm=webp&fit=crop&q=80',
      'status': 'Pending',
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=200&fm=webp&fit=crop&q=80',
    },
    {
      'id': 'b3',
      'title': 'Simhachalam Temple Visit',
      'location': 'Simhachalam, AP',
      'timeAgo': '1 day ago',
      'date': '20 Oct 2026',
      'travellers': '3 Travellers',
      'duration': 'Half Day',
      'travellerName': 'Vikram Singh',
      'travellerRating': '4.8 (16 reviews)',
      'travellerAvatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&fm=webp&fit=crop&q=80',
      'status': 'Accepted',
      'image': 'https://images.unsplash.com/photo-1561361513-2d000a50f0dc?w=200&fm=webp&fit=crop&q=80',
    },
    {
      'id': 'b4',
      'title': 'Rushikonda Beach Experience',
      'location': 'Rushikonda, AP',
      'timeAgo': '2 days ago',
      'date': '10 Oct 2026',
      'travellers': '2 Travellers',
      'duration': 'Half Day',
      'travellerName': 'Ananya Iyer',
      'travellerRating': '4.7 (9 reviews)',
      'travellerAvatar': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&fm=webp&fit=crop&q=80',
      'status': 'Rejected',
      'image': 'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=200&fm=webp&fit=crop&q=80',
    },
    {
      'id': 'b5',
      'title': 'Local Food & Culture Walk',
      'location': 'Visakhapatnam, AP',
      'timeAgo': '4 days ago',
      'date': '25 Oct 2026',
      'travellers': '3 Travellers',
      'duration': 'Evening',
      'travellerName': 'Emily Carter',
      'travellerRating': '5.0 (50 reviews)',
      'travellerAvatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&fm=webp&fit=crop&q=80',
      'status': 'Accepted',
      'image': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=200&fm=webp&fit=crop&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (_showBookingDetails) return _buildBookingDetailsView();

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => widget.onNavigate?.call('18-buddy-details'),
        ),
        title: Text(
          'Travel Buddy',
          style: AppTheme.serifTitle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bookings', style: AppTheme.serifTitle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Manage travel guide requests from travellers.', style: AppTheme.sansBody(fontSize: 12, color: AppTheme.textSecondaryLight)),
            const SizedBox(height: 14),

            // Status Tabs
            Row(
              children: ['All', 'Pending', 'Accepted', 'Rejected'].map((tab) {
                final isSel = _selectedTab == tab;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    onTap: () => setState(() => _selectedTab = tab),
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: isSel ? AppTheme.primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: isSel ? AppTheme.primaryColor : AppTheme.cardBorderColor),
                      ),
                      child: Text(
                        tab,
                        style: AppTheme.sansBody(
                          fontSize: 11.5,
                          fontWeight: isSel ? FontWeight.bold : FontWeight.w500,
                          color: isSel ? Colors.white : AppTheme.textPrimaryLight,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),

            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.cardBorderColor),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search_rounded, size: 18, color: AppTheme.textSecondaryLight),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search by traveller, location or date...',
                        hintStyle: TextStyle(fontSize: 11.5, color: AppTheme.textSecondaryLight),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  Icon(Icons.tune_rounded, size: 18, color: AppTheme.primaryColor),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Request Cards
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredBookings.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _filteredBookings[index];
                return _buildRequestCard(item);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: SharedBottomNav(
        activeTab: 'bookings',
        isBuddyPortal: true,
        onNavigate: widget.onNavigate,
      ),
    );
  }

  List<Map<String, dynamic>> get _filteredBookings {
    if (_selectedTab == 'All') return _bookings;
    return _bookings.where((b) => b['status'] == _selectedTab).toList();
  }

  Widget _buildRequestCard(Map<String, dynamic> item) {
    final status = item['status'] as String;
    final isPending = status == 'Pending';
    final isAccepted = status == 'Accepted';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.cardBorderColor),
        boxShadow: const [BoxShadow(color: Color(0x06231815), blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item['image'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item['title'],
                            style: AppTheme.serifTitle(fontSize: 13.5, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isPending
                                ? AppTheme.pendingLight
                                : (isAccepted ? AppTheme.successLight : AppTheme.sosLight),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            status,
                            style: AppTheme.sansBody(
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              color: isPending
                                  ? AppTheme.pendingAmber
                                  : (isAccepted ? AppTheme.successGreen : AppTheme.sosRed),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${item['location']} • ${item['timeAgo']}',
                      style: AppTheme.sansBody(fontSize: 10, color: AppTheme.textSecondaryLight),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item['date']} • ${item['travellers']} • ${item['duration']}',
                      style: AppTheme.sansBody(fontSize: 10.5, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 18, color: AppTheme.cardBorderColor),

          // Traveller Info & Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(item['travellerAvatar']),
                  ),
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['travellerName'], style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold)),
                      Text('★ ${item['travellerRating']}', style: AppTheme.sansBody(fontSize: 9.5, color: AppTheme.textSecondaryLight)),
                    ],
                  ),
                ],
              ),
              if (isPending)
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() => item['status'] = 'Rejected');
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.cardBorderColor),
                        ),
                        child: Text('Reject', style: AppTheme.sansBody(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppTheme.textSecondaryLight)),
                      ),
                    ),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: () {
                        setState(() => item['status'] = 'Accepted');
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('Accept', style: AppTheme.sansBody(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ],
                )
              else
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedBooking = item;
                      _showBookingDetails = true;
                    });
                  },
                  child: Row(
                    children: [
                      Text('View Details', style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 10, color: AppTheme.primaryColor),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // Screen 2: Booking Details (Image 5, Right Screen)
  Widget _buildBookingDetailsView() {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => setState(() => _showBookingDetails = false),
        ),
        title: Text('Travel Buddy', style: AppTheme.serifTitle(fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month_rounded, color: AppTheme.primaryColor),
            onPressed: () {},
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Booking Details', style: AppTheme.serifTitle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Review and customize your travel experience', style: AppTheme.sansBody(fontSize: 12, color: AppTheme.textSecondaryLight)),
            const SizedBox(height: 16),

            // Traveller card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.cardBorderColor),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&fm=webp&fit=crop&q=80'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Emily Carter', style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold)),
                        Text('Germany', style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, size: 14, color: AppTheme.accentGold),
                            Text(' 5.0 (50 reviews)', style: AppTheme.sansBody(fontSize: 10.5, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.successLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle_rounded, size: 12, color: AppTheme.successGreen),
                        const SizedBox(width: 4),
                        Text('Accepted', style: AppTheme.sansBody(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.successGreen)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Destinations
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Destinations', style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text('+2 more >', style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildDestMiniCard('RK Beach', 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=150&fm=webp&fit=crop&q=80'),
                const SizedBox(width: 8),
                _buildDestMiniCard('Submarine Museum', 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=150&fm=webp&fit=crop&q=80'),
                const SizedBox(width: 8),
                _buildDestMiniCard('Kailasagiri', 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=150&fm=webp&fit=crop&q=80'),
                const SizedBox(width: 8),
                _buildDestMiniCard('Araku Valley', 'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=150&fm=webp&fit=crop&q=80'),
              ],
            ),
            const SizedBox(height: 16),

            // Number of Travellers
            _buildInfoDropdown('Number of Travellers', 'Total people for this booking', '1 (You + 1 Buddy)', Icons.people_outline_rounded),
            const SizedBox(height: 12),

            // Travelling Time
            _buildInfoDropdown('Travelling Time', 'Select how long you need a guide', '1 - 3 Hours', Icons.access_time_rounded),
            const SizedBox(height: 16),

            // Booking Amount
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppTheme.cardBorderColor),
              ),
              child: Row(
                children: [
                  const Icon(Icons.currency_rupee_rounded, color: AppTheme.primaryColor, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Booking Amount', style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
                        Text('₹ 250 / hour', style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                        Text('(Charged by your travel buddy)', style: AppTheme.sansBody(fontSize: 10, color: AppTheme.textSecondaryLight)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Buddy Note
            Text('Buddy Note', style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.cardBorderColor),
              ),
              child: Row(
                children: [
                  const Icon(Icons.chat_bubble_outline_rounded, size: 16, color: AppTheme.primaryColor),
                  const SizedBox(width: 8),
                  Text('Add any special requests or preferences...', style: AppTheme.sansBody(fontSize: 11.5, color: AppTheme.textSecondaryLight)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Confirmation Status Box
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.successLight,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFB8ECC2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_rounded, color: AppTheme.successGreen, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Booking Status', style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.successGreen)),
                        Text('Confirmed for 12 Nov 2026', style: AppTheme.sansBody(fontSize: 12.5, fontWeight: FontWeight.bold, color: AppTheme.textPrimaryLight)),
                        Text('Your booking has been accepted by Emily Carter', style: AppTheme.sansBody(fontSize: 10.5, color: AppTheme.textSecondaryLight)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDestMiniCard(String name, String img) {
    return Expanded(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(img, height: 48, width: double.infinity, fit: BoxFit.cover),
          ),
          const SizedBox(height: 3),
          Text(name, style: AppTheme.sansBody(fontSize: 9, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildInfoDropdown(String title, String desc, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.cardBorderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
                Text(value, style: AppTheme.sansBody(fontSize: 12.5, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_rounded, color: AppTheme.textSecondaryLight),
        ],
      ),
    );
  }
}
