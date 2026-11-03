import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class Screen15Gamification extends StatelessWidget {
  final Function(String)? onNavigate;

  const Screen15Gamification({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF191C1E)),
          onPressed: () => onNavigate?.call('back'),
        ),
        title: const Text(
          'Gamification & Rewards',
          style: TextStyle(color: Color(0xFF191C1E), fontWeight: FontWeight.bold, fontSize: 17),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Color(0xFF191C1E)),
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
              // Level & Coins Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF15A24).withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.workspace_premium, color: Color(0xFFF15A24), size: 24),
                            ),
                            const SizedBox(width: 10),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Level 4 Explorer',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                Text(
                                  'Araku Adventurer',
                                  style: TextStyle(color: Colors.white70, fontSize: 11),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.monetization_on, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text(
                                '1,450 Coins',
                                style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Progress to Level 5', style: TextStyle(color: Colors.white70, fontSize: 11)),
                            Text('750 / 1000 XP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const LinearProgressIndicator(
                            value: 0.75,
                            minHeight: 8,
                            backgroundColor: Colors.white12,
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF15A24)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Earned Badges Shelf Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.military_tech, color: Colors.amber, size: 20),
                      SizedBox(width: 6),
                      Text('Earned Badges', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF191C1E))),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('View All (35)', style: TextStyle(color: Color(0xFFF15A24), fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Badges Horizontal List
              SizedBox(
                height: 105,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildBadgeItem('Beach Pro', 'Coastal verified', Icons.waves, Colors.blue),
                    _buildBadgeItem('Dancing', 'Cultural streak', Icons.nightlife, Colors.pink),
                    _buildBadgeItem('Safe Scout', '100% Safety', Icons.verified_user, Colors.green),
                    _buildBadgeItem('Foodie', 'Andhra seafood', Icons.restaurant, Colors.orange),
                    _buildBadgeItem('Explorer', 'Vizag Master', Icons.explore, Colors.purple),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Unlocked Rewards Ticket Voucher Section
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.redeem, color: Colors.amber, size: 20),
                      SizedBox(width: 6),
                      Text('Unlocked Rewards', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF191C1E))),
                    ],
                  ),
                  Text('1 Available', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),

              const SizedBox(height: 10),

              // Voucher Ticket Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.amber.shade300, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.shade50,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.amber.shade300),
                                  ),
                                  child: const Text(
                                    'LIMITED VOUCHER',
                                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.amber),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Claim 15% Off Araku Tour',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Guided Coffee Plantation & Borra Caves Walk',
                                  style: TextStyle(fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [Colors.amber, Colors.orange]),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Column(
                              children: [
                                Text('15%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
                                Text('OFF', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 9)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1, color: Colors.black12),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.monetization_on, size: 16, color: Colors.amber),
                              SizedBox(width: 4),
                              Text('Unlock with 150 Coins', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.timer_outlined, size: 14, color: Colors.grey.shade600),
                              const SizedBox(width: 3),
                              Text('Valid 7 Days', style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF15A24),
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            elevation: 2,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Redeem Reward', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              SizedBox(width: 6),
                              Icon(Icons.arrow_forward, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SharedBottomNav(activeTab: 'profile', onNavigate: onNavigate),
    );
  }

  Widget _buildBadgeItem(String title, String subtitle, IconData icon, MaterialColor color) {
    return Container(
      width: 95,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.shade50,
            child: Icon(icon, size: 20, color: color.shade700),
          ),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF191C1E)), maxLines: 1),
          Text(subtitle, style: const TextStyle(fontSize: 9, color: Colors.grey), maxLines: 1),
        ],
      ),
    );
  }
}
