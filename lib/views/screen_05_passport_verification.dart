import 'package:flutter/material.dart';
import '../services/vizag_data.dart';

class Screen05PassportVerification extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen05PassportVerification({super.key, this.onNavigate});

  @override
  State<Screen05PassportVerification> createState() => _Screen05PassportVerificationState();
}

class _Screen05PassportVerificationState extends State<Screen05PassportVerification> {
  late final TextEditingController _passportController;
  late final TextEditingController _countryController;
  late final TextEditingController _expiryController;

  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    final traveller = VizagDataService.traveller;
    _passportController = TextEditingController(text: traveller.passportNumber);
    _countryController = TextEditingController(text: traveller.passportIssuingCountry);
    _expiryController = TextEditingController(text: traveller.passportExpiry);
  }

  @override
  void dispose() {
    _passportController.dispose();
    _countryController.dispose();
    _expiryController.dispose();
    super.dispose();
  }

  void _handleCompleteVerification() async {
    setState(() => _isVerifying = true);
    await Future.delayed(const Duration(milliseconds: 600));

    final traveller = VizagDataService.traveller;
    if (_passportController.text.trim().isNotEmpty) {
      traveller.passportNumber = _passportController.text.trim();
      traveller.hasPassportAdded = true;
      traveller.passportVerified = true;
    }
    if (_countryController.text.trim().isNotEmpty) {
      traveller.passportIssuingCountry = _countryController.text.trim();
    }
    if (_expiryController.text.trim().isNotEmpty) {
      traveller.passportExpiry = _expiryController.text.trim();
    }
    traveller.isProfileComplete = true;

    if (!mounted) return;
    setState(() => _isVerifying = false);

    widget.onNavigate?.call('07-home');
  }

  void _handleSkipPassport() {
    final traveller = VizagDataService.traveller;
    traveller.isOnboardingSkipped = true;
    widget.onNavigate?.call('07-home');
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFFF8C00);
    const greenColor = Color(0xFF059669);

    final traveller = VizagDataService.traveller;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => widget.onNavigate?.call('back'),
        ),
        title: const Text('Passport Verification', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          TextButton(
            onPressed: _handleSkipPassport,
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
                  Text('STEP 2 OF 2 • PASSPORT DETAILS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: primaryColor)),
                  Text('Optional Security Scan', style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 6),
              const Text('Passport & Safety Verification', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
              const SizedBox(height: 4),
              const Text(
                'Passport verification is optional. Adding it earns a Verified Explorer Badge on your profile.',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 20),

              // Form fields for passport info
              Row(
                children: const [
                  Text('PASSPORT NUMBER', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
                  SizedBox(width: 4),
                  Text('(Optional)', style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _passportController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.badge_outlined, color: primaryColor, size: 20),
                  hintText: 'e.g. ESP-9844210-A',
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                style: const TextStyle(fontSize: 13, fontFamily: 'monospace'),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('ISSUING COUNTRY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _countryController,
                          decoration: InputDecoration(
                            hintText: 'e.g. Spain',
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
                        const Text('EXPIRY DATE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _expiryController,
                          decoration: InputDecoration(
                            hintText: 'YYYY-MM-DD',
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
              const SizedBox(height: 20),

              // Verification status preview card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.shield_outlined, color: primaryColor, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              traveller.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.check_circle, size: 12, color: Colors.white),
                              SizedBox(width: 4),
                              Text('KYC READY', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Your passport details are encrypted and stored securely. You can update or skip passport verification anytime.',
                      style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Action buttons: Complete / Skip
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _isVerifying ? null : _handleCompleteVerification,
                  child: _isVerifying
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Complete Onboarding & Go Home', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            SizedBox(width: 6),
                            Icon(Icons.check_circle_outline, size: 18),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey.shade700,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _handleSkipPassport,
                  child: const Text('Skip Passport for Now', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
