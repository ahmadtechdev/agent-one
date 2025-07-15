class BookingModel {
  String destination = '';
  DateTime? checkIn;
  DateTime? checkOut;
  int numberOfDays = 0;
  int numberOfPeople = 1; // Added missing field
  String selectedRoomType = '';
  int starRating = 0;

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
        selectedRoomType.isNotEmpty &&
        numberOfPeople > 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'checkIn': checkIn?.toIso8601String(),
      'checkOut': checkOut?.toIso8601String(),
      'numberOfDays': numberOfDays,
      'numberOfPeople': numberOfPeople,
      'roomType': selectedRoomType,
      'starRating': starRating,
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
    booking.selectedRoomType = json['roomType'] ?? '';
    booking.starRating = json['starRating'] ?? 0;
    return booking;
  }
}