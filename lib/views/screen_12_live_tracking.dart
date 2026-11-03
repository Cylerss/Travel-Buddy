import 'package:flutter/material.dart';

class Screen12LiveTracking extends StatelessWidget {
  final Function(String)? onNavigate;

  const Screen12LiveTracking({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    const greenColor = Color(0xFF059669);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F3F0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => onNavigate?.call('back'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Dr NTR Beach Rd • Vizag', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
            Text('Destination: Sea Pearl Coastal Cafe (1.2 km)', style: TextStyle(color: Colors.grey, fontSize: 9)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.warning, color: Colors.red),
            onPressed: () => onNavigate?.call('13-sos-center'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Turn-by-Turn Instruction Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: const Color(0xFF0F9D58),
              child: Row(
                children: const [
                  Icon(Icons.turn_left, color: Colors.white, size: 24),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('IN 120 METERS', style: TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold)),
                      Text('Turn Left onto Beach Road Boardwalk', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Spacer(),
                  Text('2 min', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                ],
              ),
            ),

            // Map Area Simulation
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: const Color(0xFFF4F3F0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.map, size: 80, color: Colors.blueAccent),
                            const SizedBox(height: 12),
                            const Text('Live Vizag Coastline Map Simulation', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                            const Text('Dr NTR Beach Road • Companion GPS Active', style: TextStyle(fontSize: 11, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Pins
                  Positioned(
                    top: 100,
                    left: 120,
                    child: Column(
                      children: const [
                        Icon(Icons.location_on, color: Colors.indigo, size: 36),
                        Text('Vizag', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                      ],
                    ),
                  ),

                  Positioned(
                    top: 180,
                    left: 200,
                    child: Column(
                      children: const [
                        Icon(Icons.my_location, color: Colors.blue, size: 32),
                        Text('You (Elena)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

                  Positioned(
                    top: 140,
                    left: 220,
                    child: Column(
                      children: const [
                        CircleAvatar(radius: 14, backgroundColor: greenColor, child: Icon(Icons.person, color: Colors.white, size: 16)),
                        Text('Priya • 300m', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: greenColor)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Trip Sheet
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400&fm=webp&fit=crop&q=60'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Priya Sharma • 5.0 ★', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        Text('Arriving in ~2 mins • Distance: 300m', style: TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.phone, color: Colors.orange),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
