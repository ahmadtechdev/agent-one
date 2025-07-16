class BookingModel {
  String destination = '';
  DateTime? checkIn;
  DateTime? checkOut;
  int numberOfDays = 0;
  int numberOfPeople = 1;
  
  // Changed to support multiple selections
  List<String> selectedRoomTypes = [];
  List<int> selectedStarRatings = [];

  BookingModel();

  // Calculate number of days automatically
  void calculateDays() {
    if (checkIn != null && checkOut != null) {
      final difference = checkOut!.difference(checkIn!);
      numberOfDays = difference.inDays > 0 ? difference.inDays : 0;
    }
  }

  // Validation method
  bool isValid() {
    return destination.isNotEmpty &&
        checkIn != null &&
        checkOut != null &&
        selectedRoomTypes.isNotEmpty &&
        selectedStarRatings.isNotEmpty &&
        numberOfPeople > 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'checkIn': checkIn?.toIso8601String(),
      'checkOut': checkOut?.toIso8601String(),
      'numberOfDays': numberOfDays,
      'numberOfPeople': numberOfPeople,
      'roomTypes': selectedRoomTypes,
      'starRatings': selectedStarRatings,
    };
  }

  // Create from JSON
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    final booking = BookingModel();
    booking.destination = json['destination'] ?? '';
    booking.checkIn = json['checkIn'] != null ? DateTime.parse(json['checkIn']) : null;
    booking.checkOut = json['checkOut'] != null ? DateTime.parse(json['checkOut']) : null;
    booking.numberOfDays = json['numberOfDays'] ?? 0;
    booking.numberOfPeople = json['numberOfPeople'] ?? 1;
    booking.selectedRoomTypes = List<String>.from(json['roomTypes'] ?? []);
    booking.selectedStarRatings = List<int>.from(json['starRatings'] ?? []);
    return booking;
  }
}