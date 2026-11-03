import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'views/vizag_gallery_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TravelBuddyApp());
}

class TravelBuddyApp extends StatelessWidget {
  const TravelBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelBuddy Vizag - Safe Travel & Buddy Matching',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const VizagGalleryView(),
    );
  }
}
