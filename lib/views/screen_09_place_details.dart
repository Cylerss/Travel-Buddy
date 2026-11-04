import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';

class Screen09PlaceDetails extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen09PlaceDetails({super.key, this.onNavigate});

  @override
  State<Screen09PlaceDetails> createState() => _Screen09PlaceDetailsState();
}

class _Screen09PlaceDetailsState extends State<Screen09PlaceDetails> {
  bool isLiked = true;
  bool isSaved = false;
  bool isAddedToTrip = false;
  int likeCount = 2420;
  String selectedTag = 'Beach';

  final List<String> tags = ['Beach', 'Water Sports', 'Adventure'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Fullscreen Hero Image
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=1080&fm=webp&fit=crop&q=80',
              fit: BoxFit.cover,
            ),
          ),

          // Gradient overlay for legibility
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0x99000000),
                    Colors.transparent,
                    Color(0x33000000),
                    Color(0xCC000000),
                    Color(0xF0140D0A),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.15, 0.5, 0.75, 1.0],
                ),
              ),
            ),
          ),

          // Top Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCircleButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => widget.onNavigate?.call('07-home'),
                  ),
                  Text(
                    'Travel Buddy',
                    style: AppTheme.serifTitle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  _buildCircleButton(
                    icon: Icons.more_horiz_rounded,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // Right Floating Action Rail
          Positioned(
            right: 16,
            bottom: 220,
            child: Column(
              children: [
                _buildFloatingAction(
                  icon: isAddedToTrip ? Icons.check_circle_rounded : Icons.add_circle_outline_rounded,
                  color: isAddedToTrip ? AppTheme.successGreen : Colors.white,
                  label: isAddedToTrip ? 'Added' : 'Add to Trip',
                  onTap: () {
                    setState(() => isAddedToTrip = !isAddedToTrip);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isAddedToTrip ? 'Added to your Vizag Trip!' : 'Removed from Trip'),
                        duration: const Duration(seconds: 1),
                        backgroundColor: AppTheme.primaryColor,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildFloatingAction(
                  icon: isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: isLiked ? const Color(0xFFFF4D4F) : Colors.white,
                  label: '${(likeCount / 1000).toStringAsFixed(1)}K',
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked;
                      if (isLiked) {
                        likeCount++;
                      } else {
                        likeCount--;
                      }
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildFloatingAction(
                  icon: isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                  color: isSaved ? AppTheme.accentGold : Colors.white,
                  label: 'Save',
                  onTap: () {
                    setState(() => isSaved = !isSaved);
                  },
                ),
                const SizedBox(height: 16),
                _buildFloatingAction(
                  icon: Icons.share_rounded,
                  color: Colors.white,
                  label: 'Share',
                  onTap: () {},
                ),
              ],
            ),
          ),

          // Bottom Detail Card
          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded, color: AppTheme.primaryLight, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Visakhapatnam, Andhra Pradesh',
                      style: AppTheme.sansBody(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Rushikonda Beach',
                  style: AppTheme.serifTitle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Golden sands, clear waters and thrilling water sports make Rushikonda a must experience in Vizag.',
                  style: AppTheme.sansBody(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.85),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),

                // Tags Row
                Row(
                  children: tags.map((t) {
                    final isSel = selectedTag == t;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () => setState(() => selectedTag = t),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSel ? AppTheme.primaryColor : const Color(0x662A201C),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSel ? AppTheme.primaryColor : Colors.white.withValues(alpha: 0.25),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            t,
                            style: AppTheme.sansBody(
                              fontSize: 12,
                              fontWeight: isSel ? FontWeight.bold : FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Booking / Find Buddy Action Button
                InkWell(
                  onTap: () => widget.onNavigate?.call('10-find-buddy'),
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withValues(alpha: 0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.people_alt_rounded, color: Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Find a Local Buddy for Rushikonda',
                          style: AppTheme.sansBody(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
        ],
      ),
      bottomNavigationBar: SharedBottomNav(
        activeTab: 'home',
        onNavigate: widget.onNavigate,
      ),
    );
  }

  Widget _buildCircleButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.45),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _buildFloatingAction({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: AppTheme.sansBody(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
