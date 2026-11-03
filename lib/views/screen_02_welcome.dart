import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Screen02Welcome extends StatefulWidget {
  final Function(String)? onNavigate;

  const Screen02Welcome({super.key, this.onNavigate});

  @override
  State<Screen02Welcome> createState() => _Screen02WelcomeState();
}

class _Screen02WelcomeState extends State<Screen02Welcome> {
  late final PageController _pageController;
  int _activeSlide = 0;
  bool _isButtonPressed = false;

  final List<Map<String, dynamic>> _slides = [
    {
      'type': 'image',
      'asset': 'assets/images/onboarding_vizag.jpg',
      'title': 'Discover Vizag',
      'subtitle':
          'Explore the City of Destiny with verified travel buddies and scenic coastal spots.',
      'buttonText': 'Continue',
      'showArrow': true,
    },
    {
      'type': 'image',
      'asset': 'assets/images/onboarding_trails.jpg',
      'title': 'Explore trails &\nsafe companions',
      'subtitle':
          'Connect with verified local buddies for mountain treks, sunrise spots & hidden valleys.',
      'buttonText': 'Continue',
      'showArrow': true,
    },
    {
      'type': 'gathering',
      'title': 'Go to gatherings',
      'subtitle':
          'Music, games, coffee, sport and more near you. Book in a few taps.',
      'buttonText': 'Get Started',
      'showArrow': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onContinuePressed() {
    if (_activeSlide < _slides.length - 1) {
      _pageController.animateToPage(
        _activeSlide + 1,
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeInOutCubic,
      );
    } else {
      widget.onNavigate?.call('03-traveller-login');
    }
  }

  void _onSkipPressed() {
    widget.onNavigate?.call('03-traveller-login');
  }

  void _onDotTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentSlide = _slides[_activeSlide];
    final isGatheringSlide = currentSlide['type'] == 'gathering';

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (_activeSlide > 0) {
          _pageController.animateToPage(
            _activeSlide - 1,
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeInOutCubic,
          );
        } else {
          widget.onNavigate?.call('back');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Top Bar with Skip Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back arrow if on subsequent slides
                    _activeSlide > 0
                        ? GestureDetector(
                            onTap: () {
                              _pageController.animateToPage(
                                _activeSlide - 1,
                                duration: const Duration(milliseconds: 320),
                                curve: Curves.easeInOutCubic,
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 18,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          )
                        : const SizedBox(width: 26),
                    GestureDetector(
                      onTap: _onSkipPressed,
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        child: Text(
                          'Skip',
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF8E9BAE),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Page Content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _slides.length,
                  onPageChanged: (index) {
                    setState(() {
                      _activeSlide = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    if (slide['type'] == 'gathering') {
                      return _buildGatheringSlide(slide);
                    }
                    return _buildImageSlide(slide);
                  },
                ),
              ),

              // Bottom Section: Dots and Continue Button
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
                child: isGatheringSlide
                    ? _buildGatheringBottomSection(currentSlide)
                    : _buildImageBottomSection(currentSlide),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Slide Builders ---

  Widget _buildImageSlide(Map<String, dynamic> slide) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardHeight = constraints.maxHeight * 0.58;

        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image Card with ambient warm glow
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Center(
                  child: Container(
                    height: cardHeight.clamp(280.0, 420.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF8C00).withValues(alpha: 0.16),
                          blurRadius: 36,
                          spreadRadius: 4,
                          offset: const Offset(0, 14),
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: Colors.white, width: 3.5),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28.5),
                        child: Image.asset(
                          slide['asset'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFFF1F5F9),
                              child: const Center(
                                child: Icon(Icons.photo_outlined, size: 48, color: Color(0xFF94A3B8)),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Title & Subtitle (Left-aligned)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      slide['title'],
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                        height: 1.2,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      slide['subtitle'],
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGatheringSlide(Map<String, dynamic> slide) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: constraints.maxHeight * 0.10),

              // Glowing Orange 3D Icon Card
              Center(
                child: Container(
                  width: 175,
                  height: 175,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF7A00).withValues(alpha: 0.48),
                        blurRadius: 48,
                        spreadRadius: 8,
                        offset: const Offset(0, 18),
                      ),
                      BoxShadow(
                        color: const Color(0xFFFFA03A).withValues(alpha: 0.32),
                        blurRadius: 24,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(38),
                    child: Stack(
                      children: [
                        // Gradient fill
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(38),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFFFA238),
                                Color(0xFFFF7A00),
                                Color(0xFFF25A00),
                              ],
                            ),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.45),
                              width: 1.5,
                            ),
                          ),
                        ),

                        // Diagonal glossy sheen
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _OrangeCardSheenPainter(),
                          ),
                        ),

                        // Sparkle star in top-right
                        const Positioned(
                          top: 22,
                          right: 22,
                          child: _SparkleWidget(size: 20, color: Colors.white),
                        ),

                        // Calendar / Gathering Icon in Center
                        Center(
                          child: CustomPaint(
                            size: const Size(64, 64),
                            painter: _CalendarIconPainter(
                              color: Colors.white,
                              strokeWidth: 4.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: constraints.maxHeight * 0.10),

              // Title & Subtitle (Centered)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    Text(
                      slide['title'],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      slide['subtitle'],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Bottom Section Builders ---

  Widget _buildImageBottomSection(Map<String, dynamic> slide) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Page Indicators on the left
        _buildPageIndicators(),

        // Orange Glossy Continue Pill Button on the right
        _buildGlossyButton(
          text: slide['buttonText'],
          showArrow: slide['showArrow'] == true,
          width: 215,
        ),
      ],
    );
  }

  Widget _buildGatheringBottomSection(Map<String, dynamic> slide) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Page Indicators centered above button
        _buildPageIndicators(),
        const SizedBox(height: 22),

        // Wide Orange Glossy Continue Button
        _buildGlossyButton(
          text: slide['buttonText'],
          showArrow: slide['showArrow'] == true,
          width: double.infinity,
        ),
      ],
    );
  }

  // --- Indicators & Glossy Button Components ---

  Widget _buildPageIndicators() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_slides.length, (index) {
        final isActive = index == _activeSlide;
        return GestureDetector(
          onTap: () => _onDotTapped(index),
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 24 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF2563EB) : const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildGlossyButton({
    required String text,
    required bool showArrow,
    required double width,
  }) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isButtonPressed = true),
      onTapUp: (_) => setState(() => _isButtonPressed = false),
      onTapCancel: () => setState(() => _isButtonPressed = false),
      onTap: _onContinuePressed,
      child: AnimatedScale(
        scale: _isButtonPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: width,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF7A00).withValues(alpha: 0.44),
                blurRadius: 22,
                spreadRadius: 1,
                offset: const Offset(0, 9),
              ),
              BoxShadow(
                color: const Color(0xFFFF9500).withValues(alpha: 0.22),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Stack(
              children: [
                // Base Vibrant Orange Gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFFFA03A),
                        Color(0xFFFF7A00),
                        Color(0xFFF25A00),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.45),
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),

                // Specular Glass Sheen Overlay
                Positioned.fill(
                  child: CustomPaint(
                    painter: _ButtonSheenPainter(),
                  ),
                ),

                // Button Content: Text, Arrow, Sparkle
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                      if (showArrow) ...[
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 19,
                        ),
                      ],
                      const SizedBox(width: 12),
                      const _SparkleWidget(size: 15, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Custom Painters for Glassy Aesthetics ---

class _ButtonSheenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final sheenPaint1 = Paint()
      ..color = Colors.white.withValues(alpha: 0.24)
      ..style = PaintingStyle.fill;

    // Diagonal glassy reflection band 1
    final path1 = Path();
    path1.moveTo(size.width * 0.25, 0);
    path1.lineTo(size.width * 0.38, 0);
    path1.lineTo(size.width * 0.20, size.height);
    path1.lineTo(size.width * 0.07, size.height);
    path1.close();
    canvas.drawPath(path1, sheenPaint1);

    // Diagonal glassy reflection band 2
    final sheenPaint2 = Paint()
      ..color = Colors.white.withValues(alpha: 0.13)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(size.width * 0.44, 0);
    path2.lineTo(size.width * 0.50, 0);
    path2.lineTo(size.width * 0.32, size.height);
    path2.lineTo(size.width * 0.26, size.height);
    path2.close();
    canvas.drawPath(path2, sheenPaint2);

    // Subtle curved top-edge specular gloss
    final topGlossPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withValues(alpha: 0.30),
          Colors.white.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.55));

    final topPath = Path();
    topPath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height * 0.55),
        const Radius.circular(26),
      ),
    );
    canvas.drawPath(topPath, topGlossPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _OrangeCardSheenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Colors.white.withValues(alpha: 0.20)
      ..style = PaintingStyle.fill;

    // Diagonal shine band top-left
    final path1 = Path();
    path1.moveTo(size.width * 0.18, 0);
    path1.lineTo(size.width * 0.48, 0);
    path1.lineTo(0, size.width * 0.48);
    path1.lineTo(0, size.width * 0.18);
    path1.close();
    canvas.drawPath(path1, paint1);

    // Longer diagonal shine band across center
    final paint2 = Paint()
      ..color = Colors.white.withValues(alpha: 0.11)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(size.width * 0.58, 0);
    path2.lineTo(size.width * 0.78, 0);
    path2.lineTo(size.width * 0.22, size.height);
    path2.lineTo(0, size.height * 0.82);
    path2.close();
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SparkleWidget extends StatelessWidget {
  final double size;
  final Color color;

  const _SparkleWidget({
    this.size = 18,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _SparklePainter(color: color),
    );
  }
}

class _SparklePainter extends CustomPainter {
  final Color color;

  _SparklePainter({this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final w = size.width;
    final h = size.height;

    // Soft subtle halo glow
    final glowPaint = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawCircle(Offset(cx, cy), w * 0.3, glowPaint);

    // 4-point concave star
    final starPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(cx, 0);
    path.quadraticBezierTo(cx, cy, w, cy);
    path.quadraticBezierTo(cx, cy, cx, h);
    path.quadraticBezierTo(cx, cy, 0, cy);
    path.quadraticBezierTo(cx, cy, cx, 0);
    path.close();

    canvas.drawPath(path, starPaint);
  }

  @override
  bool shouldRepaint(covariant _SparklePainter oldDelegate) =>
      oldDelegate.color != color;
}

class _CalendarIconPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _CalendarIconPainter({
    this.color = Colors.white,
    this.strokeWidth = 3.8,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Body rectangle with rounded corners
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.14, h * 0.22, w * 0.72, h * 0.64),
      Radius.circular(w * 0.12),
    );
    canvas.drawRRect(bodyRect, strokePaint);

    // Horizontal divider bar
    canvas.drawLine(
      Offset(w * 0.14, h * 0.42),
      Offset(w * 0.86, h * 0.42),
      strokePaint,
    );

    // Two binder rings on top
    final ringWidth = w * 0.085;
    final ringHeight = h * 0.19;

    // Left binder ring
    final leftRing = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.30, h * 0.09, ringWidth, ringHeight),
      Radius.circular(ringWidth / 2),
    );
    canvas.drawRRect(leftRing, fillPaint);

    // Right binder ring
    final rightRing = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.615, h * 0.09, ringWidth, ringHeight),
      Radius.circular(ringWidth / 2),
    );
    canvas.drawRRect(rightRing, fillPaint);

    // Circular date badge inside bottom-right area
    canvas.drawCircle(
      Offset(w * 0.63, h * 0.67),
      w * 0.095,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CalendarIconPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}
