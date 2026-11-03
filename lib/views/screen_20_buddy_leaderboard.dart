import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class Screen20BuddyLeaderboard extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen20BuddyLeaderboard({super.key, this.onNavigate});

  @override
  State<Screen20BuddyLeaderboard> createState() => _Screen20BuddyLeaderboardState();
}

class _Screen20BuddyLeaderboardState extends State<Screen20BuddyLeaderboard> {
  String _activeTab = 'All Time';

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
          'Buddy Leaderboard & Ratings',
          style: TextStyle(color: Color(0xFF191C1E), fontWeight: FontWeight.bold, fontSize: 17),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Color(0xFF191C1E)),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter Tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ['All Time', 'This Month', 'Safety Champions'].map((tab) {
                  final isSelected = tab == _activeTab;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _activeTab = tab;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFF15A24) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? Colors.transparent : const Color(0xFFE2E8F0)),
                      ),
                      child: Text(
                        tab,
                        style: TextStyle(
                          color: isSelected ? Colors.white : const Color(0xFF565E74),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Leaderboard Top 3 Podium
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    const Text(
                      '🏆 Top Rated Vizag Companions',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // 2nd Place Silver
                        _buildPodiumItem(
                          rank: '2',
                          name: 'Ananya R.',
                          rating: '4.95 ★',
                          avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=120&fm=webp&fit=crop&q=60',
                          badgeColor: Colors.grey.shade400,
                          height: 80,
                        ),
                        // 1st Place Gold (Center & Taller)
                        _buildPodiumItem(
                          rank: '1',
                          name: 'Rajesh V.',
                          rating: '4.98 ★',
                          avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=120&fm=webp&fit=crop&q=60',
                          badgeColor: Colors.amber,
                          height: 105,
                          isGold: true,
                        ),
                        // 3rd Place Bronze
                        _buildPodiumItem(
                          rank: '3',
                          name: 'Karthik N.',
                          rating: '4.91 ★',
                          avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=120&fm=webp&fit=crop&q=60',
                          badgeColor: Colors.orange.shade700,
                          height: 70,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'COMMUNITY RANKINGS',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF8E7067), letterSpacing: 0.5),
              ),
              const SizedBox(height: 12),

              // Ranked List
              _buildLeaderboardRow('1', 'Rajesh Varma', '142 Trips • 4.98 ★', 'Police Verified', 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=120&fm=webp&fit=crop&q=60'),
              _buildLeaderboardRow('2', 'Ananya Rao', '118 Trips • 4.95 ★', 'Coffee Master', 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=120&fm=webp&fit=crop&q=60'),
              _buildLeaderboardRow('3', 'Karthik Naidu', '96 Trips • 4.91 ★', 'Sea & Boat Guide', 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=120&fm=webp&fit=crop&q=60'),
              _buildLeaderboardRow('4', 'Priya Sharma', '84 Trips • 4.89 ★', 'Food Historian', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=120&fm=webp&fit=crop&q=60'),
              _buildLeaderboardRow('5', 'Suresh Kumar', '72 Trips • 4.85 ★', 'Araku Trekker', 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=120&fm=webp&fit=crop&q=60'),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SharedBottomNav(activeTab: 'buddies', onNavigate: widget.onNavigate),
    );
  }

  Widget _buildPodiumItem({
    required String rank,
    required String name,
    required String rating,
    required String avatar,
    required Color badgeColor,
    required double height,
    bool isGold = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            CircleAvatar(
              radius: isGold ? 28 : 22,
              backgroundImage: NetworkImage(avatar),
            ),
            Positioned(
              top: -8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('#$rank', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
        Text(rating, style: TextStyle(color: Colors.amber.shade300, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildLeaderboardRow(String rank, String name, String stats, String tag, String avatar) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text('#$rank', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF565E74))),
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(avatar),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF191C1E))),
                    const SizedBox(width: 4),
                    const Icon(Icons.verified, size: 14, color: Color(0xFF10B981)),
                  ],
                ),
                Text(stats, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(tag, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF565E74))),
          ),
        ],
      ),
    );
  }
}
