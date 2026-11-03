import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class Screen08ExploreVizag extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen08ExploreVizag({super.key, this.onNavigate});

  @override
  State<Screen08ExploreVizag> createState() => _Screen08ExploreVizagState();
}

class _Screen08ExploreVizagState extends State<Screen08ExploreVizag> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final Map<String, bool> _favorites = {};

  final List<Map<String, dynamic>> _destinations = [
    {
      'id': 'rk-beach',
      'name': 'RK Beach',
      'location': 'Visakhapatnam',
      'distance': '0.8 km',
      'category': 'Beaches',
      'rating': 4.8,
      'description': 'A beautiful beach with golden sand',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=350&fm=webp&fit=crop&q=60',
    },
    {
      'id': 'kailasagiri-park',
      'name': 'Kailasagiri',
      'location': 'Visakhapatnam',
      'distance': '6.2 km',
      'category': 'Hills',
      'rating': 4.6,
      'description': 'Panoramic city views & ropeway',
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=350&fm=webp&fit=crop&q=60',
    },
    {
      'id': 'submarine-museum',
      'name': 'INS Kursura Submarine',
      'location': 'Visakhapatnam',
      'distance': '1.2 km',
      'category': 'Museums',
      'rating': 4.5,
      'description': 'A real submarine museum',
      'image': 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=350&fm=webp&fit=crop&q=60',
    },
    {
      'id': 'araku-valley',
      'name': 'Araku Valley',
      'location': 'Andhra Pradesh',
      'distance': '88 km',
      'category': 'Hills',
      'rating': 4.7,
      'description': 'Nature, coffee plantations',
      'image': 'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=350&fm=webp&fit=crop&q=60',
    },
    {
      'id': 'borra-caves',
      'name': 'Borra Caves',
      'location': 'Araku, Visakhapatnam',
      'distance': '90 km',
      'category': 'Hills',
      'rating': 4.9,
      'description': 'Million-year-old limestone caves',
      'image': 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=350&fm=webp&fit=crop&q=60',
    },
    {
      'id': 'katiki-falls',
      'name': 'Katiki Waterfalls',
      'location': 'Near Borra Caves',
      'distance': '94 km',
      'category': 'Waterfalls',
      'rating': 4.8,
      'description': 'Scenic mountain cascade waterfalls',
      'image': 'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=350&fm=webp&fit=crop&q=60',
    },
    {
      'id': 'simhachalam-temple',
      'name': 'Simhachalam Temple',
      'location': 'Visakhapatnam',
      'distance': '18 km',
      'category': 'Temples',
      'rating': 4.9,
      'description': 'Historic hilltop Lord Narasimha shrine',
      'image': 'https://images.unsplash.com/photo-1561361513-2d000a50f0dc?w=350&fm=webp&fit=crop&q=60',
    },
    {
      'id': 'rushikonda-beach',
      'name': 'Rushikonda Beach',
      'location': 'Visakhapatnam',
      'distance': '12 km',
      'category': 'Beaches',
      'rating': 4.8,
      'description': 'Blue Flag certified surfing beach',
      'image': 'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=350&fm=webp&fit=crop&q=60',
    },
  ];

  final List<String> _categories = ['All', 'Beaches', 'Temples', 'Hills', 'Museums', 'Waterfalls'];

  @override
  Widget build(BuildContext context) {
    final filtered = _destinations.where((d) {
      final matchesCat = _selectedCategory == 'All' || d['category'] == _selectedCategory;
      final matchesQuery = _searchQuery.isEmpty ||
          d['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          d['location'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          d['distance'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          d['description'].toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCat && matchesQuery;
    }).toList();

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
          'Explore Places',
          style: TextStyle(color: Color(0xFF0F2942), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location_rounded, color: Color(0xFFFF8C00)),
            onPressed: () => widget.onNavigate?.call('12-live-tracking'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF8C00).withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded, color: Color(0xFFFF8C00), size: 22),
                    hintText: 'Search places...',
                    hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  style: const TextStyle(fontSize: 13, color: Color(0xFF0F2942)),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Category Chips (Horizontal Scroll)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: _categories.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFFF8C00) : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected ? const Color(0xFFFF8C00) : const Color(0xFFE2E8F0),
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(0xFFFF8C00).withValues(alpha: 0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          color: isSelected ? Colors.white : const Color(0xFF475569),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Places List View
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.search_off_rounded, size: 48, color: Colors.grey),
                          SizedBox(height: 8),
                          Text('No places found', style: TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      physics: const BouncingScrollPhysics(),
                      itemCount: filtered.length,
                      itemBuilder: (context, idx) {
                        final dest = filtered[idx];
                        final isFav = _favorites[dest['id']] ?? false;

                        return GestureDetector(
                          onTap: () => widget.onNavigate?.call('09-place-details'),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFF8C00).withValues(alpha: 0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Place Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.network(
                                    dest['image'],
                                    width: 86,
                                    height: 86,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 14),

                                // Info Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              dest['name'],
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
                                                _favorites[dest['id']] = !isFav;
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
                                      const SizedBox(height: 2),
                                      Text(
                                        dest['location'],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF64748B),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.star_rounded, size: 16, color: Colors.amber),
                                          const SizedBox(width: 3),
                                          Text(
                                            '${dest['rating']}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF0F2942),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFF8C00).withValues(alpha: 0.08),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(Icons.near_me_rounded, size: 11, color: Color(0xFFFF8C00)),
                                                const SizedBox(width: 3),
                                                Text(
                                                  dest['distance'],
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFFFF8C00),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        dest['description'],
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFF94A3B8),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
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
      bottomNavigationBar: SharedBottomNav(activeTab: 'explore', onNavigate: widget.onNavigate),
    );
  }
}
