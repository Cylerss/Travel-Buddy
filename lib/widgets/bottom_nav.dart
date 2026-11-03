import 'package:flutter/material.dart';

class SharedBottomNav extends StatelessWidget {
  final String activeTab;
  final Function(String)? onNavigate;
  final bool isDarkMode;

  const SharedBottomNav({
    super.key,
    required this.activeTab,
    this.onNavigate,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDarkMode ? const Color(0xFF0F0F11) : Colors.white;
    final borderColor = isDarkMode ? const Color(0xFF27272A) : Colors.grey.shade200;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(top: BorderSide(color: borderColor)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDarkMode ? 0.2 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _navItem(context, 'home', Icons.home_rounded, 'Home', '07-home'),
            _navItem(context, 'explore', Icons.map_rounded, 'Explore', '08-explore-vizag'),
            _navItem(context, 'sos', Icons.shield_rounded, 'SOS', '13-sos-center', isSos: true),
            _navItem(context, 'buddies', Icons.people_rounded, 'Buddies', '10-find-buddy'),
            _navItem(context, 'profile', Icons.person_rounded, 'Profile', '16-profile-dashboard'),
          ],
        ),
      ),
    );
  }

  Widget _navItem(BuildContext context, String tabKey, IconData icon, String label, String targetScreen, {bool isSos = false}) {
    final isActive = activeTab == tabKey || (tabKey == 'profile' && activeTab == 'journal');

    final activeColor = const Color(0xFFFF8C00);
    final inactiveColor = isDarkMode ? const Color(0xFF71717A) : Colors.grey.shade500;
    final textInactiveColor = isDarkMode ? const Color(0xFFA1A1AA) : Colors.grey.shade600;

    if (isSos) {
      return Flexible(
        child: GestureDetector(
          onTap: () => onNavigate?.call(targetScreen),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.shade600,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withValues(alpha: 0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shield_rounded, color: Colors.white, size: 14),
                SizedBox(width: 3),
                Text(
                  'SOS',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Flexible(
      child: GestureDetector(
        onTap: () => onNavigate?.call(targetScreen),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color: isActive ? activeColor : inactiveColor,
              ),
              const SizedBox(height: 2),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                    color: isActive ? activeColor : textInactiveColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
