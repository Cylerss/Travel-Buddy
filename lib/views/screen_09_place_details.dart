import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class Screen09PlaceDetails extends StatelessWidget {
  final Function(String)? onNavigate;

  const Screen09PlaceDetails({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Header
              SizedBox(
                height: 240,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=450&fm=webp&fit=crop&q=60',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => onNavigate?.call('back'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Expanded(
                            child: Text(
                              'RK Beach (Ramakrishna)',
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                          ),
                          Chip(label: Text('4.8 ★', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.amber),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Content Body
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: const [
                                Text('BEST HOURS', style: TextStyle(fontSize: 8, color: Colors.grey)),
                                Text('4:30 - 7:30 PM', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: const [
                                Text('VIBE', style: TextStyle(fontSize: 8, color: Colors.grey)),
                                Text('Promenade', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: const [
                                Text('SAFETY', style: TextStyle(fontSize: 8, color: Colors.grey)),
                                Text('High (100%)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.orange)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    const Text('ABOUT RK BEACH', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                    const SizedBox(height: 4),
                    const Text(
                      'Visakhapatnam’s most celebrated coastal boulevard. Famous for the INS Kursura Submarine Museum, TU-142 Aircraft museum, evening sea-breeze walking tracks, and fresh seafood shacks.',
                      style: TextStyle(fontSize: 11, color: Colors.black87, height: 1.4),
                    ),
                    const SizedBox(height: 16),

                    const Text('TOP THINGS TO DO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                    const SizedBox(height: 6),
                    const Text('• Visit the INS Kursura Submarine Museum', style: TextStyle(fontSize: 11)),
                    const SizedBox(height: 4),
                    const Text('• Beachfront sunset dance & photography stroll', style: TextStyle(fontSize: 11)),
                    const SizedBox(height: 4),
                    const Text('• Taste fresh Vizag sweet corn & roasted fish', style: TextStyle(fontSize: 11)),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade600,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => onNavigate?.call('10-find-buddy'),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.people, size: 18),
                            SizedBox(width: 8),
                            Text('Find Verified Buddies for RK Beach', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SharedBottomNav(activeTab: 'explore', onNavigate: onNavigate),
    );
  }
}
