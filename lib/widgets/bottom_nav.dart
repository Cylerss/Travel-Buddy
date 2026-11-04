import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SharedBottomNav extends StatelessWidget {
  final String activeTab;
  final Function(String)? onNavigate;
  final bool isDarkMode;
  final bool isBuddyPortal;

  const SharedBottomNav({
    super.key,
    required this.activeTab,
    this.onNavigate,
    this.isDarkMode = false,
    this.isBuddyPortal = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDarkMode ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDarkMode ? AppTheme.cardBorderDark : AppTheme.cardBorderColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border(
          top: BorderSide(color: borderColor, width: 1.2),
          left: BorderSide(color: borderColor.withValues(alpha: 0.5), width: 1),
          right: BorderSide(color: borderColor.withValues(alpha: 0.5), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x14231815),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SafeArea(
        top: false,
        child: isBuddyPortal ? _buildBuddyNav(context) : _buildTravellerNav(context),
      ),
    );
  }

  Widget _buildTravellerNav(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _navItem(
          icon: Icons.home_outlined,
          activeIcon: Icons.home_rounded,
          label: 'Home',
          tabKey: 'home',
          targetScreen: '07-home',
        ),
        _navItem(
          icon: Icons.favorite_outline_rounded,
          activeIcon: Icons.favorite_rounded,
          label: 'Wishlist',
          tabKey: 'wishlist',
          targetScreen: '08-explore-vizag',
        ),
        _buildSosButton(),
        _navItem(
          icon: Icons.people_outline_rounded,
          activeIcon: Icons.people_rounded,
          label: 'Buddies',
          tabKey: 'buddies',
          targetScreen: '10-find-buddy',
        ),
        _navItem(
          icon: Icons.person_outline_rounded,
          activeIcon: Icons.person_rounded,
          label: 'Profile',
          tabKey: 'profile',
          targetScreen: '16-profile-dashboard',
        ),
      ],
    );
  }

  Widget _buildBuddyNav(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _navItem(
          icon: Icons.home_outlined,
          activeIcon: Icons.home_rounded,
          label: 'Home',
          tabKey: 'home',
          targetScreen: '18-buddy-details',
        ),
        _navItem(
          icon: Icons.calendar_today_outlined,
          activeIcon: Icons.calendar_today_rounded,
          label: 'Bookings',
          tabKey: 'bookings',
          targetScreen: '19-buddy-ratings',
        ),
        _navItem(
          icon: Icons.mark_email_unread_outlined,
          activeIcon: Icons.mark_email_unread_rounded,
          label: 'Requests',
          tabKey: 'requests',
          targetScreen: '20-buddy-leaderboard',
        ),
        _navItem(
          icon: Icons.person_outline_rounded,
          activeIcon: Icons.person_rounded,
          label: 'Profile',
          tabKey: 'profile',
          targetScreen: '16-profile-dashboard',
        ),
      ],
    );
  }

  Widget _buildSosButton() {
    final isSosActive = activeTab == 'sos';
    return GestureDetector(
      onTap: () => onNavigate?.call('13-sos-center'),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.sosRed,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.sosRed.withValues(alpha: isSosActive ? 0.6 : 0.35),
              blurRadius: isSosActive ? 12 : 8,
              spreadRadius: isSosActive ? 2 : 0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(
          Icons.shield_rounded,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required String tabKey,
    required String targetScreen,
  }) {
    final isActive = activeTab == tabKey;
    final activeColor = AppTheme.primaryColor;
    final inactiveColor = isDarkMode ? AppTheme.textSecondaryDark : AppTheme.textSecondaryLight;

    return InkWell(
      onTap: () => onNavigate?.call(targetScreen),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              size: 22,
              color: isActive ? activeColor : inactiveColor,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: AppTheme.sansBody(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
