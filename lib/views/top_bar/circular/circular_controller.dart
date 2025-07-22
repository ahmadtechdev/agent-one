import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Colors class (already provided)


// Model for circular data
class CircularModel {
  final String id;
  final String date;
  final String airline;
  final String subject;
  final String content;
  final String airlineLogo;

  CircularModel({
    required this.id,
    required this.date,
    required this.airline,
    required this.subject,
    required this.content,
    required this.airlineLogo,
  });
}

// GetX Controller
class AirlineCircularsController extends GetxController {
  final RxList<CircularModel> circulars = <CircularModel>[].obs;
  final RxList<CircularModel> filteredCirculars = <CircularModel>[].obs;
  final RxMap<String, bool> expandedItems = <String, bool>{}.obs;
  final RxString selectedAirline = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCirculars();
  }

  void loadCirculars() {
    isLoading.value = true;
    
    // Sample data based on the screenshots
    circulars.value = [
      CircularModel(
        id: '1',
        date: 'Tue 30 Jul 2024',
        airline: 'Pegasus Airlines',
        subject: 'A-320 - All economy operation',
        content: 'Dear All,\n\nWe would like to inform you about the A-320 aircraft configuration changes. All economy class operation will be implemented effective immediately. This change affects all routes and bookings.\n\nPlease ensure all passengers are informed about this operational change.',
        airlineLogo: '✈️',
      ),
      CircularModel(
        id: '2',
        date: 'Fri 02 Aug 2024',
        airline: 'Pegasus Airlines',
        subject: 'Pegasus airline circular',
        content: 'Important updates regarding Pegasus Airlines operations:\n\n• New check-in procedures\n• Baggage policy updates\n• Flight schedule modifications\n• Contact information changes\n\nPlease review and implement these changes immediately.',
        airlineLogo: '✈️',
      ),
      CircularModel(
        id: '3',
        date: 'Fri 02 Aug 2024',
        airline: 'Pegasus Airlines',
        subject: 'Pegasus Airline additional Istanbul Sabiha Gokcen (SAW) - Tbilisi (TBS) flights',
        content: 'Dear Partners,\n\nWe are pleased to announce additional flights between Istanbul Sabiha Gokcen (SAW) and Tbilisi (TBS).\n\nNew Schedule:\n• Monday: Departure 14:30\n• Wednesday: Departure 16:45\n• Friday: Departure 18:20\n\nBookings are now open for these additional services.',
        airlineLogo: '✈️',
      ),
      CircularModel(
        id: '4',
        date: 'Wed 10 Jul 2024',
        airline: 'Turkish Airlines',
        subject: 'Request for changes',
        content: 'Request for schedule changes and operational updates:\n\n1. Route modifications\n2. Timing adjustments\n3. Aircraft type changes\n4. Service level updates\n\nPlease submit your requests through the designated portal.',
        airlineLogo: '🇹🇷',
      ),
      CircularModel(
        id: '5',
        date: 'Tue 23 Jan 2024',
        airline: 'PIA',
        subject: 'Important Circular for Saudi Travelers - Activation of Travel Requirements',
        content: 'Dear All,\n\nWe would like to inform you that special travel requirements for Saudi travelers will be activated for flights departing from all international airports in the Kingdom, starting from Wednesday, January 17, 2024.\n\nRegarding travel documents, the issuance of the boarding pass for the traveler will be rejected if the documents expiry date (passport - national ID) has passed, or if there is an error in the document number or any discrepancy in the travelers information. Also, in case the national ID or passport has not been activated, and the latest activated version is not available on the Absher platform.\n\nTherefore, we kindly request you to ensure the accuracy of entering the data and verify the match of the document type with the travelers document at the time of booking (passport - national ID - others).',
        airlineLogo: '🇵🇰',
      ),
    ];
    
    filteredCirculars.value = circulars;
    isLoading.value = false;
  }

  void toggleExpansion(String id) {
    expandedItems[id] = !(expandedItems[id] ?? false);
  }

  bool isExpanded(String id) {
    return expandedItems[id] ?? false;
  }

  void filterByAirline(String airline) {
    selectedAirline.value = airline;
    if (airline.isEmpty) {
      filteredCirculars.value = circulars;
    } else {
      filteredCirculars.value = circulars.where((c) => c.airline == airline).toList();
    }
  }

  List<String> get uniqueAirlines {
    return circulars.map((c) => c.airline).toSet().toList();
  }
}
