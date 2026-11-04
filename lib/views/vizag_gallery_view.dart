import 'package:flutter/material.dart';
import 'screen_02_welcome.dart';
import 'screen_03_traveller_login.dart';
import 'screen_04_traveller_details.dart';
import 'screen_05_passport_verification.dart';
import 'screen_06_traveller_profile.dart';
import 'screen_07_home.dart';
import 'screen_08_explore_vizag.dart';
import 'screen_09_place_details.dart';
import 'screen_10_find_buddy.dart';
import 'screen_11_buddy_profile.dart';
import 'screen_12_live_tracking.dart';
import 'screen_13_sos_center.dart';
import 'screen_14_local_experiences.dart';
import 'screen_15_gamification.dart';
import 'screen_16_profile_dashboard.dart';
import 'screen_17_buddy_login.dart';
import 'screen_18_buddy_details.dart';
import 'screen_19_buddy_ratings.dart';
import 'screen_20_buddy_leaderboard.dart';
import 'screen_ai_assistant.dart';
import 'screen_booking_confirmation.dart';
import 'screen_checkout_flow.dart';

class VizagGalleryView extends StatefulWidget {
  const VizagGalleryView({super.key});

  @override
  State<VizagGalleryView> createState() => _VizagGalleryViewState();
}

class _VizagGalleryViewState extends State<VizagGalleryView> {
  final List<String> _history = ['07-home'];

  String get _currentScreenId => _history.isNotEmpty ? _history.last : '07-home';

  static const Map<String, String> _fallbackMap = {
    '03-traveller-signup': '02-welcome',
    '03-traveller-login': '02-welcome',
    '04-traveller-details': '03-traveller-signup',
    '05-passport-verification': '04-traveller-details',
    '06-traveller-profile': '05-passport-verification',
    '07-home': '06-traveller-profile',
    '08-explore-vizag': '07-home',
    '09-place-details': '08-explore-vizag',
    '10-find-buddy': '07-home',
    '11-buddy-profile': '10-find-buddy',
    '12-live-tracking': '11-buddy-profile',
    '13-sos-center': '07-home',
    '14-local-experiences': '07-home',
    '15-gamification': '16-profile-dashboard',
    '16-profile-dashboard': '07-home',
    '17-buddy-login': '03-traveller-login',
    '18-buddy-details': '17-buddy-login',
    '19-buddy-ratings': '18-buddy-details',
    '20-buddy-leaderboard': '19-buddy-ratings',
    'ai-assistant': '07-home',
    'booking-confirmation': '07-home',
    'checkout-options': '08-explore-vizag',
  };

  Widget _buildCurrentScreen() {
    switch (_currentScreenId) {
      case '02-welcome':
        return Screen02Welcome(onNavigate: _navigateTo);
      case '03-traveller-signup':
        return Screen03TravellerLogin(onNavigate: _navigateTo, initialModeIsSignUp: true);
      case '03-traveller-login':
        return Screen03TravellerLogin(onNavigate: _navigateTo, initialModeIsSignUp: false);
      case '04-traveller-details':
        return Screen04TravellerDetails(onNavigate: _navigateTo);
      case '05-passport-verification':
        return Screen05PassportVerification(onNavigate: _navigateTo);
      case '06-traveller-profile':
        return Screen06TravellerProfile(onNavigate: _navigateTo);
      case '07-home':
        return Screen07Home(onNavigate: _navigateTo);
      case '08-explore-vizag':
        return Screen08ExploreVizag(onNavigate: _navigateTo);
      case '09-place-details':
        return Screen09PlaceDetails(onNavigate: _navigateTo);
      case '10-find-buddy':
        return Screen10FindBuddy(onNavigate: _navigateTo);
      case '11-buddy-profile':
        return Screen11BuddyProfile(onNavigate: _navigateTo);
      case '12-live-tracking':
        return Screen12LiveTracking(onNavigate: _navigateTo);
      case '13-sos-center':
        return Screen13SosCenter(onNavigate: _navigateTo);
      case '14-local-experiences':
        return Screen14LocalExperiences(onNavigate: _navigateTo);
      case '15-gamification':
        return Screen15Gamification(onNavigate: _navigateTo);
      case '16-profile-dashboard':
        return Screen16ProfileDashboard(onNavigate: _navigateTo);
      case '17-buddy-login':
        return Screen17BuddyLogin(onNavigate: _navigateTo);
      case '18-buddy-details':
        return Screen18BuddyDetails(onNavigate: _navigateTo);
      case '19-buddy-ratings':
        return Screen19BuddyRatings(onNavigate: _navigateTo);
      case '20-buddy-leaderboard':
        return Screen20BuddyLeaderboard(onNavigate: _navigateTo);
      case 'ai-assistant':
        return ScreenAiAssistant(onNavigate: _navigateTo);
      case 'booking-confirmation':
        return ScreenBookingConfirmation(onNavigate: _navigateTo);
      case 'checkout-options':
        return ScreenCheckoutFlow(onNavigate: _navigateTo);
      default:
        return Screen07Home(onNavigate: _navigateTo);
    }
  }

  void _navigateTo(String screenId) {
    setState(() {
      if (screenId == 'back' || screenId == 'pop') {
        if (_history.length > 1) {
          _history.removeLast();
        } else {
          final prev = _fallbackMap[_currentScreenId];
          if (prev != null) {
            _history.clear();
            _history.add(prev);
          }
        }
      } else {
        if (_history.isEmpty || _history.last != screenId) {
          _history.add(screenId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _history.length <= 1,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _history.length > 1) {
          _navigateTo('back');
        }
      },
      child: _buildCurrentScreen(),
    );
  }
}
