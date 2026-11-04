import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';

class ScreenBookingConfirmation extends StatelessWidget {
  final Function(String)? onNavigate;

  const ScreenBookingConfirmation({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => onNavigate?.call('07-home'),
        ),
        title: Text(
          'Booking Confirmation',
          style: AppTheme.serifTitle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {},
          ),
        ],
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
            // Status and ID row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.successLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_rounded, size: 14, color: AppTheme.successGreen),
                      const SizedBox(width: 4),
                      Text(
                        'Confirmed',
                        style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.successGreen),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Booking #TB-98214',
                  style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.textSecondaryLight),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Experience Title
            Text(
              'Nature & Trekking 🌲',
              style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
            ),
            const SizedBox(height: 2),
            Text(
              'Araku Valley & Borra Caves Expedition',
              style: AppTheme.serifTitle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Explore nature, caves and tribal culture with your local buddy',
              style: AppTheme.sansBody(fontSize: 12, color: AppTheme.textSecondaryLight),
            ),
            const SizedBox(height: 16),

            // Verification OTP Box (Orange Highlight)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3EC),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFFD1B8), width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.pin_rounded, color: AppTheme.primaryColor, size: 18),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Trip Verification OTP',
                        style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'START OTP: ',
                        style: AppTheme.sansBody(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textPrimaryLight),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.5)),
                        ),
                        child: Text(
                          '4918',
                          style: AppTheme.serifTitle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Share this 4-digit code with your Buddy at meeting point to verify & start experience.',
                    style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Assigned Local Buddy Card
            Text('Assigned Local Buddy', style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.cardBorderColor),
                boxShadow: const [BoxShadow(color: Color(0x08231815), blurRadius: 8, offset: Offset(0, 2))],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          const CircleAvatar(
                            radius: 26,
                            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&fm=webp&fit=crop&q=80'),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              child: const Icon(Icons.verified_rounded, size: 14, color: Color(0xFF1E88E5)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rajesh Varma', style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold)),
                            Text('Certified Local Guide & Trekker', style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.star_rounded, size: 14, color: AppTheme.accentGold),
                                const SizedBox(width: 2),
                                Text('4.98 • 142 Trips Completed', style: AppTheme.sansBody(fontSize: 10.5, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppTheme.successLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('Available', style: AppTheme.sansBody(fontSize: 9.5, fontWeight: FontWeight.bold, color: AppTheme.successGreen)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildBuddyAction(Icons.call_rounded, 'Call', () {}),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildBuddyAction(Icons.chat_bubble_outline_rounded, 'Chat', () {}),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildBuddyAction(Icons.person_outline_rounded, 'Profile', () {
                          onNavigate?.call('11-buddy-profile');
                        }, isPrimary: true),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Trip Schedule & Locations
            Text('Trip Schedule & Locations', style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.cardBorderColor),
              ),
              child: Column(
                children: [
                  _buildScheduleRow(
                    icon: Icons.calendar_today_rounded,
                    title: 'Tomorrow, 13 Oct 2026 at 07:30 AM',
                    subtitle: 'Full Day (9 Hours)',
                  ),
                  const Divider(height: 20, color: AppTheme.cardBorderColor),
                  _buildScheduleRow(
                    icon: Icons.meeting_room_rounded,
                    title: 'Meeting & Pickup Spot',
                    subtitle: 'Vizag Central Railway Station, Gate 1',
                  ),
                  const Divider(height: 20, color: AppTheme.cardBorderColor),
                  _buildScheduleRow(
                    icon: Icons.place_rounded,
                    title: 'Destination',
                    subtitle: 'Borra Caves & Katiki Waterfalls, Araku',
                    trailing: InkWell(
                      onTap: () => onNavigate?.call('12-live-tracking'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.chipBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'View on Map',
                          style: AppTheme.sansBody(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Package Highlights & Notes
            Text('Package Highlights & Notes', style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.cardBorderColor),
              ),
              child: Column(
                children: [
                  _buildChecklistRow(Icons.check_circle_outline_rounded, 'Custom Araku Valley Tour + Tribal Coffee Tasting'),
                  const SizedBox(height: 8),
                  _buildChecklistRow(Icons.check_circle_outline_rounded, 'Explore scenic valleys, caves and experience local culture'),
                  const SizedBox(height: 8),
                  _buildChecklistRow(Icons.info_outline_rounded, 'Wear comfortable trekking shoes. Packed water & first-aid kit provided.'),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: SharedBottomNav(
        activeTab: 'home',
        onNavigate: onNavigate,
      ),
    );
  }

  Widget _buildBuddyAction(IconData icon, String label, VoidCallback onTap, {bool isPrimary = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isPrimary ? AppTheme.primaryColor : AppTheme.backgroundLight,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isPrimary ? AppTheme.primaryColor : AppTheme.cardBorderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: isPrimary ? Colors.white : AppTheme.textPrimaryLight),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTheme.sansBody(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isPrimary ? Colors.white : AppTheme.textPrimaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleRow({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppTheme.primaryColor),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold)),
              Text(subtitle, style: AppTheme.sansBody(fontSize: 10.5, color: AppTheme.textSecondaryLight)),
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _buildChecklistRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppTheme.primaryColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: AppTheme.sansBody(fontSize: 11.5, color: AppTheme.textPrimaryLight)),
        ),
      ],
    );
  }
}
