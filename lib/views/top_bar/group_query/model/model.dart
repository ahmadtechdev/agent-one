class BookingModel {
  String? destination;
  DateTime? checkIn;
  DateTime? checkOut;
  String? numberOfDays;
  String selectedRoomType = '';
  int starRating = 0;
  Map<String, bool> requirements = {
    'airportTransfer': false,
    'tourGuide': false,
    'breakfast': false,
    'halfBoardMeals': false,
    'fullBoardMeals': false,
    'conference': false,
    'meeting': false,
    'events': false,
  };

  BookingModel();

  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'checkIn': checkIn?.toIso8601String(),
      'checkOut': checkOut?.toIso8601String(),
      'numberOfDays': numberOfDays,
      'roomType': selectedRoomType,
      'starRating': starRating,
      'requirements': requirements,
    };
  }
}