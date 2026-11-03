import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class Screen07Home extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen07Home({super.key, this.onNavigate});

  @override
  State<Screen07Home> createState() => _Screen07HomeState();
}

class _Screen07HomeState extends State<Screen07Home> {
  String selectedCity = 'Visakhapatnam';
  String selectedCategory = 'All';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final Map<String, bool> _favorites = {};

  late PageController _spotlightPageController;
  Timer? _spotlightTimer;
  int _currentSpotlightIndex = 0;

  final List<Map<String, dynamic>> categoryItems = [
    {
      'id': 'All',
      'label': 'All',
      'asset': 'assets/images/categories/cat_all_icon.png',
    },
    {
      'id': 'Food',
      'label': 'Food & Music',
      'asset': 'assets/images/categories/cat_food_music_icon.png',
    },
    {
      'id': 'Places',
      'label': 'Arts & Spots',
      'asset': 'assets/images/categories/cat_arts_spots_icon.png',
    },
    {
      'id': 'Activities',
      'label': 'Sports',
      'asset': 'assets/images/categories/cat_sports_icon.png',
    },
    {
      'id': 'Activities',
      'label': 'Adventure',
      'asset': 'assets/images/categories/cat_adventure_icon.png',
    },
    {
      'id': 'Events',
      'label': 'Open Mic',
      'asset': 'assets/images/categories/cat_open_mic_icon.png',
    },
    {
      'id': 'Events',
      'label': 'Music',
      'asset': 'assets/images/categories/cat_music_icon.png',
    },
    {
      'id': 'Places',
      'label': 'Beaches',
      'asset': 'assets/images/categories/cat_beaches_icon.png',
    },
  ];

  final List<Map<String, String>> spotlightSlides = [
    {
      'title': 'RK Beach Promenade',
      'subtitle': 'Submarine Museum, Sunrise & Coastline Walks',
      'category': 'BEACH & HERITAGE',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&fm=webp&fit=crop&q=80',
      'target': '09-place-details',
    },
    {
      'title': 'Rushikonda Blue Flag Beach',
      'subtitle': 'Surfing, Water Sports & Speedboats',
      'category': 'ADVENTURE & WATER SPORTS',
      'image': 'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800&fm=webp&fit=crop&q=80',
      'target': '08-explore-vizag',
    },
    {
      'title': 'Araku Valley Coffee Plantations',
      'subtitle': 'Scenic Hill Stations, Borra Caves & Waterfalls',
      'category': 'HILL STATION & TREKKING',
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800&fm=webp&fit=crop&q=80',
      'target': '14-local-experiences',
    },
    {
      'title': 'Kailasagiri Hilltop Ropeway',
      'subtitle': '360° Panoramic Bay View & Giant Statues',
      'category': 'PANORAMIC VIEWS',
      'image': 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=800&fm=webp&fit=crop&q=80',
      'target': '09-place-details',
    },
  ];

  final List<Map<String, dynamic>> citiesList = [
    {'name': 'Visakhapatnam', 'meta': '42 places & spots to explore'},
    {'name': 'Hyderabad', 'meta': '85 places & spots to explore'},
    {'name': 'Vijayawada', 'meta': '30 places & spots to explore'},
    {'name': 'Valparai', 'meta': '12 places & spots to explore'},
  ];

  final List<Map<String, dynamic>> _allContentCards = [
    // Food
    {
      'id': 'sea-deck',
      'name': 'Sea Deck Coastal Dining',
      'type': 'Food',
      'subType': 'Seafood • Coastal Andhra',
      'rating': 4.8,
      'reviews': 1420,
      'location': 'Beach Road, RK Beach',
      'distance': '0.6 km',
      'extraInfo': 'Coastal Dining & Ocean Views',
      'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&fm=webp&fit=crop&q=80',
      'target': '14-local-experiences',
    },
    {
      'id': 'kamat-restaurant',
      'name': 'Kamat Andhra Tiffins & Meals',
      'type': 'Food',
      'subType': 'South Indian • Thali',
      'rating': 4.7,
      'reviews': 1890,
      'location': 'Siripuram, Vizag',
      'distance': '1.2 km',
      'extraInfo': 'Authentic South Indian Thali',
      'image': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=400&fm=webp&fit=crop&q=80',
      'target': '14-local-experiences',
    },
    {
      'id': 'dakshin-diner',
      'name': 'Dakshin Spice Biryani House',
      'type': 'Food',
      'subType': 'Biryani • Hyderabadi',
      'rating': 4.9,
      'reviews': 2150,
      'location': 'MVP Colony, Vizag',
      'distance': '2.4 km',
      'extraInfo': 'Hyderabadi Dum Biryani',
      'image': 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=400&fm=webp&fit=crop&q=80',
      'target': '14-local-experiences',
    },

    // Places
    {
      'id': 'rk-beach',
      'name': 'RK Beach (Ramakrishna Beach)',
      'type': 'Places',
      'subType': 'Beach & Promenade',
      'rating': 4.8,
      'reviews': 3420,
      'location': 'Visakhapatnam',
      'distance': '0.8 km',
      'extraInfo': 'A beautiful beach with golden sand',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400&fm=webp&fit=crop&q=80',
      'target': '09-place-details',
    },
    {
      'id': 'kailasagiri-park',
      'name': 'Kailasagiri Hilltop Park',
      'type': 'Places',
      'subType': 'Panoramic Views & Ropeway',
      'rating': 4.6,
      'reviews': 1950,
      'location': 'Visakhapatnam',
      'distance': '6.2 km',
      'extraInfo': 'Panoramic city views & toy train',
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=400&fm=webp&fit=crop&q=80',
      'target': '09-place-details',
    },
    {
      'id': 'submarine-museum',
      'name': 'INS Kursura Submarine Museum',
      'type': 'Places',
      'subType': 'Museums & Defense',
      'rating': 4.5,
      'reviews': 1280,
      'location': 'Visakhapatnam',
      'distance': '1.2 km',
      'extraInfo': 'A real submarine museum on the beach',
      'image': 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=400&fm=webp&fit=crop&q=80',
      'target': '09-place-details',
    },

    // Activities
    {
      'id': 'rushikonda-surfing',
      'name': 'Rushikonda Surfing & Water Sports',
      'type': 'Activities',
      'subType': 'Surfing • Speed Boating',
      'rating': 4.8,
      'reviews': 1180,
      'location': 'Rushikonda Beach, Vizag',
      'distance': '12 km',
      'extraInfo': 'Blue Flag certified water adventures',
      'image': 'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=400&fm=webp&fit=crop&q=80',
      'target': '08-explore-vizag',
    },
    {
      'id': 'araku-coffee-tour',
      'name': 'Araku Valley Plantation Trek',
      'type': 'Activities',
      'subType': 'Coffee Tasting • Hiking',
      'rating': 4.9,
      'reviews': 940,
      'location': 'Araku Valley, AP',
      'distance': '88 km',
      'extraInfo': 'Guided organic coffee trail & caves',
      'image': 'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400&fm=webp&fit=crop&q=80',
      'target': '14-local-experiences',
    },

    // Events
    {
      'id': 'sunset-jam',
      'name': 'Vizag Sunset Beach Jam',
      'type': 'Events',
      'subType': 'Live Music Event • Today 6:30 PM',
      'rating': 4.8,
      'reviews': 320,
      'location': 'RK Beach Lawns',
      'distance': '0.8 km',
      'extraInfo': 'Local acoustic bands & live music',
      'image': 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=400&fm=webp&fit=crop&q=80',
      'target': '14-local-experiences',
    },
    {
      'id': 'dhimsa-dance-night',
      'name': 'Traditional Dhimsa Folk Evening',
      'type': 'Events',
      'subType': 'Cultural Performance • Tomorrow 5:00 PM',
      'rating': 5.0,
      'reviews': 240,
      'location': 'Kailasagiri Open Stage',
      'distance': '6.2 km',
      'extraInfo': 'Authentic tribal folk dance performance',
      'image': 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=400&fm=webp&fit=crop&q=80',
      'target': '14-local-experiences',
    },
  ];

  @override
  void initState() {
    super.initState();
    _spotlightPageController = PageController(initialPage: 0);
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _spotlightTimer?.cancel();
    _spotlightTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_spotlightPageController.hasClients) {
        final nextIndex = (_currentSpotlightIndex + 1) % spotlightSlides.length;
        _spotlightPageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _spotlightTimer?.cancel();
    _spotlightPageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showLocationBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your location',
                style: TextStyle(
                  color: Color(0xFF0F2942),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF7ED),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.my_location, color: Color(0xFFFF8C00), size: 20),
                ),
                title: const Text('Use my location', style: TextStyle(color: Color(0xFF0F2942), fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: const Text('Find spots & experiences near you', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                onTap: () {
                  setState(() => selectedCity = 'Visakhapatnam');
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.grey.shade200, height: 24),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF7ED),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.location_city_outlined, color: Color(0xFFFF8C00), size: 20),
                ),
                title: const Text('Choose a city', style: TextStyle(color: Color(0xFF0F2942), fontWeight: FontWeight.bold, fontSize: 14)),
                onTap: () {
                  Navigator.pop(context);
                  _showChooseCityScreen();
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _showChooseCityScreen() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return FractionallySizedBox(
              heightFactor: 0.9,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2942)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: const Text('Choose city', style: TextStyle(color: Color(0xFF0F2942), fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, color: Color(0xFF64748B), size: 20),
                            hintText: 'Search city',
                            hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Popular Cities',
                        style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 14),
                      Expanded(
                        child: ListView.builder(
                          itemCount: citiesList.length,
                          itemBuilder: (context, index) {
                            final city = citiesList[index];
                            final isSelected = selectedCity == city['name'];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCity = city['name'];
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isSelected ? const Color(0xFFFF8C00) : const Color(0xFFE2E8F0),
                                    width: isSelected ? 2 : 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.02),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFF7ED),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(Icons.location_on, color: Color(0xFFFF8C00), size: 18),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            city['name'],
                                            style: const TextStyle(color: Color(0xFF0F2942), fontWeight: FontWeight.bold, fontSize: 15),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            city['meta'],
                                            style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
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
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter Content Cards dynamically
    final filteredContent = _allContentCards.where((item) {
      final matchesCategory = selectedCategory == 'All' || item['type'] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          item['name'].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item['subType'].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item['location'].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar: Location Selector & Profile Quick Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _showLocationBottomSheet,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF7ED),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(Icons.location_on, color: Color(0xFFFF8C00), size: 22),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Your location',
                                    style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          selectedCity,
                                          style: const TextStyle(color: Color(0xFF0F2942), fontSize: 15, fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(Icons.keyboard_arrow_down, color: Color(0xFF0F2942), size: 18),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Top Action Icons
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => widget.onNavigate?.call('16-profile-dashboard'),
                          child: Stack(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(Icons.notifications_none_rounded, color: Color(0xFF0F2942), size: 20),
                              ),
                              Positioned(
                                right: 6,
                                top: 6,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(color: Color(0xFFFF8C00), shape: BoxShape.circle),
                                  child: const Text('1', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),

                        GestureDetector(
                          onTap: () => widget.onNavigate?.call('16-profile-dashboard'),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF7ED),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFFFF8C00).withValues(alpha: 0.3)),
                            ),
                            child: const Icon(Icons.person_rounded, color: Color(0xFFFF8C00), size: 22),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // REQUIREMENT 1: Prominent Search Bar (Map Removed) with Clear (X) Button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      setState(() {
                        searchQuery = val;
                      });
                    },
                    style: const TextStyle(fontSize: 14, color: Color(0xFF0F2942), fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFFFF8C00), size: 22),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, color: Color(0xFF64748B), size: 18),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  searchQuery = '';
                                });
                              },
                            )
                          : null,
                      hintText: 'Search places, restaurants, activities…',
                      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // Auto-Sliding Spotlight Banner Section
                _buildAutoSlidingSpotlight(),
                const SizedBox(height: 20),

                // 3D Claymation Squircle Category Selector Row (Inspired by Reference Design)
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryItems.length,
                    itemBuilder: (context, index) {
                      final cat = categoryItems[index];
                      final isSelected = selectedCategory == cat['id'];
                      return Padding(
                        padding: const EdgeInsets.only(right: 14.0),
                        child: _build3DCategoryCard(cat, isSelected),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 18),

                // Section Header based on Selected Category
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCategory == 'All' ? 'Explore Vizag Spots' : selectedCategory,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F2942),
                        letterSpacing: -0.4,
                      ),
                    ),
                    Text(
                      '${filteredContent.length} found',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Content Cards List filtered by Category & Search Query
                filteredContent.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 36.0),
                          child: Column(
                            children: const [
                              Icon(Icons.search_off_rounded, size: 44, color: Color(0xFF94A3B8)),
                              SizedBox(height: 8),
                              Text('No matching results found', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredContent.length,
                        itemBuilder: (context, index) {
                          final item = filteredContent[index];
                          return _buildUniversalContentCard(item);
                        },
                      ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SharedBottomNav(activeTab: 'home', onNavigate: widget.onNavigate),
    );
  }

  // Auto-Sliding Spotlight Banner Widget
  Widget _buildAutoSlidingSpotlight() {
    return Column(
      children: [
        Container(
          height: 185,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: PageView.builder(
              controller: _spotlightPageController,
              onPageChanged: (index) {
                setState(() {
                  _currentSpotlightIndex = index;
                });
              },
              itemCount: spotlightSlides.length,
              itemBuilder: (context, index) {
                final slide = spotlightSlides[index];
                return GestureDetector(
                  onTap: () => widget.onNavigate?.call(slide['target']!),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          slide['image']!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: const Color(0xFFFF8C00),
                            child: const Icon(Icons.landscape, color: Colors.white, size: 40),
                          ),
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
                                Colors.black.withValues(alpha: 0.8),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF8C00),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                slide['category']!,
                                style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              slide['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              slide['subtitle']!,
                              style: const TextStyle(color: Colors.white70, fontSize: 11),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(spotlightSlides.length, (index) {
            final isCurrent = index == _currentSpotlightIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isCurrent ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: isCurrent ? const Color(0xFFFF8C00) : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }

  // Universal Responsive Card Widget matching all categories (Food, Places, Activities, Events)
  Widget _buildUniversalContentCard(Map<String, dynamic> item) {
    final isFav = _favorites[item['id']] ?? false;

    return GestureDetector(
      onTap: () => widget.onNavigate?.call(item['target'] as String),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Image
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                item['image'] as String,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 90,
                  height: 90,
                  color: const Color(0xFFFFF7ED),
                  child: const Icon(Icons.image, color: Color(0xFFFF8C00), size: 36),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Content Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item['name'] as String,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F2942),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _favorites[item['id'] as String] = !isFav;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            size: 20,
                            color: const Color(0xFFFF8C00),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),

                  // SubType Tag
                  Text(
                    item['subType'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFF8C00),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Rating & Reviews
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, size: 16, color: Colors.amber),
                      const SizedBox(width: 3),
                      Text(
                        '${item['rating']}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F2942),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${item['reviews']} reviews)',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Location & Distance / Extra Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, size: 13, color: Color(0xFFFF8C00)),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                '${item['distance']} • ${item['location']}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF64748B),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          item['extraInfo'] as String,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F2942),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
  }

  Widget _build3DCategoryCard(Map<String, dynamic> cat, bool isSelected) {
    final assetPath = cat['asset'] as String;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = cat['id'] as String;
        });
      },
      child: SizedBox(
        width: 78,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: isSelected
                    ? Border.all(color: const Color(0xFFFF8C00), width: 2.5)
                    : Border.all(color: Colors.transparent, width: 2.5),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFFFF8C00).withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : null,
              ),
              child: Image.asset(
                assetPath,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              cat['label'] as String,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? const Color(0xFFFF8C00) : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
