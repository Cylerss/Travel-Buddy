import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ScreenCheckoutFlow extends StatefulWidget {
  final Function(String)? onNavigate;

  const ScreenCheckoutFlow({super.key, this.onNavigate});

  @override
  State<ScreenCheckoutFlow> createState() => _ScreenCheckoutFlowState();
}

class _ScreenCheckoutFlowState extends State<ScreenCheckoutFlow> {
  // Step: 0: Select Options, 1: Complete Booking (Add-ons), 2: Traveller Details, 3: Payment, 4: Confirmed, 5: Request Sent
  int _currentStep = 0;

  // Step 0 State
  int _selectedDateIdx = 0;
  int _selectedSlotIdx = 1;
  int _adultCount = 2;
  int _childCount = 1;
  int _infantCount = 0;

  final List<Map<String, String>> _dates = [
    {'day': 'Oct', 'date': '29', 'price': '₹499'},
    {'day': 'Oct', 'date': '30', 'price': '₹499'},
    {'day': 'Oct', 'date': '31', 'price': '₹499'},
    {'day': 'Nov', 'date': '1', 'price': '₹499'},
  ];

  final List<String> _slots = ['09:00 AM', '11:00 AM', '01:00 PM', '04:00 PM'];

  // Step 1 State: Add-ons
  bool _addonPhoto = false;
  bool _addonGuide = false;
  bool _addonSnorkel = false;
  bool _freeGiftChecked = true;

  // Step 2 State: Contact & Traveller details
  final TextEditingController _contactName = TextEditingController(text: 'Arjun Mehta');
  final TextEditingController _contactEmail = TextEditingController(text: 'arjun.mehta@example.com');
  final TextEditingController _contactPhone = TextEditingController(text: '+91 98765 43210');

  // Step 3 State: Payment
  String _selectedPaymentMethod = 'UPI';
  final TextEditingController _promoController = TextEditingController();
  bool _promoApplied = false;

  int get _baseTotal {
    return (_adultCount * 499) + (_childCount * 299);
  }

  int get _addonsTotal {
    int sum = 0;
    if (_addonPhoto) sum += 249;
    if (_addonGuide) sum += 199;
    if (_addonSnorkel) sum += 299;
    return sum;
  }

  int get _grandTotal {
    int total = _baseTotal + _addonsTotal;
    if (_promoApplied) total = (total * 0.9).round();
    return total;
  }

  @override
  Widget build(BuildContext context) {
    if (_currentStep == 4) return _buildConfirmedScreen(isDirect: true);
    if (_currentStep == 5) return _buildConfirmedScreen(isDirect: false);

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            } else {
              widget.onNavigate?.call('08-explore-vizag');
            }
          },
        ),
        title: Text(
          _stepTitle,
          style: AppTheme.serifTitle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppTheme.cardBorderColor, height: 1),
        ),
      ),
      body: _buildCurrentStepBody(),
      bottomNavigationBar: _buildBottomCheckoutBar(),
    );
  }

  String get _stepTitle {
    switch (_currentStep) {
      case 0:
        return 'Select Options';
      case 1:
        return 'Complete Booking';
      case 2:
        return 'Traveller Details';
      case 3:
        return 'Payment';
      default:
        return 'Booking';
    }
  }

  Widget _buildCurrentStepBody() {
    switch (_currentStep) {
      case 0:
        return _buildSelectOptions();
      case 1:
        return _buildAddonsAndGift();
      case 2:
        return _buildTravellerDetails();
      case 3:
        return _buildPaymentScreen();
      default:
        return const SizedBox();
    }
  }

  // STEP 0: Select Options (Image 3, Top-Left)
  Widget _buildSelectOptions() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Experience card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.cardBorderColor),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=200&fm=webp&fit=crop&q=80',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('RK Beach Experience', style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold)),
                      Text('Beaches • Visakhapatnam', style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.access_time_rounded, size: 12, color: AppTheme.textSecondaryLight),
                          const SizedBox(width: 3),
                          Text('2 - 3 Hours', style: AppTheme.sansBody(fontSize: 10.5, color: AppTheme.textSecondaryLight)),
                          const SizedBox(width: 8),
                          const Icon(Icons.people_outline_rounded, size: 12, color: AppTheme.textSecondaryLight),
                          const SizedBox(width: 3),
                          Text('Suitable for All Ages', style: AppTheme.sansBody(fontSize: 10.5, color: AppTheme.textSecondaryLight)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Select Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select Date', style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Icon(Icons.calendar_month_rounded, size: 14, color: AppTheme.primaryColor),
                  const SizedBox(width: 4),
                  Text('Oct / Nov 2026', style: AppTheme.sansBody(fontSize: 11, color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ..._dates.asMap().entries.map((entry) {
                final idx = entry.key;
                final d = entry.value;
                final isSel = _selectedDateIdx == idx;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: InkWell(
                      onTap: () => setState(() => _selectedDateIdx = idx),
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSel ? AppTheme.primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: isSel ? AppTheme.primaryColor : AppTheme.cardBorderColor),
                        ),
                        child: Column(
                          children: [
                            Text(d['day']!, style: AppTheme.sansBody(fontSize: 10, color: isSel ? Colors.white70 : AppTheme.textSecondaryLight)),
                            Text(d['date']!, style: AppTheme.sansBody(fontSize: 14, fontWeight: FontWeight.bold, color: isSel ? Colors.white : AppTheme.textPrimaryLight)),
                            Text(d['price']!, style: AppTheme.sansBody(fontSize: 10, fontWeight: FontWeight.bold, color: isSel ? Colors.white : AppTheme.primaryColor)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
              Container(
                width: 44,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppTheme.cardBorderColor),
                ),
                child: const Icon(Icons.calendar_today_rounded, size: 18, color: AppTheme.primaryColor),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Select Timeslot
          Text('Select Timeslot', style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: _slots.asMap().entries.map((entry) {
              final idx = entry.key;
              final time = entry.value;
              final isSel = _selectedSlotIdx == idx;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: InkWell(
                    onTap: () => setState(() => _selectedSlotIdx = idx),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSel ? AppTheme.primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: isSel ? AppTheme.primaryColor : AppTheme.cardBorderColor),
                      ),
                      child: Text(
                        time,
                        style: AppTheme.sansBody(
                          fontSize: 11,
                          fontWeight: isSel ? FontWeight.bold : FontWeight.w500,
                          color: isSel ? Colors.white : AppTheme.textPrimaryLight,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
          ),
          const SizedBox(height: 20),

          // Select Quantity
          Text('Select Quantity', style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.cardBorderColor),
            ),
            child: Column(
              children: [
                _buildQuantityRow('Adult (12+)', '₹499', _adultCount, (val) => setState(() => _adultCount = val)),
                const Divider(height: 20, color: AppTheme.cardBorderColor),
                _buildQuantityRow('Child (5-11)', '₹299', _childCount, (val) => setState(() => _childCount = val)),
                const Divider(height: 20, color: AppTheme.cardBorderColor),
                _buildQuantityRow('Infant (0-4)', 'Free', _infantCount, (val) => setState(() => _infantCount = val)),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildQuantityRow(String label, String price, int count, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTheme.sansBody(fontSize: 13, fontWeight: FontWeight.bold)),
            Text(price, style: AppTheme.sansBody(fontSize: 11, color: AppTheme.primaryColor, fontWeight: FontWeight.w600)),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                if (count > 0) onChanged(count - 1);
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.cardBorderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.remove, size: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('$count', style: AppTheme.sansBody(fontSize: 13.5, fontWeight: FontWeight.bold)),
            ),
            InkWell(
              onTap: () => onChanged(count + 1),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add, size: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // STEP 1: Complete Booking (Add-ons & Free Gift) (Image 3, Top-Middle)
  Widget _buildAddonsAndGift() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selected summary
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.cardBorderColor),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=150&fm=webp&fit=crop&q=80',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('RK Beach Experience', style: AppTheme.serifTitle(fontSize: 14, fontWeight: FontWeight.bold)),
                      Text('Sun, 29 Oct 2026 • 11:00 AM', style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
                      Text('Adult (12+) x $_adultCount • Child (5-11) x $_childCount', style: AppTheme.sansBody(fontSize: 10.5, color: AppTheme.textSecondaryLight)),
                    ],
                  ),
                ),
                Text('₹$_baseTotal', style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Add-ons (Optional)
          Text('Add-ons (Optional)', style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text('Enhance your experience', style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
          const SizedBox(height: 10),

          _buildAddonCard(
            title: 'Underwater Photography',
            price: '₹249 per person',
            desc: 'Get professional photos of your beach & water moments',
            image: 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=120&fm=webp&fit=crop&q=80',
            value: _addonPhoto,
            onChanged: (v) => setState(() => _addonPhoto = v!),
          ),
          const SizedBox(height: 10),

          _buildAddonCard(
            title: 'Local Guide Tour',
            price: '₹199 per person',
            desc: 'Explore hidden gems with a local expert buddy',
            image: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=120&fm=webp&fit=crop&q=80',
            value: _addonGuide,
            onChanged: (v) => setState(() => _addonGuide = v!),
          ),
          const SizedBox(height: 10),

          _buildAddonCard(
            title: 'Snorkeling Experience',
            price: '₹299 per person',
            desc: 'Enjoy snorkeling with safety gear and guide',
            image: 'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=120&fm=webp&fit=crop&q=80',
            value: _addonSnorkel,
            onChanged: (v) => setState(() => _addonSnorkel = v!),
          ),
          const SizedBox(height: 18),

          // Free Gift Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9F5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFFFE0D0)),
            ),
            child: Row(
              children: [
                const Icon(Icons.card_giftcard_rounded, color: AppTheme.primaryColor, size: 24),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Free Gift', style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(6)),
                            child: const Text('₹0', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      Text('Digital Travel Guide - Visakhapatnam', style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.w600)),
                      Text('Detailed guide with food spots, maps and local tips.', style: AppTheme.sansBody(fontSize: 10, color: AppTheme.textSecondaryLight)),
                    ],
                  ),
                ),
                Checkbox(
                  value: _freeGiftChecked,
                  activeColor: AppTheme.primaryColor,
                  onChanged: (v) => setState(() => _freeGiftChecked = v!),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildAddonCard({
    required String title,
    required String price,
    required String desc,
    required String image,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: value ? AppTheme.primaryColor : AppTheme.cardBorderColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(image, width: 50, height: 50, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.sansBody(fontSize: 12.5, fontWeight: FontWeight.bold)),
                Text(desc, style: AppTheme.sansBody(fontSize: 10, color: AppTheme.textSecondaryLight), maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(price, style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
              ],
            ),
          ),
          Checkbox(
            value: value,
            activeColor: AppTheme.primaryColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // STEP 2: Traveller Details (Image 3, Top-Right)
  Widget _buildTravellerDetails() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact Information', style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.cardBorderColor),
            ),
            child: Column(
              children: [
                _buildInputField(Icons.person_outline_rounded, 'Full Name', _contactName),
                const SizedBox(height: 10),
                _buildInputField(Icons.email_outlined, 'Email', _contactEmail),
                const SizedBox(height: 10),
                _buildInputField(Icons.phone_outlined, 'Mobile Number', _contactPhone),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Travellers List
          Text('Travellers', style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          // Adult 1
          _buildTravellerItemCard('Adult 1', 'Mr', 'Rohan', 'Kapoor', '12 Aug 1992'),
          const SizedBox(height: 10),

          // Adult 2
          _buildTravellerItemCard('Adult 2', 'Ms', 'Ananya', 'Singh', '24 Feb 1995'),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildInputField(IconData icon, String label, TextEditingController controller) {
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
              style: AppTheme.sansBody(fontSize: 12.5, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(fontSize: 10.5, color: AppTheme.textSecondaryLight),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTravellerItemCard(String title, String salutation, String first, String last, String dob) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTheme.sansBody(fontSize: 13, fontWeight: FontWeight.bold)),
              const Icon(Icons.delete_outline_rounded, size: 16, color: AppTheme.textSecondaryLight),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 65,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(color: AppTheme.backgroundLight, borderRadius: BorderRadius.circular(10)),
                child: Center(child: Text(salutation, style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(color: AppTheme.backgroundLight, borderRadius: BorderRadius.circular(10)),
                  child: Text(first, style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(color: AppTheme.backgroundLight, borderRadius: BorderRadius.circular(10)),
                  child: Text(last, style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(color: AppTheme.backgroundLight, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date of Birth: $dob', style: AppTheme.sansBody(fontSize: 11.5, color: AppTheme.textSecondaryLight)),
                const Icon(Icons.calendar_month_rounded, size: 16, color: AppTheme.primaryColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // STEP 3: Payment (Image 3, Bottom-Left)
  Widget _buildPaymentScreen() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Booking Summary mini card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.cardBorderColor),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=150&fm=webp&fit=crop&q=80',
                    width: 55,
                    height: 55,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('RK Beach Experience', style: AppTheme.serifTitle(fontSize: 14, fontWeight: FontWeight.bold)),
                      Text('Sun, 29 Oct • 11:00 AM • 2 Adults 1 Child', style: AppTheme.sansBody(fontSize: 10.5, color: AppTheme.textSecondaryLight)),
                    ],
                  ),
                ),
                Text('₹$_grandTotal', style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Apply Promo Code
          Text('Apply Promo Code', style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.cardBorderColor),
            ),
            child: Row(
              children: [
                const Icon(Icons.discount_outlined, color: AppTheme.primaryColor, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _promoController,
                    decoration: const InputDecoration(
                      hintText: 'Enter promo code (e.g. VIZAG10)',
                      hintStyle: TextStyle(fontSize: 11, color: AppTheme.textSecondaryLight),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() => _promoApplied = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Promo code applied! 10% discount added.')),
                    );
                  },
                  child: Text(
                    _promoApplied ? 'APPLIED ✓' : 'Apply',
                    style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Select Payment Method
          Text('Select Payment Method', style: AppTheme.serifTitle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          _buildPaymentOption('UPI', 'UPI (Google Pay, PhonePe, Paytm)', Icons.account_balance_wallet_rounded, true),
          const SizedBox(height: 8),
          _buildPaymentOption('Card', 'Credit / Debit Card', Icons.credit_card_rounded, false),
          const SizedBox(height: 8),
          _buildPaymentOption('NetBanking', 'Net Banking', Icons.account_balance_rounded, false),
          const SizedBox(height: 8),
          _buildPaymentOption('Wallets', 'Wallets (Paytm, Amazon Pay, etc.)', Icons.wallet_rounded, false),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String id, String title, IconData icon, bool isDefault) {
    final isSel = _selectedPaymentMethod == id;
    return InkWell(
      onTap: () => setState(() => _selectedPaymentMethod = id),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSel ? AppTheme.primaryColor : AppTheme.cardBorderColor,
            width: isSel ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSel ? AppTheme.primaryColor : AppTheme.textSecondaryLight, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title, style: AppTheme.sansBody(fontSize: 12.5, fontWeight: isSel ? FontWeight.bold : FontWeight.w500)),
            ),
            Radio<String>(
              value: id,
              groupValue: _selectedPaymentMethod,
              activeColor: AppTheme.primaryColor,
              onChanged: (val) => setState(() => _selectedPaymentMethod = val!),
            ),
          ],
        ),
      ),
    );
  }

  // Bottom Checkout Bar across Steps 0-3
  Widget _buildBottomCheckoutBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(top: BorderSide(color: AppTheme.cardBorderColor, width: 1)),
        boxShadow: const [BoxShadow(color: Color(0x10231815), blurRadius: 10, offset: Offset(0, -3))],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total', style: AppTheme.sansBody(fontSize: 10.5, color: AppTheme.textSecondaryLight)),
                Text(
                  '₹$_grandTotal',
                  style: AppTheme.serifTitle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                if (_currentStep < 3) {
                  setState(() => _currentStep++);
                } else {
                  // If guide tour addon was picked -> show "Booking Request Sent" (Step 5), else "Booking Confirmed!" (Step 4)
                  setState(() => _currentStep = _addonGuide ? 5 : 4);
                }
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      _currentStep == 0
                          ? 'Add to Cart'
                          : (_currentStep == 3 ? 'Pay Securely' : 'Continue'),
                      style: AppTheme.sansBody(fontSize: 13.5, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // STEP 4 / 5: Success & Review Screen (Image 3, Bottom-Middle & Bottom-Right)
  Widget _buildConfirmedScreen({required bool isDirect}) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: isDirect ? AppTheme.successLight : AppTheme.pendingLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isDirect ? Icons.check_circle_rounded : Icons.hourglass_top_rounded,
                  color: isDirect ? AppTheme.successGreen : AppTheme.pendingAmber,
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isDirect ? 'Booking Confirmed!' : 'Booking Request Sent!',
                style: AppTheme.serifTitle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                isDirect
                    ? 'Your trip to RK Beach Experience is all set with your AI Buddy.'
                    : "Your booking is under review as you've added a Buddy to this trip.",
                style: AppTheme.sansBody(fontSize: 12.5, color: AppTheme.textSecondaryLight),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              if (!isDirect)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.pendingLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, color: AppTheme.pendingAmber, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "We'll confirm your booking shortly. You'll receive a notification once it's approved.",
                          style: AppTheme.sansBody(fontSize: 11, color: AppTheme.pendingAmber, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),

              // Summary Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.cardBorderColor),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=150&fm=webp&fit=crop&q=80',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('RK Beach Experience', style: AppTheme.serifTitle(fontSize: 14.5, fontWeight: FontWeight.bold)),
                              Text('Beaches • Visakhapatnam', style: AppTheme.sansBody(fontSize: 11, color: AppTheme.textSecondaryLight)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20, color: AppTheme.cardBorderColor),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_rounded, size: 14, color: AppTheme.primaryColor),
                        const SizedBox(width: 6),
                        Text('Sun, 29 Oct 2026 • 11:00 AM', style: AppTheme.sansBody(fontSize: 11.5)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.people_outline_rounded, size: 14, color: AppTheme.primaryColor),
                        const SizedBox(width: 6),
                        Text('2 Adults • 1 Child', style: AppTheme.sansBody(fontSize: 11.5)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.payment_rounded, size: 14, color: AppTheme.primaryColor),
                            const SizedBox(width: 6),
                            Text('Paid via $_selectedPaymentMethod', style: AppTheme.sansBody(fontSize: 11.5, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text('₹$_grandTotal', style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // View Booking Action
              InkWell(
                onTap: () => widget.onNavigate?.call('booking-confirmation'),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
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
                      Text('View Booking Details', style: AppTheme.sansBody(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(width: 6),
                      const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Plan Another Trip button
              InkWell(
                onTap: () => widget.onNavigate?.call('07-home'),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.cardBorderColor),
                  ),
                  child: Text('Plan Another Trip', style: AppTheme.sansBody(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textPrimaryLight)),
                ),
              ),
              const SizedBox(height: 20),

              // Social Share
              Text('Share this trip', style: AppTheme.sansBody(fontSize: 11.5, color: AppTheme.textSecondaryLight)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildShareIcon(Icons.chat_bubble_outline_rounded, Colors.green),
                  const SizedBox(width: 14),
                  _buildShareIcon(Icons.camera_alt_outlined, Colors.purple),
                  const SizedBox(width: 14),
                  _buildShareIcon(Icons.share_outlined, AppTheme.primaryColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShareIcon(IconData icon, Color color) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.cardBorderColor),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}
