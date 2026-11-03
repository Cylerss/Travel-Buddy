import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class Screen14LocalExperiences extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen14LocalExperiences({super.key, this.onNavigate});

  @override
  State<Screen14LocalExperiences> createState() => _Screen14LocalExperiencesState();
}

class _Screen14LocalExperiencesState extends State<Screen14LocalExperiences> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Culinary',
    'Trekking',
    'Heritage',
    'Beach Craft',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF191C1E)),
          onPressed: () => widget.onNavigate?.call('back'),
        ),
        title: const Text(
          'Local Experiences Showcase',
          style: TextStyle(color: Color(0xFF191C1E), fontWeight: FontWeight.bold, fontSize: 17),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Color(0xFF191C1E)),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Filter Pills
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: SizedBox(
                  height: 38,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final cat = _categories[index];
                      final isSelected = cat == _selectedCategory;
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(cat),
                          selected: isSelected,
                          selectedColor: const Color(0xFFF15A24),
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF5A4139),
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            fontSize: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected ? Colors.transparent : Colors.grey.shade300,
                            ),
                          ),
                          onSelected: (val) {
                            setState(() {
                              _selectedCategory = cat;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Experience Cards List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildStitchExperienceCard(
                      title: 'Old Town Visakhapatnam Culinary Heritage Walk',
                      category: 'Culinary & Heritage',
                      categoryIcon: Icons.restaurant,
                      image: 'https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?w=400&fm=webp&fit=crop&q=60',
                      price: '₹850',
                      rating: '4.9',
                      reviewsCount: '128',
                      duration: '3 Hours',
                      perks: 'Street Food Tasting',
                      perksIcon: Icons.restaurant_menu,
                      hostName: 'Rajesh Varma',
                      hostAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=120&fm=webp&fit=crop&q=60',
                      hostTitle: 'Verified Culinary Host',
                      desc: 'Authentic local street food walk visiting 7 historic food stops along One-Town Market & Beach Road.',
                      onTap: () => widget.onNavigate?.call('11-buddy-profile'),
                    ),
                    const SizedBox(height: 16),
                    _buildStitchExperienceCard(
                      title: 'Araku Valley Organic Coffee Estate & Caves Exploration',
                      category: 'Coffee & Nature',
                      categoryIcon: Icons.landscape,
                      image: 'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=400&fm=webp&fit=crop&q=60',
                      price: '₹2,400',
                      rating: '5.0',
                      reviewsCount: '94',
                      duration: 'Full Day Trip',
                      perks: 'Tasting Included',
                      perksIcon: Icons.local_cafe,
                      hostName: 'Ananya Rao',
                      hostAvatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=120&fm=webp&fit=crop&q=60',
                      hostTitle: 'Certified Agronomist',
                      desc: 'Organic plantation brewing, artisanal bean roasting masterclass & million-year-old Borra Caves exploration.',
                      onTap: () => widget.onNavigate?.call('11-buddy-profile'),
                    ),
                    const SizedBox(height: 16),
                    _buildStitchExperienceCard(
                      title: 'Dawn Fishermen Boat Voyage on RK Beach',
                      category: 'Coastal & Marine',
                      categoryIcon: Icons.sailing,
                      image: 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=400&fm=webp&fit=crop&q=60',
                      price: '₹1,200',
                      rating: '4.9',
                      reviewsCount: '64',
                      duration: '3 Hours',
                      perks: 'Life Jackets & Safety',
                      perksIcon: Icons.security,
                      hostName: 'Karthik Naidu',
                      hostAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=120&fm=webp&fit=crop&q=60',
                      hostTitle: 'Verified Local Host',
                      desc: 'Sunrise catch voyage into the Bay of Bengal followed by fresh fish barbecue and beachside filter tea on RK Beach.',
                      onTap: () => widget.onNavigate?.call('11-buddy-profile'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SharedBottomNav(activeTab: 'explore', onNavigate: widget.onNavigate),
    );
  }

  Widget _buildStitchExperienceCard({
    required String title,
    required String category,
    required IconData categoryIcon,
    required String image,
    required String price,
    required String rating,
    required String reviewsCount,
    required String duration,
    required String perks,
    required IconData perksIcon,
    required String hostName,
    required String hostAvatar,
    required String hostTitle,
    required String desc,
    required VoidCallback onTap,
  }) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Image & Floating Details Scrim
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Container(
                  height: 175,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.landscape, size: 48, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              // Gradient Scrim
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.2),
                          Colors.black.withValues(alpha: 0.75),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Top Category Chip
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(categoryIcon, size: 14, color: const Color(0xFFF15A24)),
                      const SizedBox(width: 4),
                      Text(
                        category,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF15A24),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Top Right Bookmark
              Positioned(
                top: 12,
                right: 12,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white.withValues(alpha: 0.85),
                  child: const Icon(Icons.bookmark_outline, size: 18, color: Colors.black87),
                ),
              ),
              // Bottom Rating & Title Scrim Overlay
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star, size: 14, color: Colors.amber),
                              const SizedBox(width: 3),
                              Text(
                                rating,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '($reviewsCount reviews)',
                                style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 10),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('From', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 10)),
                        Text(
                          price,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Card Body Content
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Host row & Duration
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(hostAvatar),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  hostName,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF191C1E)),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.verified, size: 14, color: Color(0xFF10B981)),
                              ],
                            ),
                            Text(
                              hostTitle,
                              style: const TextStyle(fontSize: 10, color: Color(0xFF10B981), fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F4F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.schedule, size: 13, color: Color(0xFF565E74)),
                          const SizedBox(width: 4),
                          Text(
                            duration,
                            style: const TextStyle(fontSize: 11, color: Color(0xFF565E74), fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                Text(
                  desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF5A4139), height: 1.3),
                ),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(perksIcon, size: 15, color: const Color(0xFF10B981)),
                        const SizedBox(width: 4),
                        Text(
                          perks,
                          style: const TextStyle(fontSize: 11, color: Color(0xFF565E74), fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF15A24),
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        elevation: 0,
                      ),
                      child: const Row(
                        children: [
                          Text('Book Experience', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, size: 14),
                        ],
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
}
