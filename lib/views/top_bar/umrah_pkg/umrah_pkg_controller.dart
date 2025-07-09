import 'package:agent1/views/top_bar/umrah_pkg/slect_card.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UmrahPackageController extends GetxController {
  final hotelRows = <HotelRow>[HotelRow()].obs;
  final transportRows = <TransportRow>[TransportRow()].obs;

  final selectedVisaType = Rxn<String>();
  final adultCount = '0'.obs;
  final childCount = '0'.obs;
  final infantCount = '0'.obs;
  final isPrivateRoom = true.obs;
  final showGroupTickets = false.obs;

  final selectedGroupFlights = <FlightData>[].obs;

  void addGroupFlight(FlightData flight) {
    // Remove any existing flights first since we want only one selection
    selectedGroupFlights.clear();
    // Add the new flight
    selectedGroupFlights.add(flight);
  }

  void removeGroupFlight(FlightData flight) {
    selectedGroupFlights.remove(flight);
  }

  void addHotelRow() {
    if (hotelRows.length < 3) {
      hotelRows.add(HotelRow());
    }
  }

  void removeHotelRow(int index) {
    if (hotelRows.length > 1) {
      hotelRows.removeAt(index);
    }
  }

  void addTransportRow() {
    if (transportRows.length < 3) {
      transportRows.add(TransportRow());
    }
  }

  void removeTransportRow(int index) {
    if (transportRows.length > 1) {
      transportRows.removeAt(index);
    }
  }

  void updateHotelCity(int index, String? value) {
    hotelRows[index].city = value;
    update();
  }

  void updateHotelName(int index, String? value) {
    hotelRows[index].hotel = value;
    update();
  }

  void updateHotelRoomType(int index, String? value) {
    hotelRows[index].roomType = value;
    update();
  }

  void updateHotelRooms(int index, String value) {
    hotelRows[index].rooms = int.tryParse(value) ?? 1;
    update();
  }

  void updateHotelDateRange(int index, DateTimeRange? dateRange) {
    hotelRows[index].dateRange = dateRange;
    update();
  }

  void updateTransportType(int index, String? value) {
    transportRows[index].transport = value;
    update();
  }

  void updateTransportRoute(int index, String? value) {
    transportRows[index].route = value;
    update();
  }

  void updateTransportRate(int index, String value) {
    transportRows[index].rate = double.tryParse(value) ?? 0.0;
    update();
  }

  void incrementCount(RxString counter) {
    int current = int.tryParse(counter.value) ?? 0;
    counter.value = (current + 1).toString();
  }

  void decrementCount(RxString counter) {
    int current = int.tryParse(counter.value) ?? 0;
    if (current > 0) {
      counter.value = (current - 1).toString();
    }
  }

  double calculateVisaCost() {
    final adult = int.tryParse(adultCount.value) ?? 0;
    final child = int.tryParse(childCount.value) ?? 0;
    final infant = int.tryParse(infantCount.value) ?? 0;
    return (adult * 100) + (child * 50) + (infant * 25);
  }

  double calculateTransportCost() {
    return transportRows.fold(0.0, (sum, row) => sum + row.rate);
  }

  double getHotelBaseRate(String? roomType) {
    switch (roomType) {
      case 'Standard':
        return 100;
      case 'Deluxe':
        return 150;
      case 'Suite':
        return 200;
      default:
        return 0;
    }
  }

  double calculateHotelCost() {
    return hotelRows.fold(0.0, (sum, row) {
      final days = row.dateRange?.duration.inDays ?? 0;
      final baseRate = getHotelBaseRate(row.roomType);
      return sum + (baseRate * days * row.rooms);
    });
  }

  double calculateGroupTicketsCost() {
    return showGroupTickets.value ? 50.0 : 0.0;
  }

  double calculateTotalCost() {
    return calculateVisaCost() +
        calculateTransportCost() +
        calculateHotelCost() +
        calculateGroupTicketsCost();
  }

  bool validateForm() {
    if (selectedVisaType.value == null) {
      Get.snackbar(
        'Error',
        'Please select a visa type',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (transportRows
        .any((row) => row.transport == null || row.route == null)) {
      Get.snackbar(
        'Error',
        'Please complete all transport details',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (hotelRows.any((row) =>
        row.city == null ||
        row.hotel == null ||
        row.roomType == null ||
        row.dateRange == null)) {
      Get.snackbar(
        'Error',
        'Please complete all hotel details',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    return true;
  }

  void submitForm() {
    if (validateForm()) {
      final formData = UmrahPackageForm(
        visaType: selectedVisaType.value,
        adultCount: int.tryParse(adultCount.value) ?? 0,
        childCount: int.tryParse(childCount.value) ?? 0,
        infantCount: int.tryParse(infantCount.value) ?? 0,
        isPrivateRoom: isPrivateRoom.value,
        transportDetails: transportRows,
        hotelDetails: hotelRows,
        includeGroupTickets: showGroupTickets.value,
      );

      Get.snackbar(
        'Success',
        'Package booked successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      print('Form Data: ${formData.toJson()}');
    }
  }
}

// Model classes remain the same
class HotelRow {
  String? city;
  String? hotel;
  String? roomType;
  DateTimeRange? dateRange;
  int rooms;

  HotelRow({
    this.city,
    this.hotel,
    this.roomType,
    this.dateRange,
    this.rooms = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'hotel': hotel,
      'roomType': roomType,
      'checkIn': dateRange?.start.toIso8601String(),
      'checkOut': dateRange?.end.toIso8601String(),
      'rooms': rooms,
    };
  }
}

class TransportRow {
  String? transport;
  String? route;
  double rate;

  TransportRow({
    this.transport,
    this.route,
    this.rate = 0.0,
  });

  Map<String, dynamic> toJson() {
    return {
      'transport': transport,
      'route': route,
      'rate': rate,
    };
  }
}

class UmrahPackageForm {
  final String? visaType;
  final int adultCount;
  final int childCount;
  final int infantCount;
  final bool isPrivateRoom;
  final List<TransportRow> transportDetails;
  final List<HotelRow> hotelDetails;
  final bool includeGroupTickets;

  UmrahPackageForm({
    this.visaType,
    this.adultCount = 0,
    this.childCount = 0,
    this.infantCount = 0,
    this.isPrivateRoom = true,
    required this.transportDetails,
    required this.hotelDetails,
    this.includeGroupTickets = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'visaType': visaType,
      'adultCount': adultCount,
      'childCount': childCount,
      'infantCount': infantCount,
      'isPrivateRoom': isPrivateRoom,
      'transportDetails': transportDetails.map((t) => t.toJson()).toList(),
      'hotelDetails': hotelDetails.map((h) => h.toJson()).toList(),
      'includeGroupTickets': includeGroupTickets,
    };
  }
}
