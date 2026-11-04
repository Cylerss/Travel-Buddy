import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';

class Screen10FindBuddy extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen10FindBuddy({super.key, this.onNavigate});

  @override
  State<Screen10FindBuddy> createState() => _Screen10FindBuddyState();
}

class _Screen10FindBuddyState extends State<Screen10FindBuddy> {
  String selectedLocation = 'Visakhapatnam';
  String sortBy = 'Best Match';
  final Set<String> _likedBuddies = {'arjun'};

  final List<Map<String, dynamic>> preferences = [
    {'label': 'Nature & Beaches', 'icon': Icons.beach_access_rounded, 'selected': true},
    {'label': 'Photography', 'icon': Icons.camera_alt_rounded, 'selected': true},
    {'label': 'Food Exploration', 'icon': Icons.restaurant_rounded, 'selected': true},
    {'label': 'Adventure Activities', 'icon': Icons.hiking_rounded, 'selected': true},
    {'label': 'Relaxed Pace', 'icon': Icons.coffee_rounded, 'selected': true},
    {'label': 'Friendly & Social', 'icon': Icons.people_outline_rounded, 'selected': true},
  ];

  final List<Map<String, dynamic>> buddies = [
    {
      'id': 'arjun',
      'name': 'Arjun Varma',
      'isVerified': true,
      'rating': 4.8,
      'reviews': 32,
      'distance': '3 km away',
      'tags': ['Beach', 'Food', 'Heritage'],
      'avatar': 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=200&fm=webp&fit=crop&q=80',
    },
    {
      'id': 'rohit',
      'name': 'Rohit K',
      'isVerified': true,
      'rating': 4.6,
      'reviews': 28,
      'distance': '5 km away',
      'tags': ['Culture', 'Food', 'Road Trips'],
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&fm=webp&fit=crop&q=80',
    },
    {
      'id': 'karthik',
      'name': 'Karthik Sai',
      'isVerified': true,
      'rating': 4.5,
      'reviews': 18,
      'distance': '7 km away',
      'tags': ['Adventure', 'Beaches', 'Nature'],
      'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&fm=webp&fit=crop&q=80',
    },
    {
      'id': 'vivek',
      'name': 'Vivek Sharma',
      'isVerified': false,
      'rating': 4.4,
      'reviews': 14,
      'distance': '9 km away',
      'tags': ['Photography', 'Food', 'Shopping'],
      'avatar': 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=200&fm=webp&fit=crop&q=80',
    },
  ];

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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find Your Travel Buddy',
              style: AppTheme.serifTitle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Choose your preferences and find the perfect buddy',
              style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight),
            ),
          ],
        ),
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
            // Location Chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.cardBorderColor),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on_rounded, color: AppTheme.primaryColor, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    selectedLocation,
                    style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppTheme.textSecondaryLight),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Your Preferences Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Preferences',
                  style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: _showEditPreferences,
                  child: Text(
                    'Edit',
                    style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Preference Chips Grid / Wrap
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: preferences.map((p) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.cardBorderColor),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x06231815),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(p['icon'] as IconData, size: 14, color: AppTheme.primaryColor),
                      const SizedBox(width: 5),
                      Text(
                        p['label'] as String,
                        style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Recommended Buddies Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommended Buddies',
                  style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: _showSortModal,
                  child: Row(
                    children: [
                      const Icon(Icons.sort_rounded, size: 14, color: AppTheme.primaryColor),
                      const SizedBox(width: 4),
                      Text(
                        'Sort',
                        style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Buddy Cards
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: buddies.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final b = buddies[index];
                return _buildBuddyCard(b);
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: SharedBottomNav(
        activeTab: 'buddies',
        onNavigate: widget.onNavigate,
      ),
    );
  }

  Widget _buildBuddyCard(Map<String, dynamic> b) {
    final isLiked = _likedBuddies.contains(b['id']);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.cardBorderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0A231815),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar with verified badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  b['avatar'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              if (b['isVerified'] == true)
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.verified_rounded, size: 16, color: Color(0xFF1E88E5)),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),

          // Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      b['name'],
                      style: AppTheme.serifTitle(fontSize: 14.5, fontWeight: FontWeight.bold),
                    ),
                    if (b['isVerified'] == true) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.verified_rounded, size: 14, color: Color(0xFF1E88E5)),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, size: 14, color: AppTheme.accentGold),
                    const SizedBox(width: 2),
                    Text(
                      '${b['rating']} (${b['reviews']})',
                      style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      ' • ${b['distance']}',
                      style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 4,
                  children: (b['tags'] as List<String>).map((t) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.chipBackground,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        t,
                        style: AppTheme.sansBody(fontSize: 9.5, fontWeight: FontWeight.w600, color: AppTheme.textSecondaryLight),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Actions
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isLiked) {
                      _likedBuddies.remove(b['id']);
                    } else {
                      _likedBuddies.add(b['id']);
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    color: isLiked ? Colors.redAccent : AppTheme.textSecondaryLight,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => widget.onNavigate?.call('11-buddy-profile'),
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    'View Profile',
                    style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSortModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['Best Match', 'Top Rated', 'Nearest First', 'Most Trips'].map((s) {
              return ListTile(
                title: Text(s, style: AppTheme.sansBody(fontSize: 14, fontWeight: FontWeight.w600)),
                trailing: sortBy == s ? const Icon(Icons.check, color: AppTheme.primaryColor) : null,
                onTap: () {
                  setState(() => sortBy = s);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showEditPreferences() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Preferences updated based on your recent travels!'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
