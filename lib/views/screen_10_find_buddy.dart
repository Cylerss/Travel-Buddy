import 'package:flutter/material.dart';
import '../services/vizag_data.dart';
import '../widgets/bottom_nav.dart';
import '../models/vizag_models.dart';

class Screen10FindBuddy extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen10FindBuddy({super.key, this.onNavigate});

  @override
  State<Screen10FindBuddy> createState() => _Screen10FindBuddyState();
}

class _Screen10FindBuddyState extends State<Screen10FindBuddy> {
  String selectedCategory = 'All';
  String selectedLocation = 'Visakhapatnam, Andhra Pradesh';

  final List<String> categories = ['All', 'Guides', 'Food', 'Culture', 'Adventure', 'Trekking'];

  final List<String> locations = [
    'Visakhapatnam, Andhra Pradesh',
    'RK Beach, Vizag',
    'Rushikonda, Vizag',
    'Araku Valley, AP',
    'Bheemili Coast, Vizag',
  ];

  @override
  Widget build(BuildContext context) {
    final allBuddies = VizagDataService.buddies;

    final filteredBuddies = selectedCategory == 'All'
        ? allBuddies
        : allBuddies.where((b) {
            return b.category.toLowerCase() == selectedCategory.toLowerCase() ||
                b.tags.any((t) => t.toLowerCase().contains(selectedCategory.toLowerCase())) ||
                b.skills.any((s) => s.toLowerCase().contains(selectedCategory.toLowerCase()));
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
          'Local Buddies',
          style: TextStyle(color: Color(0xFF0F2942), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.center_focus_strong_outlined, color: Color(0xFFFF8C00)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Scanning for nearby local buddies...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const SizedBox(height: 14),

            // Location Selector Pill Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: PopupMenuButton<String>(
                onSelected: (loc) {
                  setState(() {
                    selectedLocation = loc;
                  });
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                itemBuilder: (context) => locations
                    .map((loc) => PopupMenuItem(
                          value: loc,
                          child: Text(loc, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        ))
                    .toList(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFFDBEAFE)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFFFF8C00), size: 18),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          selectedLocation,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFFF8C00),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.keyboard_arrow_down, color: Color(0xFFFF8C00), size: 18),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Horizontal Category Chips
            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = selectedCategory == cat;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = cat;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFFF8C00) : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFFFF8C00).withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected ? Colors.white : const Color(0xFF475569),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Vertical List of Buddies
            Expanded(
              child: filteredBuddies.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off_rounded, size: 48, color: Colors.grey.shade400),
                          const SizedBox(height: 8),
                          Text('No buddies found in "$selectedCategory"', style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      itemCount: filteredBuddies.length,
                      itemBuilder: (context, index) {
                        final buddy = filteredBuddies[index];
                        return _buildBuddyCard(buddy);
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SharedBottomNav(activeTab: 'buddies', onNavigate: widget.onNavigate),
    );
  }

  Widget _buildBuddyCard(BuddyData buddy) {
    return GestureDetector(
      onTap: () => widget.onNavigate?.call('11-buddy-profile'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Square Rounded Profile Avatar
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                buddy.avatar,
                width: 84,
                height: 84,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 84,
                    height: 84,
                    color: const Color(0xFFEFF6FF),
                    child: const Icon(Icons.person, color: Color(0xFFFF8C00), size: 36),
                  );
                },
              ),
            ),
            const SizedBox(width: 14),

            // Buddy Info Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row 1: Name & Distance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          buddy.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F2942),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Color(0xFFFF8C00), size: 14),
                          const SizedBox(width: 2),
                          Text(
                            '${buddy.distanceKm} km',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),

                  // Row 2: Specialty / Role
                  Text(
                    buddy.specialty,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Row 3: Rating & Trips
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 16),
                      const SizedBox(width: 3),
                      Text(
                        '${buddy.rating}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F2942),
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '(${buddy.reviewsCount}+ trips)',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Row 4: Tag Chips & Chat Action Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tag Pills
                      Expanded(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: buddy.tags.take(2).map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                tag,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFFF8C00),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      // Chat Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8C00),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () => widget.onNavigate?.call('11-buddy-profile'),
                        child: const Text(
                          'Chat',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
