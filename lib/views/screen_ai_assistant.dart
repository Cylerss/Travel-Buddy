import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';

class ScreenAiAssistant extends StatefulWidget {
  final Function(String)? onNavigate;

  const ScreenAiAssistant({super.key, this.onNavigate});

  @override
  State<ScreenAiAssistant> createState() => _ScreenAiAssistantState();
}

class _ScreenAiAssistantState extends State<ScreenAiAssistant> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'text': 'Hi! 👋 Tell me what you want to explore in Visakhapatnam. I can suggest places, itineraries, transport options and even find local travel buddies for you.',
      'time': 'Just now',
    }
  ];

  final List<String> _quickSuggestions = [
    '🏖️ Best beaches',
    '🏛️ Must visit places',
    '🗺️ Plan itinerary',
    '🚕 Show cab fare',
    '🍲 Food recommendations',
    '👥 Find travel buddies',
  ];

  final List<Map<String, dynamic>> _popularPlaces = [
    {
      'name': 'Rushikonda Beach',
      'rating': '4.6 (2.1k reviews)',
      'distance': '20 min • 12 km',
      'image': 'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=400&fm=webp&fit=crop&q=80',
      'target': '09-place-details',
    },
    {
      'name': 'INS Kursura Museum',
      'rating': '4.5 (1.8k reviews)',
      'distance': '25 min • 16 km',
      'image': 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=400&fm=webp&fit=crop&q=80',
      'target': '09-place-details',
    },
    {
      'name': 'Kailasagiri Hilltop',
      'rating': '4.7 (3.2k reviews)',
      'distance': '15 min • 8 km',
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=400&fm=webp&fit=crop&q=80',
      'target': '09-place-details',
    },
  ];

  final Set<String> _addedToTrip = {};

  void _sendMessage(String query) {
    if (query.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'isUser': true,
        'text': query.trim(),
        'time': 'Just now',
      });
      _messageController.clear();
    });

    // Auto AI response simulation
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      String response = "Here are top recommendations for $query in Visakhapatnam! You can also book a certified local buddy to guide you.";
      if (query.contains('beaches')) {
        response = "Vizag has incredible coastlines! Rushikonda is famous for water sports and surfing, while RK Beach is perfect for evening walks and street food. Yarada Beach offers secluded serenity.";
      } else if (query.contains('places')) {
        response = "Top spots include Kailasagiri ropeway, INS Kursura Submarine Museum, Borra Caves in Araku Valley, and Simhachalam Temple.";
      } else if (query.contains('buddies')) {
        response = "We have 4 certified local buddies available nearby right now! Arjun Varma and Rohit K are rated 4.8+ and specialize in coastal exploration.";
      } else if (query.contains('itinerary')) {
        response = "I suggest a 2-Day Vizag highlights trip: Day 1 - RK Beach & Kailasagiri; Day 2 - Araku Valley expedition & Borra Caves.";
      }

      setState(() {
        _messages.add({
          'isUser': false,
          'text': response,
          'time': 'Just now',
        });
      });

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 120,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => widget.onNavigate?.call('07-home'),
        ),
        title: Text(
          'Travel Buddy',
          style: AppTheme.serifTitle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildAiHeroHeader(),
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                ..._messages.map((m) => _buildMessageBubble(m)),
                const SizedBox(height: 14),
                Text(
                  'Quick Suggestions',
                  style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textSecondaryLight),
                ),
                const SizedBox(height: 8),
                _buildQuickSuggestions(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Places in Visakhapatnam',
                      style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () => widget.onNavigate?.call('08-explore-vizag'),
                      child: Text(
                        'View All ->',
                        style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildPopularPlacesCarousel(),
                const SizedBox(height: 20),
              ],
            ),
          ),
          _buildInputBottomBar(),
        ],
      ),
      bottomNavigationBar: SharedBottomNav(
        activeTab: 'home',
        onNavigate: widget.onNavigate,
      ),
    );
  }

  Widget _buildAiHeroHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.cardBorderColor, width: 1)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Travel Buddy AI',
                      style: AppTheme.serifTitle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.chipBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'GPT-4o powered',
                        style: AppTheme.sansBody(fontSize: 9, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Your Personal Travel Assistant',
                  style: AppTheme.sansBody(fontSize: 12, color: AppTheme.textSecondaryLight),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppTheme.chipBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.chipBorder, width: 0.8),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on_rounded, color: AppTheme.primaryColor, size: 14),
                const SizedBox(width: 4),
                Text(
                  'Visakhapatnam',
                  style: AppTheme.sansBody(fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isUser = message['isUser'] as bool;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        constraints: const BoxConstraints(maxWidth: 310),
        decoration: BoxDecoration(
          color: isUser ? AppTheme.primaryColor : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 18),
          ),
          border: Border.all(
            color: isUser ? AppTheme.primaryColor : AppTheme.cardBorderColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0x0A231815),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          message['text'],
          style: AppTheme.sansBody(
            fontSize: 13.5,
            color: isUser ? Colors.white : AppTheme.textPrimaryLight,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickSuggestions() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _quickSuggestions.map((suggestion) {
        return InkWell(
          onTap: () => _sendMessage(suggestion),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.cardBorderColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x08231815),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              suggestion,
              style: AppTheme.sansBody(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryLight,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPopularPlacesCarousel() {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _popularPlaces.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final place = _popularPlaces[index];
          final isAdded = _addedToTrip.contains(place['name']);
          return Container(
            width: 175,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.cardBorderColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x0A231815),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
                      child: Image.network(
                        place['image'],
                        height: 95,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.favorite_border_rounded, size: 14, color: AppTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place['name'],
                        style: AppTheme.sansBody(fontSize: 12, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '⭐ ${place['rating']}',
                        style: AppTheme.sansBody(fontSize: 10, color: AppTheme.textSecondaryLight),
                      ),
                      const SizedBox(height: 6),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (isAdded) {
                              _addedToTrip.remove(place['name']);
                            } else {
                              _addedToTrip.add(place['name']);
                            }
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isAdded ? 'Removed from Trip' : '${place['name']} added to Trip!'),
                              duration: const Duration(seconds: 1),
                              backgroundColor: AppTheme.primaryColor,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isAdded ? AppTheme.successGreen : AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isAdded ? '✓ Added' : '+ Add to Trip',
                            style: AppTheme.sansBody(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppTheme.cardBorderColor, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundLight,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppTheme.cardBorderColor, width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome, color: AppTheme.primaryColor, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        onSubmitted: _sendMessage,
                        decoration: const InputDecoration(
                          hintText: 'Ask me anything about Visakhapatnam...',
                          hintStyle: TextStyle(fontSize: 12.5, color: AppTheme.textSecondaryLight),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.mic_none_rounded, color: AppTheme.textSecondaryLight, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => _sendMessage(_messageController.text),
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_upward_rounded, color: Colors.white, size: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
