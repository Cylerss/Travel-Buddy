import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';

class Screen08ExploreVizag extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen08ExploreVizag({super.key, this.onNavigate});

  @override
  State<Screen08ExploreVizag> createState() => _Screen08ExploreVizagState();
}

class _Screen08ExploreVizagState extends State<Screen08ExploreVizag> {
  // Planner State
  String _selectedDestination = 'Visakhapatnam';
  String _selectedDateRange = 'Oct 29 - Nov 3';
  String _selectedCategory = 'Anything';
  bool _showPlanner = false;

  // Search & Experiences State
  String _activeFilter = 'All';
  String _sortBy = 'Recommended';
  final Set<String> _cartItems = {};
  final Set<String> _favorites = {'rk-beach', 'kailasagiri'};

  final List<String> _filterPills = ['All', 'Beaches', 'Temples', 'Nature', 'Day Trips'];

  final List<Map<String, dynamic>> _experiences = [
    {
      'id': 'rk-beach-exp',
      'title': 'RK Beach Experience',
      'category': 'Beaches • Visakhapatnam',
      'rating': 4.7,
      'reviews': '2.4K reviews',
      'duration': '2 - 3 hours • Family Friendly',
      'price': 499,
      'isPopular': true,
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500&fm=webp&fit=crop&q=80',
    },
    {
      'id': 'kailasagiri-exp',
      'title': 'Kailasagiri Hill & Ropeway',
      'category': 'Sightseeing • Visakhapatnam',
      'rating': 4.8,
      'reviews': '3.1K reviews',
      'duration': '3 - 4 hours • All Ages',
      'price': 599,
      'isPopular': false,
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=500&fm=webp&fit=crop&q=80',
    },
    {
      'id': 'submarine-exp',
      'title': 'INS Kursura Submarine Museum',
      'category': 'Museums • Visakhapatnam',
      'rating': 4.5,
      'reviews': '1.8K reviews',
      'duration': '1 - 2 hours • Family Friendly',
      'price': 399,
      'isPopular': false,
      'image': 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=500&fm=webp&fit=crop&q=80',
    },
    {
      'id': 'simhachalam-exp',
      'title': 'Simhachalam Temple',
      'category': 'Temples • Visakhapatnam',
      'rating': 4.9,
      'reviews': '1.2K reviews',
      'duration': '2 - 3 hours • All Ages',
      'price': 299,
      'isPopular': false,
      'image': 'https://images.unsplash.com/photo-1561361513-2d000a50f0dc?w=500&fm=webp&fit=crop&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: _buildAppBar(),
      body: _showPlanner ? _buildPlannerView() : _buildExperiencesView(),
      bottomNavigationBar: SharedBottomNav(
        activeTab: 'wishlist',
        onNavigate: widget.onNavigate,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        onPressed: () {
          if (_showPlanner) {
            setState(() => _showPlanner = false);
          } else {
            widget.onNavigate?.call('07-home');
          }
        },
      ),
      title: Row(
        children: [
          const Icon(Icons.location_on_rounded, color: AppTheme.primaryColor, size: 18),
          const SizedBox(width: 4),
          Text(
            _selectedDestination,
            style: AppTheme.serifTitle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(_showPlanner ? Icons.grid_view_rounded : Icons.tune_rounded),
          tooltip: _showPlanner ? 'View Experiences' : 'Plan Trip',
          onPressed: () {
            setState(() => _showPlanner = !_showPlanner);
          },
        ),
        GestureDetector(
          onTap: () => widget.onNavigate?.call('checkout-options'),
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 4),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.shopping_bag_outlined, color: AppTheme.textPrimaryLight, size: 22),
                if (_cartItems.isNotEmpty)
                  Positioned(
                    top: 8,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${_cartItems.length}',
                        style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // View 1: Experiences / Search Results List (Image 4, bottom right)
  Widget _buildExperiencesView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter pills
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: _filterPills.map((pill) {
                final isSelected = _activeFilter == pill;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    onTap: () => setState(() => _activeFilter = pill),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? AppTheme.primaryColor : AppTheme.cardBorderColor,
                        ),
                      ),
                      child: Text(
                        pill,
                        style: AppTheme.sansBody(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? Colors.white : AppTheme.textPrimaryLight,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Count and Sort Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '86 experiences',
                style: AppTheme.sansBody(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textSecondaryLight),
              ),
              InkWell(
                onTap: _showSortOptions,
                child: Row(
                  children: [
                    Text(
                      'Sort by: $_sortBy',
                      style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.primaryColor),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppTheme.primaryColor),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // List of experiences
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _experiences.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final exp = _experiences[index];
              return _buildExperienceCard(exp);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(Map<String, dynamic> exp) {
    final isFavorite = _favorites.contains(exp['id']);
    final inCart = _cartItems.contains(exp['id']);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.cardBorderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0A231815),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(19)),
                child: Image.network(
                  exp['image'],
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (exp['isPopular'] == true)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Most Popular',
                      style: AppTheme.sansBody(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isFavorite) {
                        _favorites.remove(exp['id']);
                      } else {
                        _favorites.add(exp['id']);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      color: isFavorite ? Colors.redAccent : AppTheme.textSecondaryLight,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exp['title'],
                            style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            exp['category'],
                            style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹${exp['price']}',
                          style: AppTheme.serifTitle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        Text(
                          'per person',
                          style: AppTheme.sansBody(fontSize: 9.5, color: AppTheme.textSecondaryLight),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded, size: 14, color: AppTheme.textSecondaryLight),
                    const SizedBox(width: 4),
                    Text(
                      exp['duration'],
                      style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, size: 16, color: AppTheme.accentGold),
                    const SizedBox(width: 4),
                    Text(
                      '${exp['rating']}',
                      style: AppTheme.sansBody(fontSize: 11.5, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' (${exp['reviews']})',
                      style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Add to Cart Button
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (inCart) {
                              _cartItems.remove(exp['id']);
                            } else {
                              _cartItems.add(exp['id']);
                            }
                          });
                          // Navigate to checkout options
                          widget.onNavigate?.call('checkout-options');
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 42,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: inCart ? null : AppTheme.primaryGradient,
                            color: inCart ? AppTheme.successGreen : null,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                inCart ? Icons.check_circle_outline : Icons.shopping_bag_outlined,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                inCart ? 'Book Options' : 'Add to Cart',
                                style: AppTheme.sansBody(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
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
        ],
      ),
    );
  }

  // View 2: "Plan Your Trip" (Image 4, bottom-left)
  Widget _buildPlannerView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Plan Your Trip',
            style: AppTheme.serifTitle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            'Explore tours, theme parks, spas and more',
            style: AppTheme.sansBody(fontSize: 12.5, color: AppTheme.textSecondaryLight),
          ),
          const SizedBox(height: 16),

          // Hero Banner
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&fm=webp&fit=crop&q=80',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 18),

          // What are you looking for? Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppTheme.cardBorderColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x0D231815),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What are you looking for?',
                  style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),

                // Destination
                _buildPlannerField(
                  icon: Icons.location_on_rounded,
                  label: 'Destination',
                  value: _selectedDestination,
                  onTap: _showDestinationBottomSheet,
                ),
                const Divider(height: 20, color: AppTheme.cardBorderColor),

                // Date
                _buildPlannerField(
                  icon: Icons.calendar_month_rounded,
                  label: 'Date',
                  value: _selectedDateRange,
                  onTap: _showDatesBottomSheet,
                ),
                const Divider(height: 20, color: AppTheme.cardBorderColor),

                // Category
                _buildPlannerField(
                  icon: Icons.category_rounded,
                  label: 'Category',
                  value: _selectedCategory,
                  onTap: _showCategoryBottomSheet,
                ),
                const SizedBox(height: 20),

                // Explore CTA Button
                InkWell(
                  onTap: () {
                    setState(() => _showPlanner = false);
                  },
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    height: 48,
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
                        Text(
                          'Explore',
                          style: AppTheme.sansBody(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPlannerField({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.chipBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.primaryColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight),
                ),
                Text(
                  value,
                  style: AppTheme.sansBody(fontSize: 13.5, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, color: AppTheme.textSecondaryLight, size: 14),
        ],
      ),
    );
  }

  // Destination Bottom Sheet (Image 4, bottom middle 1)
  void _showDestinationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 480,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Destination', style: AppTheme.serifTitle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundLight,
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
                          hintText: 'Search destination',
                          hintStyle: TextStyle(fontSize: 12, color: AppTheme.textSecondaryLight),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Popular Destinations',
                style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textSecondaryLight),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: [
                    'Visakhapatnam',
                    'Araku Valley',
                    'Vijayawada',
                    'Hyderabad',
                    'Puri',
                    'Srisailam',
                  ].map((city) {
                    final isSel = _selectedDestination == city;
                    return ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=100&fm=webp&fit=crop&q=80',
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(city, style: AppTheme.sansBody(fontSize: 13.5, fontWeight: FontWeight.w600)),
                      trailing: Radio<String>(
                        value: city,
                        groupValue: _selectedDestination,
                        activeColor: AppTheme.primaryColor,
                        onChanged: (val) {
                          setState(() => _selectedDestination = val!);
                        },
                      ),
                      onTap: () {
                        setState(() => _selectedDestination = city);
                      },
                    );
                  }).toList(),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Done', style: AppTheme.sansBody(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Dates Bottom Sheet (Image 4, bottom middle 2)
  void _showDatesBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 480,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Dates', style: AppTheme.serifTitle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.cardBorderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Start Date', style: AppTheme.sansBody(fontSize: 10, color: AppTheme.textSecondaryLight)),
                          Text('Oct 29, 2026', style: AppTheme.sansBody(fontSize: 12.5, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.cardBorderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('End Date', style: AppTheme.sansBody(fontSize: 10, color: AppTheme.textSecondaryLight)),
                          Text('Nov 3, 2026', style: AppTheme.sansBody(fontSize: 12.5, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _quickDateChip('Today'),
                  const SizedBox(width: 8),
                  _quickDateChip('This Weekend', isSel: true),
                  const SizedBox(width: 8),
                  _quickDateChip('Next Week'),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'October - November 2026',
                style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '🗓️ Range Selected: Oct 29 - Nov 3 (5 Days)',
                      style: AppTheme.sansBody(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() => _selectedDateRange = 'Oct 29 - Nov 3');
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Apply Dates (Oct 29 - Nov 3)', style: AppTheme.sansBody(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _quickDateChip(String text, {bool isSel = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSel ? AppTheme.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isSel ? AppTheme.primaryColor : AppTheme.cardBorderColor),
      ),
      child: Text(
        text,
        style: AppTheme.sansBody(
          fontSize: 11,
          fontWeight: isSel ? FontWeight.bold : FontWeight.w500,
          color: isSel ? Colors.white : AppTheme.textPrimaryLight,
        ),
      ),
    );
  }

  // Category Bottom Sheet (Image 4, bottom middle 3)
  void _showCategoryBottomSheet() {
    final categories = [
      {'name': 'Anything', 'icon': Icons.all_inclusive_rounded},
      {'name': 'Beaches', 'icon': Icons.beach_access_rounded},
      {'name': 'Adventure', 'icon': Icons.terrain_rounded},
      {'name': 'Temples', 'icon': Icons.temple_hindu_rounded},
      {'name': 'Nature', 'icon': Icons.eco_rounded},
      {'name': 'Museums', 'icon': Icons.museum_rounded},
      {'name': 'Food', 'icon': Icons.restaurant_rounded},
      {'name': 'Family', 'icon': Icons.family_restroom_rounded},
      {'name': 'Water Sports', 'icon': Icons.surfing_rounded},
      {'name': 'Day Trips', 'icon': Icons.directions_bus_rounded},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              padding: const EdgeInsets.all(20),
              height: 450,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Select Category', style: AppTheme.serifTitle(fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.8,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        final isSel = _selectedCategory == cat['name'];
                        return InkWell(
                          onTap: () {
                            setSheetState(() => _selectedCategory = cat['name'] as String);
                            setState(() => _selectedCategory = cat['name'] as String);
                          },
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: isSel ? AppTheme.chipBackground : AppTheme.backgroundLight,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSel ? AppTheme.primaryColor : AppTheme.cardBorderColor,
                                width: isSel ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  cat['icon'] as IconData,
                                  size: 20,
                                  color: isSel ? AppTheme.primaryColor : AppTheme.textSecondaryLight,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    cat['name'] as String,
                                    style: AppTheme.sansBody(
                                      fontSize: 12,
                                      fontWeight: isSel ? FontWeight.bold : FontWeight.w500,
                                      color: isSel ? AppTheme.primaryColor : AppTheme.textPrimaryLight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Apply Category', style: AppTheme.sansBody(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSortOptions() {
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
            children: ['Recommended', 'Price: Low to High', 'Rating', 'Popularity'].map((opt) {
              return ListTile(
                title: Text(opt, style: AppTheme.sansBody(fontSize: 14, fontWeight: FontWeight.w600)),
                trailing: _sortBy == opt ? const Icon(Icons.check, color: AppTheme.primaryColor) : null,
                onTap: () {
                  setState(() => _sortBy = opt);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
