import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';

class Screen07Home extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen07Home({super.key, this.onNavigate});

  @override
  State<Screen07Home> createState() => _Screen07HomeState();
}

class _Screen07HomeState extends State<Screen07Home> {
  String selectedCity = 'Visakhapatnam';
  String activeCategory = 'Explore';
  int cartItemCount = 1;
  final Set<String> _likedItems = {'rushikonda', 'araku'};

  final List<Map<String, dynamic>> categories = [
    {'id': 'Explore', 'label': 'Explore', 'icon': Icons.explore_rounded},
    {'id': 'Hotels', 'label': 'Hotels', 'icon': Icons.hotel_rounded},
    {'id': 'Transport', 'label': 'Transport', 'icon': Icons.directions_bus_rounded},
    {'id': 'CarRentals', 'label': 'Car Rentals', 'icon': Icons.directions_car_rounded},
    {'id': 'All', 'label': 'All', 'icon': Icons.grid_view_rounded},
  ];

  final List<Map<String, dynamic>> featuredExperiences = [
    {
      'id': 'vizag-getaway',
      'title': 'Visakhapatnam Getaway',
      'subtitle': '2 Days • Beaches • Food • Culture',
      'price': '₹6,999',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600&fm=webp&fit=crop&q=80',
      'target': '14-local-experiences',
    },
    {
      'id': 'araku-escape',
      'title': 'Araku Valley Escape',
      'subtitle': '2 Days • Nature • Waterfalls • Hills',
      'price': '₹4,999',
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=600&fm=webp&fit=crop&q=80',
      'target': '14-local-experiences',
    },
    {
      'id': 'beach-expedition',
      'title': 'Coastal & Heritage Safari',
      'subtitle': '1 Day • Caves • Museums • Sunset',
      'price': '₹2,499',
      'image': 'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=600&fm=webp&fit=crop&q=80',
      'target': '14-local-experiences',
    },
  ];

  final List<Map<String, dynamic>> trendingDestinations = [
    {
      'id': 'rushikonda',
      'name': 'Rushikonda',
      'tag': 'Beach & Surfing',
      'image': 'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=400&fm=webp&fit=crop&q=80',
      'target': '09-place-details',
    },
    {
      'id': 'araku',
      'name': 'Araku Valley',
      'tag': 'Hills & Caves',
      'image': 'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400&fm=webp&fit=crop&q=80',
      'target': '09-place-details',
    },
    {
      'id': 'kailasagiri',
      'name': 'Kailasagiri',
      'tag': 'Hilltop Views',
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=400&fm=webp&fit=crop&q=80',
      'target': '09-place-details',
    },
    {
      'id': 'yarada',
      'name': 'Yarada Beach',
      'tag': 'Golden Sands',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400&fm=webp&fit=crop&q=80',
      'target': '09-place-details',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopSearchBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategoryRow(),
                    const SizedBox(height: 16),
                    _buildHeroBanner(),
                    const SizedBox(height: 24),
                    _buildFeaturedExperiencesSection(),
                    const SizedBox(height: 24),
                    _buildTrendingDestinationsSection(),
                    const SizedBox(height: 24),
                    _buildAiRecommendationCard(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SharedBottomNav(
        activeTab: 'home',
        onNavigate: widget.onNavigate,
      ),
    );
  }

  Widget _buildTopSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
      child: Row(
        children: [
          // Search & Location Pill
          Expanded(
            child: InkWell(
              onTap: () => _showDestinationPicker(),
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppTheme.cardBorderColor, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x0D231815),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded, color: AppTheme.primaryColor, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        selectedCity,
                        style: AppTheme.sansBody(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimaryLight,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded, color: AppTheme.textSecondaryLight, size: 20),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Ask AI Button
          GestureDetector(
            onTap: () => widget.onNavigate?.call('ai-assistant'),
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                  const SizedBox(width: 5),
                  Text(
                    'Ask AI',
                    style: AppTheme.sansBody(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Cart Icon with Badge
          GestureDetector(
            onTap: () => widget.onNavigate?.call('checkout-options'),
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.cardBorderColor, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x0D231815),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.shopping_bag_outlined, color: AppTheme.textPrimaryLight, size: 22),
                  if (cartItemCount > 0)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$cartItemCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: categories.map((cat) {
          final isSelected = activeCategory == cat['id'];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                setState(() => activeCategory = cat['id']);
                if (cat['id'] == 'Explore') {
                  widget.onNavigate?.call('08-explore-vizag');
                }
              },
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected ? AppTheme.primaryColor : AppTheme.cardBorderColor,
                    width: 1,
                  ),
                  boxShadow: [
                    if (isSelected)
                      BoxShadow(
                        color: AppTheme.primaryColor.withValues(alpha: 0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      cat['icon'] as IconData,
                      size: 16,
                      color: isSelected ? Colors.white : AppTheme.textSecondaryLight,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      cat['label'] as String,
                      style: AppTheme.sansBody(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : AppTheme.textPrimaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return GestureDetector(
      onTap: () => widget.onNavigate?.call('09-place-details'),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0x1F231815),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
          image: const DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800&fm=webp&fit=crop&q=80',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [Color(0xCC18100C), Color(0x4018100C), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.0, 0.6, 1.0],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rushikonda Blue Flag Beach',
                style: AppTheme.serifTitle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Surfing, Water Sports & Scenic Views',
                style: AppTheme.sansBody(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: AppTheme.accentGold, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '4.8',
                        style: AppTheme.sansBody(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        ' (2.4K)',
                        style: AppTheme.sansBody(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withValues(alpha: 0.4),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Explore Now',
                          style: AppTheme.sansBody(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedExperiencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Experiences',
              style: AppTheme.serifTitle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () => widget.onNavigate?.call('14-local-experiences'),
              child: Row(
                children: [
                  Text(
                    'See all',
                    style: AppTheme.sansBody(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(Icons.arrow_forward_rounded, color: AppTheme.primaryColor, size: 14),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: featuredExperiences.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final exp = featuredExperiences[index];
              return GestureDetector(
                onTap: () => widget.onNavigate?.call(exp['target']),
                child: Container(
                  width: 220,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.cardBorderColor, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x0D231815),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(19)),
                        child: Image.network(
                          exp['image'],
                          height: 110,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exp['title'],
                              style: AppTheme.sansBody(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              exp['subtitle'],
                              style: AppTheme.sansBody(
                                fontSize: 10.5,
                                color: AppTheme.textSecondaryLight,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'From ',
                                        style: AppTheme.sansBody(
                                          fontSize: 10,
                                          color: AppTheme.textSecondaryLight,
                                        ),
                                      ),
                                      TextSpan(
                                        text: exp['price'],
                                        style: AppTheme.sansBody(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 13,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingDestinationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trending Destinations',
              style: AppTheme.serifTitle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () => widget.onNavigate?.call('08-explore-vizag'),
              child: Row(
                children: [
                  Text(
                    'See all',
                    style: AppTheme.sansBody(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(Icons.arrow_forward_rounded, color: AppTheme.primaryColor, size: 14),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 125,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: trendingDestinations.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = trendingDestinations[index];
              final isLiked = _likedItems.contains(item['id']);
              return GestureDetector(
                onTap: () => widget.onNavigate?.call(item['target']),
                child: Container(
                  width: 105,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    image: DecorationImage(
                      image: NetworkImage(item['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                        colors: [Color(0xCC18100C), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.0, 0.7],
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isLiked) {
                                  _likedItems.remove(item['id']);
                                } else {
                                  _likedItems.add(item['id']);
                                }
                              });
                            },
                            child: Icon(
                              isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              color: isLiked ? Colors.redAccent : Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        Text(
                          item['name'],
                          style: AppTheme.sansBody(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAiRecommendationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppTheme.cardBorderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F231815),
            blurRadius: 10,
            offset: const Offset(0, 3),
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
                  const Icon(Icons.auto_awesome, color: AppTheme.primaryColor, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'AI Recommends For You',
                    style: AppTheme.serifTitle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () => widget.onNavigate?.call('ai-assistant'),
                child: Row(
                  children: [
                    Text(
                      'See all',
                      style: AppTheme.sansBody(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(Icons.arrow_forward_rounded, color: AppTheme.primaryColor, size: 12),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => widget.onNavigate?.call('08-explore-vizag'),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.chipBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.chipBorder, width: 1),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=200&fm=webp&fit=crop&q=80',
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '7-Day Vizag & Araku Explorer',
                          style: AppTheme.sansBody(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _buildPillTag('Beaches'),
                            const SizedBox(width: 4),
                            _buildPillTag('Hills'),
                            const SizedBox(width: 4),
                            _buildPillTag('Culture'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.chipBorder, width: 0.8),
      ),
      child: Text(
        label,
        style: AppTheme.sansBody(
          fontSize: 9.5,
          fontWeight: FontWeight.w600,
          color: AppTheme.textSecondaryLight,
        ),
      ),
    );
  }

  void _showDestinationPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.cardBorderColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Select Destination',
                style: AppTheme.serifTitle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...['Visakhapatnam', 'Araku Valley', 'Vijayawada', 'Hyderabad', 'Puri'].map(
                (city) => ListTile(
                  title: Text(city, style: AppTheme.sansBody(fontSize: 14, fontWeight: FontWeight.w600)),
                  trailing: selectedCity == city
                      ? const Icon(Icons.check_circle_rounded, color: AppTheme.primaryColor)
                      : null,
                  onTap: () {
                    setState(() => selectedCity = city);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
