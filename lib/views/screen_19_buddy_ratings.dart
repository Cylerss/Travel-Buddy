import 'package:flutter/material.dart';

class Screen19BuddyRatings extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen19BuddyRatings({super.key, this.onNavigate});

  @override
  State<Screen19BuddyRatings> createState() => _Screen19BuddyRatingsState();
}

class _Screen19BuddyRatingsState extends State<Screen19BuddyRatings> {
  bool _isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade50,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => widget.onNavigate?.call('back'),
        ),
        title: const Text('Host Ratings & Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: FilterChip(
              label: Text(_isAvailable ? 'Available 🟢' : 'Off Duty ⚪', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              selected: _isAvailable,
              onSelected: (val) => setState(() => _isAvailable = val),
              selectedColor: Colors.orange,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=120&fm=webp&fit=crop&q=60'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Priya Sharma • Super Buddy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Text('RK Beach & Pandurangapuram, Vizag', style: TextStyle(fontSize: 10, color: Colors.grey)),
                          SizedBox(height: 2),
                          Text('100% Safe Rating • 128 Trips', style: TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Rating breakdown
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('5.0 ★', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
                        Text('Based on 168 Reviews', style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _ratingBar('Safety & Protection', 1.0),
                    const SizedBox(height: 6),
                    _ratingBar('Local Expertise', 1.0),
                    const SizedBox(height: 6),
                    _ratingBar('Punctuality', 1.0),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('THIS MONTH EARNINGS', style: TextStyle(fontSize: 8, color: Colors.grey, fontWeight: FontWeight.bold)),
                          Text('₹38,400', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF059669))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('LEADERBOARD RANK', style: TextStyle(fontSize: 8, color: Colors.grey, fontWeight: FontWeight.bold)),
                          Text('#1 Champion 👑', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.amber)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => widget.onNavigate?.call('20-buddy-leaderboard'),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('View Vizag Buddy Leaderboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(width: 6),
                      Icon(Icons.chevron_right, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ratingBar(String title, double val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            const Text('5.0 (100%)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF059669))),
          ],
        ),
        const SizedBox(height: 2),
        LinearProgressIndicator(value: val, backgroundColor: Colors.grey.shade200, color: const Color(0xFF059669)),
      ],
    );
  }
}
