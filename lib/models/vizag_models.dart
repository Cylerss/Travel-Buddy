class TravellerData {
  String name;
  String country;
  String avatar;
  List<String> hobbies;
  String passportNumber;
  bool passportVerified;
  int safetyScore;
  int tripsCount;
  String email;
  String phone;
  String nationality;
  String dob;
  List<String> travelPreferences;
  bool hasPassportAdded;
  String passportIssuingCountry;
  String passportIssueDate;
  String passportExpiry;
  bool isProfileComplete;
  bool isOnboardingSkipped;

  TravellerData({
    required this.name,
    required this.country,
    required this.avatar,
    required this.hobbies,
    required this.passportNumber,
    required this.passportVerified,
    required this.safetyScore,
    required this.tripsCount,
    this.email = 'rahul.sharma@example.com',
    this.phone = '+91 98765 43210',
    this.nationality = 'Indian 🇮🇳',
    this.dob = '15 Aug 1996',
    this.travelPreferences = const ['Beach Walks', 'Local Cuisine', 'Heritage Tours', 'Water Sports'],
    this.hasPassportAdded = true,
    this.passportIssuingCountry = 'India',
    this.passportIssueDate = '2020-01-01',
    this.passportExpiry = '2030-12-31',
    this.isProfileComplete = true,
    this.isOnboardingSkipped = false,
  });
}

class BuddyData {
  final String id;
  final String name;
  final String avatar;
  final double rating;
  final int reviewsCount;
  final int tripsCount;
  final double distanceKm;
  final int matchPercentage;
  final bool isSafeVerified;
  final bool isFiveStar;
  final List<String> languages;
  final List<String> skills;
  final List<String> hobbies;
  final String locationArea;
  final String bio;
  final String hourlyRate;
  final String specialty;
  final String category;
  final List<String> tags;

  BuddyData({
    required this.id,
    required this.name,
    required this.avatar,
    required this.rating,
    required this.reviewsCount,
    required this.tripsCount,
    required this.distanceKm,
    required this.matchPercentage,
    required this.isSafeVerified,
    required this.isFiveStar,
    required this.languages,
    required this.skills,
    required this.hobbies,
    required this.locationArea,
    required this.bio,
    required this.hourlyRate,
    this.specialty = 'Local Guide • 3+ years',
    this.category = 'Guides',
    this.tags = const ['Beaching', 'Local Food'],
  });
}

class LeaderboardBuddy {
  final int rank;
  final String name;
  final String avatar;
  final String badge;
  final int trips;
  final double rating;
  final int points;
  final String zone;
  final bool verified;

  LeaderboardBuddy({
    required this.rank,
    required this.name,
    required this.avatar,
    required this.badge,
    required this.trips,
    required this.rating,
    required this.points,
    required this.zone,
    required this.verified,
  });
}

class VizagPlace {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final String location;
  final String description;
  final String timing;
  final String bestTime;
  final List<String> highlights;
  final bool isSafeZone;

  VizagPlace({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    required this.location,
    required this.description,
    required this.timing,
    required this.bestTime,
    required this.highlights,
    required this.isSafeZone,
  });
}

class LocalExperience {
  final String id;
  final String title;
  final String category;
  final String imageUrl;
  final String duration;
  final String price;
  final String rating;
  final String hostName;
  final String description;

  LocalExperience({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.duration,
    required this.price,
    required this.rating,
    required this.hostName,
    required this.description,
  });
}

class ScreenMeta {
  final String id;
  final String code;
  final String title;
  final String category;
  final int rowNumber;
  final String description;

  ScreenMeta({
    required this.id,
    required this.code,
    required this.title,
    required this.category,
    required this.rowNumber,
    required this.description,
  });
}

class VizagRestaurant {
  final String id;
  final String name;
  final String cuisine;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final String location;
  final String distance;
  final String priceRange;

  VizagRestaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    required this.location,
    required this.distance,
    required this.priceRange,
  });
}

class EmergencyIncident {
  String incidentId;
  String userId;
  String status; // 'idle', 'sending', 'active', 'resolved', 'cancelled'
  String createdAt;
  String lastLocationUpdateAt;
  double latitude;
  double longitude;
  double locationAccuracy;
  bool liveTrackingActive;
  bool buddyAssistanceEnabled;

  EmergencyIncident({
    required this.incidentId,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.lastLocationUpdateAt,
    required this.latitude,
    required this.longitude,
    required this.locationAccuracy,
    required this.liveTrackingActive,
    required this.buddyAssistanceEnabled,
  });
}

class BuddyAssistanceRequest {
  String requestId;
  String incidentId;
  String buddyId;
  String buddyName;
  String buddyAvatar;
  String status; // 'pending', 'accepted', 'declined', 'expired', 'completed'
  String createdAt;
  String respondedAt;
  double buddyDistanceKm;
  String lastBuddyLocationUpdateAt;

  BuddyAssistanceRequest({
    required this.requestId,
    required this.incidentId,
    required this.buddyId,
    required this.buddyName,
    required this.buddyAvatar,
    required this.status,
    required this.createdAt,
    required this.respondedAt,
    required this.buddyDistanceKm,
    required this.lastBuddyLocationUpdateAt,
  });
}


