import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';

class Screen18BuddyDetails extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen18BuddyDetails({super.key, this.onNavigate});

  @override
  State<Screen18BuddyDetails> createState() => _Screen18BuddyDetailsState();
}

class _Screen18BuddyDetailsState extends State<Screen18BuddyDetails> {
  // 0: Step 1 Identity, 1: Step 2 Personal, 2: Step 3 Interests, 3: Profile Review, 4: Buddy Dashboard
  int _currentStep = 0;

  // Step 1 State: Identity
  String _govIdType = 'Aadhaar Card';
  final TextEditingController _aadhaarController = TextEditingController(text: '9845 2314 7890');
  bool _selfieTaken = true;

  // Step 2 State: Personal
  final TextEditingController _fullNameController = TextEditingController(text: 'Priya Sharma');
  final TextEditingController _mobileController = TextEditingController(text: '+91 98490 12345');
  final TextEditingController _dobController = TextEditingController(text: '15 Aug 1998');
  final TextEditingController _emailController = TextEditingController(text: 'priya.sharma.guide@travelbuddy.com');
  final TextEditingController _passwordController = TextEditingController(text: '••••••••');
  final List<TextEditingController> _emailOtpControllers = List.generate(4, (_) => TextEditingController(text: '4'));
  final List<TextEditingController> _mobileOtpControllers = List.generate(4, (_) => TextEditingController(text: '8'));

  // Step 3 State: Professional & Interests
  String _city = 'Visakhapatnam';
  final List<String> _coveredAreas = ['Beach Road', 'Araku Valley', 'Simhachalam'];
  final Set<String> _selectedInterests = {'Beaches', 'Food', 'Heritage', 'Adventure', 'Nature', 'Photography'};
  String _experience = '1 - 3 Years';
  final Map<String, bool> _weeklyDays = {
    'Mon': true,
    'Tue': true,
    'Wed': true,
    'Thu': true,
    'Fri': true,
    'Sat': true,
    'Sun': false,
  };
  final TextEditingController _bioController = TextEditingController(
    text: "Hi! I'm Priya, a local from Visakhapatnam. I love showing travellers the best places, local food and hidden spots around Vizag. I enjoy meeting new people and sharing my city's culture, beaches and unique experiences.",
  );

  @override
  Widget build(BuildContext context) {
    if (_currentStep == 4) return _buildBuddyDashboard();

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroBanner(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_currentStep < 3) _buildStepProgressIndicator(),
                  const SizedBox(height: 16),
                  _buildStepContent(),
                  const SizedBox(height: 24),
                  _buildContinueButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Stack(
      children: [
        Container(
          height: 180,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            image: DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&fm=webp&fit=crop&q=80',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
            gradient: LinearGradient(
              colors: [const Color(0x9918100C), Colors.transparent, AppTheme.backgroundLight],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppTheme.textPrimaryLight),
                    onPressed: () {
                      if (_currentStep > 0) {
                        setState(() => _currentStep--);
                      } else {
                        widget.onNavigate?.call('17-buddy-login');
                      }
                    },
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'BECOME A',
                  style: AppTheme.sansBody(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                ),
                Text(
                  'Local Buddy Partner',
                  style: AppTheme.serifTitle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textPrimaryLight),
                ),
                Text(
                  'Join our community and help travellers explore amazing places together.',
                  style: AppTheme.sansBody(fontSize: 11.5, color: AppTheme.textSecondaryLight),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepProgressIndicator() {
    return Row(
      children: [
        _buildStepPill(0, '1', 'Verify Identity'),
        _buildStepDivider(0),
        _buildStepPill(1, '2', 'Personal Details'),
        _buildStepDivider(1),
        _buildStepPill(2, '3', 'Share Your Interests'),
      ],
    );
  }

  Widget _buildStepPill(int stepIdx, String num, String label) {
    final isActive = _currentStep == stepIdx;
    final isDone = _currentStep > stepIdx;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive || isDone ? AppTheme.primaryColor : Colors.white,
              border: Border.all(
                color: isActive || isDone ? AppTheme.primaryColor : AppTheme.cardBorderColor,
                width: 1.5,
              ),
            ),
            child: Center(
              child: isDone
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : Text(
                      num,
                      style: AppTheme.sansBody(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isActive ? Colors.white : AppTheme.textSecondaryLight,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTheme.sansBody(
              fontSize: 9,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? AppTheme.primaryColor : AppTheme.textSecondaryLight,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildStepDivider(int afterStep) {
    final isDone = _currentStep > afterStep;
    return Container(
      width: 20,
      height: 2,
      margin: const EdgeInsets.only(bottom: 14),
      color: isDone ? AppTheme.primaryColor : AppTheme.cardBorderColor,
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep1Identity();
      case 1:
        return _buildStep2Personal();
      case 2:
        return _buildStep3Interests();
      case 3:
        return _buildStep4ProfileReview();
      default:
        return const SizedBox();
    }
  }

  // STEP 1: Identity Verification (Image 1, Top-Middle)
  Widget _buildStep1Identity() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppTheme.cardBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.verified_user_outlined, color: AppTheme.primaryColor, size: 20),
              const SizedBox(width: 8),
              Text('Identity Verification', style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          Text('Help us verify you are a genuine local buddy.', style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
          const SizedBox(height: 16),

          // Government ID Proof Dropdown
          Text('Government ID Proof *', style: AppTheme.sansBody(fontSize: 11.5, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.cardBorderColor),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _govIdType,
                isExpanded: true,
                items: ['Aadhaar Card', 'Passport', 'Voter ID'].map((e) => DropdownMenuItem(value: e, child: Text(e, style: AppTheme.sansBody(fontSize: 13, fontWeight: FontWeight.w600)))).toList(),
                onChanged: (val) => setState(() => _govIdType = val!),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Aadhaar Number
          Text('Aadhaar Number *', style: AppTheme.sansBody(fontSize: 11.5, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.cardBorderColor),
            ),
            child: TextField(
              controller: _aadhaarController,
              style: AppTheme.sansBody(fontSize: 13, fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                hintText: 'Enter your 12 digit Aadhaar number',
                hintStyle: TextStyle(fontSize: 11, color: AppTheme.textSecondaryLight),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ID Upload Cards
          Row(
            children: [
              // Front Preview
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Upload ID (Front Side) *', style: AppTheme.sansBody(fontSize: 10.5, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.cardBorderColor),
                        image: const DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1544717305-2782549b5136?w=200&fm=webp&fit=crop&q=80'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Back Side Upload
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Upload ID (Back Side) *', style: AppTheme.sansBody(fontSize: 10.5, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.cardBorderColor, style: BorderStyle.solid),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.cloud_upload_outlined, color: AppTheme.primaryColor, size: 24),
                          const SizedBox(height: 4),
                          Text('Upload Back Side', style: AppTheme.sansBody(fontSize: 10, fontWeight: FontWeight.bold)),
                          Text('JPG, PNG or PDF (Max 5 MB)', style: AppTheme.sansBody(fontSize: 8, color: AppTheme.textSecondaryLight)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Selfie Verification
          Text('Selfie Verification *', style: AppTheme.sansBody(fontSize: 11.5, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.cardBorderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.primaryColor),
                  ),
                  child: const Icon(Icons.camera_alt_rounded, color: AppTheme.primaryColor, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Take a Selfie', style: AppTheme.sansBody(fontSize: 12.5, fontWeight: FontWeight.bold)),
                      Text('Make sure your face is clearly visible', style: AppTheme.sansBody(fontSize: 10.5, color: AppTheme.textSecondaryLight)),
                    ],
                  ),
                ),
                const Icon(Icons.check_circle_rounded, color: AppTheme.successGreen, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // STEP 2: Personal Details & Account Verification (Image 1, Top-Right)
  Widget _buildStep2Personal() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppTheme.cardBorderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.person_outline_rounded, color: AppTheme.primaryColor, size: 20),
                  const SizedBox(width: 8),
                  Text('Personal Details', style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              Text('Your basic information from your verified account.', style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
              const SizedBox(height: 14),

              _buildDetailRow(Icons.person, 'Full Name *', _fullNameController),
              const SizedBox(height: 10),
              _buildDetailRow(Icons.phone, 'Mobile Number *', _mobileController),
              const SizedBox(height: 10),
              _buildDetailRow(Icons.cake, 'Date of Birth *', _dobController),
              const SizedBox(height: 10),
              _buildDetailRow(Icons.email, 'Email Address *', _emailController),
              const SizedBox(height: 10),
              _buildDetailRow(Icons.lock, 'Password *', _passwordController, isPassword: true),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Verify Your Account (OTP)
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppTheme.cardBorderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.shield_outlined, color: AppTheme.primaryColor, size: 20),
                  const SizedBox(width: 8),
                  Text('Verify Your Account', style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              Text('We will send verification codes to confirm your email and mobile number.', style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
              const SizedBox(height: 14),

              // Email OTP
              Text('Email Verification', style: AppTheme.sansBody(fontSize: 11.5, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('We sent code to ${_emailController.text}', style: AppTheme.sansBody(fontSize: 10, color: AppTheme.textSecondaryLight)),
                  Text('Change', style: AppTheme.sansBody(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                ],
              ),
              const SizedBox(height: 8),
              _buildOtpBoxes(_emailOtpControllers),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerRight,
                child: Text('Resend in 00:45', style: AppTheme.sansBody(fontSize: 10, color: AppTheme.textSecondaryLight)),
              ),
              const Divider(height: 20, color: AppTheme.cardBorderColor),

              // Mobile OTP
              Text('Mobile Verification', style: AppTheme.sansBody(fontSize: 11.5, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('We sent code to ${_mobileController.text}', style: AppTheme.sansBody(fontSize: 10, color: AppTheme.textSecondaryLight)),
                  Text('Change', style: AppTheme.sansBody(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                ],
              ),
              const SizedBox(height: 8),
              _buildOtpBoxes(_mobileOtpControllers),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerRight,
                child: Text('Resend in 00:45', style: AppTheme.sansBody(fontSize: 10, color: AppTheme.textSecondaryLight)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, TextEditingController controller, {bool isPassword = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorderColor),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppTheme.textSecondaryLight),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              style: AppTheme.sansBody(fontSize: 12.5, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(fontSize: 10.5, color: AppTheme.textSecondaryLight),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          const Icon(Icons.lock_outline_rounded, size: 14, color: AppTheme.textSecondaryLight),
        ],
      ),
    );
  }

  Widget _buildOtpBoxes(List<TextEditingController> controllers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: controllers.map((c) {
        return Container(
          width: 50,
          height: 44,
          decoration: BoxDecoration(
            color: AppTheme.backgroundLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.5)),
          ),
          child: Center(
            child: Text(
              c.text,
              style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
            ),
          ),
        );
      }).toList(),
    );
  }

  // STEP 3: Professional Details & Interests (Image 1, Bottom-Left)
  Widget _buildStep3Interests() {
    final allInterests = ['Beaches', 'Food', 'Heritage', 'Adventure', 'Nature', 'Photography', 'Culture', 'Night Life'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppTheme.cardBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.work_outline_rounded, color: AppTheme.primaryColor, size: 20),
              const SizedBox(width: 8),
              Text('Professional Details & Interests', style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          Text('Tell us about your guiding experience and interests so travellers can find and connect with you.', style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
          const SizedBox(height: 16),

          // City
          Text('City *', style: AppTheme.sansBody(fontSize: 11.5, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.cardBorderColor),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on_rounded, size: 16, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                Text(_city, style: AppTheme.sansBody(fontSize: 13, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Areas You Cover
          Text('Areas You Cover *', style: AppTheme.sansBody(fontSize: 11.5, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              ..._coveredAreas.map((area) {
                return Chip(
                  label: Text(area, style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.w600)),
                  backgroundColor: AppTheme.chipBackground,
                  side: const BorderSide(color: AppTheme.chipBorder),
                  deleteIcon: const Icon(Icons.close, size: 12),
                  onDeleted: () => setState(() => _coveredAreas.remove(area)),
                );
              }),
              ActionChip(
                label: Text('+ Add Area', style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                backgroundColor: Colors.white,
                side: const BorderSide(color: AppTheme.primaryColor),
                onPressed: () {
                  setState(() => _coveredAreas.add('Rushikonda Beach'));
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Interests & Activities
          Text('Interests & Activities *', style: AppTheme.sansBody(fontSize: 11.5, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: allInterests.map((interest) {
              final isSel = _selectedInterests.contains(interest);
              return InkWell(
                onTap: () {
                  setState(() {
                    if (isSel) {
                      _selectedInterests.remove(interest);
                    } else {
                      _selectedInterests.add(interest);
                    }
                  });
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSel ? AppTheme.primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isSel ? AppTheme.primaryColor : AppTheme.cardBorderColor),
                  ),
                  child: Text(
                    interest,
                    style: AppTheme.sansBody(
                      fontSize: 11,
                      fontWeight: isSel ? FontWeight.bold : FontWeight.w500,
                      color: isSel ? Colors.white : AppTheme.textPrimaryLight,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Guiding Experience
          Text('Guiding Experience *', style: AppTheme.sansBody(fontSize: 11.5, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.cardBorderColor),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _experience,
                isExpanded: true,
                items: ['Beginner (< 1 Year)', '1 - 3 Years', '3 - 5 Years', '5+ Years'].map((e) => DropdownMenuItem(value: e, child: Text(e, style: AppTheme.sansBody(fontSize: 13, fontWeight: FontWeight.w600)))).toList(),
                onChanged: (val) => setState(() => _experience = val!),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Availability Table
          Text('Availability *', style: AppTheme.sansBody(fontSize: 11.5, fontWeight: FontWeight.bold)),
          Text('Select the days and time slots when you are available to guide travellers.', style: AppTheme.sansBody(fontSize: 10, color: AppTheme.textSecondaryLight)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.cardBorderColor),
            ),
            child: Column(
              children: _weeklyDays.entries.map((entry) {
                final day = entry.key;
                final isAvailable = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      SizedBox(width: 35, child: Text(day, style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold))),
                      Switch(
                        value: isAvailable,
                        activeColor: AppTheme.primaryColor,
                        onChanged: (val) => setState(() => _weeklyDays[day] = val),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          isAvailable ? '09:00 AM - 05:00 PM' : 'Not available',
                          style: AppTheme.sansBody(fontSize: 10.5, color: isAvailable ? AppTheme.textPrimaryLight : AppTheme.textSecondaryLight),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // About Me
          Text('About Me *', style: AppTheme.sansBody(fontSize: 11.5, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.cardBorderColor),
            ),
            child: TextField(
              controller: _bioController,
              maxLines: 4,
              style: AppTheme.sansBody(fontSize: 12, height: 1.4),
              decoration: const InputDecoration(border: InputBorder.none, isDense: true),
            ),
          ),
        ],
      ),
    );
  }

  // STEP 4: Profile Review (Image 1, Bottom-Middle)
  Widget _buildStep4ProfileReview() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppTheme.cardBorderColor),
          ),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 36,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&fm=webp&fit=crop&q=80'),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Priya Sharma', style: AppTheme.serifTitle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 4),
                  const Icon(Icons.verified_rounded, size: 16, color: Color(0xFF1E88E5)),
                ],
              ),
              Text('Local Buddy • Visakhapatnam', style: AppTheme.sansBody(fontSize: 11.5, color: AppTheme.textSecondaryLight)),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star_rounded, size: 16, color: AppTheme.accentGold),
                  Text(' 5.0 (50 reviews)', style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        _buildReviewSection('Personal Information', [
          'Full Name: Priya Sharma',
          'Email: priya.sharma.guide@travelbuddy.com',
          'Mobile: +91 98490 12345',
          'DOB: 15 Aug 1998',
        ]),
        const SizedBox(height: 10),

        _buildReviewSection('Location & Languages', [
          'City: Visakhapatnam',
          'Areas: Beach Road, Araku Valley, Simhachalam',
          'Languages: English, Hindi, Telugu',
        ]),
        const SizedBox(height: 10),

        _buildReviewSection('About Me', [_bioController.text]),
      ],
    );
  }

  Widget _buildReviewSection(String title, List<String> lines) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.cardBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTheme.serifTitle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          ...lines.map((l) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(l, style: AppTheme.sansBody(fontSize: 11.5, color: AppTheme.textSecondaryLight)),
              )),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return InkWell(
      onTap: () {
        if (_currentStep < 4) {
          setState(() => _currentStep++);
        }
      },
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
            Text(
              _currentStep == 3 ? 'Complete Registration' : 'Continue',
              style: AppTheme.sansBody(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }

  // STEP 5: Buddy Home Dashboard (Image 1, Bottom-Right)
  Widget _buildBuddyDashboard() {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Travel Buddy', style: AppTheme.serifTitle(fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
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
            Text('Hello, Priya! 👋', style: AppTheme.serifTitle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Welcome to Travel Buddy Local Buddy Portal', style: AppTheme.sansBody(fontSize: 12, color: AppTheme.textSecondaryLight)),
            const SizedBox(height: 14),

            // Complete Basic Info Banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFF3EC), Color(0xFFFFE8DC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFFD1B8)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Complete Your Basic Info', style: AppTheme.serifTitle(fontSize: 14.5, fontWeight: FontWeight.bold)),
                        Text('Add your bank details to start receiving guide payments.', style: AppTheme.sansBody(fontSize: 10.5, color: AppTheme.textSecondaryLight)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text('Add Bank Info ->', style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=120&fm=webp&fit=crop&q=80',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // 4 Grid Metric Cards
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: [
                _buildDashboardMetricCard(Icons.calendar_today_rounded, 'My Bookings', '12 Active', Colors.blue, onTap: () => widget.onNavigate?.call('19-buddy-ratings')),
                _buildDashboardMetricCard(Icons.mark_email_unread_rounded, 'Guide Requests', '3 Pending', AppTheme.primaryColor, onTap: () => widget.onNavigate?.call('19-buddy-ratings')),
                _buildDashboardMetricCard(Icons.account_balance_wallet_rounded, 'Earnings', '₹18,450', Colors.green),
                _buildDashboardMetricCard(Icons.star_rounded, 'Reviews', '50 (5.0 ★)', AppTheme.accentGold),
              ],
            ),
            const SizedBox(height: 20),

            // Quick Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quick Actions', style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('See All >', style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildQuickActionBtn(Icons.schedule_rounded, 'Set\nAvailability'),
                _buildQuickActionBtn(Icons.location_on_rounded, 'My\nAreas'),
                _buildQuickActionBtn(Icons.translate_rounded, 'Languages'),
                _buildQuickActionBtn(Icons.interests_rounded, 'Interests'),
                _buildQuickActionBtn(Icons.person_rounded, 'View\nProfile'),
              ],
            ),
            const SizedBox(height: 20),

            // Recent Requests
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Requests', style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold)),
                InkWell(
                  onTap: () => widget.onNavigate?.call('19-buddy-ratings'),
                  child: Text('View All >', style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildRecentRequestCard('Visakhapatnam City Tour', 'Rahul Mehta • 2 Travellers • Full Day', 'Pending'),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: SharedBottomNav(
        activeTab: 'home',
        isBuddyPortal: true,
        onNavigate: widget.onNavigate,
      ),
    );
  }

  Widget _buildDashboardMetricCard(IconData icon, String title, String subtitle, Color color, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppTheme.cardBorderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 22),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
                Text(subtitle, style: AppTheme.sansBody(fontSize: 13, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionBtn(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppTheme.cardBorderColor),
          ),
          child: Icon(icon, color: AppTheme.primaryColor, size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTheme.sansBody(fontSize: 9.5, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRecentRequestCard(String title, String subtitle, String status) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.cardBorderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.chipBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.assignment_outlined, color: AppTheme.primaryColor, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.serifTitle(fontSize: 13.5, fontWeight: FontWeight.bold)),
                Text(subtitle, style: AppTheme.sansBody(fontSize: 10.5, color: AppTheme.textSecondaryLight)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.pendingLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(status, style: AppTheme.sansBody(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.pendingAmber)),
          ),
        ],
      ),
    );
  }
}
