import 'package:flutter/material.dart';
import '../services/vizag_data.dart';

class Screen04TravellerDetails extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen04TravellerDetails({super.key, this.onNavigate});

  @override
  State<Screen04TravellerDetails> createState() => _Screen04TravellerDetailsState();
}

class _Screen04TravellerDetailsState extends State<Screen04TravellerDetails> {
  late final TextEditingController _nameController;
  late final TextEditingController _countryController;
  late final TextEditingController _dobController;
  late final TextEditingController _phoneController;

  final List<String> _selectedHobbies = [
    'Dancing 💃',
    'Coastal Food Tasting 🍤',
    'Beach Trekking 🏖️',
    'Photography 📸',
  ];

  final List<String> _allHobbies = [
    'Dancing 💃',
    'Coastal Food Tasting 🍤',
    'Beach Trekking 🏖️',
    'Photography 📸',
    'Heritage Walks 🏛️',
    'Live Music 🎵',
    'Surfing 🏄‍♀️',
    'Yoga & Sunsets 🧘',
  ];

  @override
  void initState() {
    super.initState();
    final traveller = VizagDataService.traveller;
    _nameController = TextEditingController(text: traveller.name);
    _countryController = TextEditingController(text: traveller.country);
    _dobController = TextEditingController(text: traveller.dob);
    _phoneController = TextEditingController(text: traveller.phone);
    if (traveller.hobbies.isNotEmpty) {
      _selectedHobbies.clear();
      _selectedHobbies.addAll(traveller.hobbies);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countryController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _toggleHobby(String hobby) {
    setState(() {
      if (_selectedHobbies.contains(hobby)) {
        _selectedHobbies.remove(hobby);
      } else {
        _selectedHobbies.add(hobby);
      }
    });
  }

  void _saveCurrentInfo() {
    final traveller = VizagDataService.traveller;
    if (_nameController.text.trim().isNotEmpty) {
      traveller.name = _nameController.text.trim();
    }
    if (_countryController.text.trim().isNotEmpty) {
      traveller.country = _countryController.text.trim();
      traveller.nationality = _countryController.text.trim();
    }
    if (_dobController.text.trim().isNotEmpty) {
      traveller.dob = _dobController.text.trim();
    }
    if (_phoneController.text.trim().isNotEmpty) {
      traveller.phone = _phoneController.text.trim();
    }
    traveller.hobbies = List.from(_selectedHobbies);
    traveller.travelPreferences = List.from(_selectedHobbies);
  }

  void _handleContinue() {
    _saveCurrentInfo();
    widget.onNavigate?.call('05-passport-verification');
  }

  void _handleSkip() {
    _saveCurrentInfo();
    VizagDataService.traveller.isOnboardingSkipped = true;
    widget.onNavigate?.call('05-passport-verification');
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFFF8C00);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => widget.onNavigate?.call('back'),
        ),
        title: const Text('Traveller Details', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          TextButton(
            onPressed: _handleSkip,
            child: const Text('Skip for Now', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 13)),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('STEP 1 OF 2 • BASIC DETAILS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: primaryColor)),
                  Text('Safe Traveller KYC', style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 6),
              const Text('Tell Us About Yourself', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
              const SizedBox(height: 4),
              const Text(
                'Help us match you with 5-star local buddies & authentic Vizag experiences.',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 20),

              // Full Name (Required)
              Row(
                children: const [
                  Text('FULL NAME', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
                  SizedBox(width: 4),
                  Text('* Required', style: TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline, color: primaryColor, size: 20),
                  hintText: 'Enter your full name',
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 16),

              // Country of Origin (Optional)
              Row(
                children: const [
                  Text('NATIONALITY / COUNTRY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
                  SizedBox(width: 4),
                  Text('(Optional)', style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _countryController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.language, color: Colors.blue, size: 20),
                  hintText: 'e.g. India 🇮🇳 or Spain 🇪🇸',
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 16),

              // Date of Birth & Phone (Optional)
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text('DATE OF BIRTH', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
                            SizedBox(width: 2),
                            Text('(Optional)', style: TextStyle(fontSize: 9, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _dobController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.cake_outlined, color: Colors.pink, size: 18),
                            hintText: 'DD/MM/YYYY',
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text('PHONE NUMBER', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
                            SizedBox(width: 2),
                            Text('(Optional)', style: TextStyle(fontSize: 9, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone_outlined, color: Colors.green, size: 18),
                            hintText: '+91 98765...',
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Hobbies & Interests (Optional)
              Row(
                children: const [
                  Text('TRAVEL PREFERENCES & INTERESTS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
                  SizedBox(width: 4),
                  Text('(Optional)', style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _allHobbies.map((hobby) {
                  final isSelected = _selectedHobbies.contains(hobby);
                  final isDancing = hobby.contains('Dancing');
                  return GestureDetector(
                    onTap: () => _toggleHobby(hobby),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDancing ? primaryColor : Colors.orange.shade50)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? primaryColor : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        hobby,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? (isDancing ? Colors.white : Colors.orange.shade900)
                              : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _handleContinue,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Continue to Passport Verification', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Visible "Skip for Now" Secondary Button
              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey.shade700,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _handleSkip,
                  child: const Text('Skip Details & Continue', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
