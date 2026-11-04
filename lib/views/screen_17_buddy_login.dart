import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class Screen17BuddyLogin extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen17BuddyLogin({super.key, this.onNavigate});

  @override
  State<Screen17BuddyLogin> createState() => _Screen17BuddyLoginState();
}

class _Screen17BuddyLoginState extends State<Screen17BuddyLogin> {
  bool _obscurePassword = true;
  bool _rememberMe = true;
  final TextEditingController _emailController = TextEditingController(text: 'priya.sharma.guide@travelbuddy.com');
  final TextEditingController _phoneController = TextEditingController(text: '+91 98490 12345');
  final TextEditingController _passwordController = TextEditingController(text: 'password123');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image with Back Button
            Stack(
              children: [
                Container(
                  height: 220,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&fm=webp&fit=crop&q=80',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                    gradient: LinearGradient(
                      colors: [const Color(0x9918100C), Colors.transparent, AppTheme.backgroundLight.withValues(alpha: 0.9)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppTheme.textPrimaryLight),
                        onPressed: () => widget.onNavigate?.call('02-welcome'),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buddy Portal',
                    style: AppTheme.serifTitle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Manage trips, connect with travellers and create memorable experiences together.',
                    style: AppTheme.sansBody(fontSize: 12.5, color: AppTheme.textSecondaryLight),
                  ),
                  const SizedBox(height: 18),

                  // Segmented Role Toggle
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppTheme.cardBorderColor),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => widget.onNavigate?.call('03-traveller-login'),
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.person_outline_rounded, size: 16, color: AppTheme.textSecondaryLight),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Traveller Login',
                                    style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textSecondaryLight),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryColor.withValues(alpha: 0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.people_alt_rounded, size: 16, color: Colors.white),
                                const SizedBox(width: 6),
                                Text(
                                  'Buddy Portal',
                                  style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email
                  _buildInputCard(
                    icon: Icons.email_outlined,
                    label: 'Email Address',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 12),

                  // Mobile
                  _buildInputCard(
                    icon: Icons.phone_outlined,
                    label: 'Mobile Number',
                    controller: _phoneController,
                  ),
                  const SizedBox(height: 12),

                  // Password
                  _buildInputCard(
                    icon: Icons.lock_outline_rounded,
                    label: 'Password',
                    controller: _passwordController,
                    isPassword: true,
                    obscureText: _obscurePassword,
                    onTogglePassword: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  const SizedBox(height: 10),

                  // Remember Me & Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: _rememberMe,
                              activeColor: AppTheme.primaryColor,
                              onChanged: (val) => setState(() => _rememberMe = val!),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text('Remember Me', style: AppTheme.sansBody(fontSize: 12, color: AppTheme.textSecondaryLight)),
                        ],
                      ),
                      Text('Forgot Password?', style: AppTheme.sansBody(fontSize: 12, color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Login as Buddy CTA
                  InkWell(
                    onTap: () => widget.onNavigate?.call('18-buddy-details'),
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryColor.withValues(alpha: 0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Login as Buddy', style: AppTheme.sansBody(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Google Sign In
                  InkWell(
                    onTap: () => widget.onNavigate?.call('18-buddy-details'),
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppTheme.cardBorderColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.g_mobiledata_rounded, color: Colors.red, size: 28),
                          const SizedBox(width: 4),
                          Text('Continue with Google', style: AppTheme.sansBody(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textPrimaryLight)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Footer: Register as new Buddy
                  Center(
                    child: InkWell(
                      onTap: () => widget.onNavigate?.call('18-buddy-details'),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: 'New to Travel Buddy? ', style: AppTheme.sansBody(fontSize: 12, color: AppTheme.textSecondaryLight)),
                            TextSpan(text: 'Become a Partner ->', style: AppTheme.sansBody(fontSize: 12, color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onTogglePassword,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.cardBorderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryColor, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword ? obscureText : false,
              style: AppTheme.sansBody(fontSize: 13, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(fontSize: 11, color: AppTheme.textSecondaryLight),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (isPassword)
            IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: AppTheme.textSecondaryLight,
                size: 18,
              ),
              onPressed: onTogglePassword,
            ),
        ],
      ),
    );
  }
}
