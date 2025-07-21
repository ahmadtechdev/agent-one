import 'package:agent1/views/top_bar/group_query/model/model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BookingController extends GetxController {
  RxList<BookingModel> bookings = <BookingModel>[].obs;
  RxBool isAddButtonVisible = true.obs;
  RxDouble totalReceipt = 0.0.obs;
  RxDouble totalPayment = 0.0.obs;
  var msg_controller = TextEditingController();

  // Global requirements (shared across all bookings)
  RxMap<String, bool> globalRequirements = <String, bool>{
    'Airport Transfer': false,
    'Tour Guide': false,
    'Breakfast': false,
    'Half Board Meals': false,
    'Full Board Meals': false,
    'Conference': false,
    'Meeting': false,
    'Events': false,
  }.obs;

  @override
  void onInit() {
    super.onInit();
    // Add first booking by default
    addBooking();
  }

  void addBooking() {
    if (bookings.length < 3) {
      bookings.add(BookingModel());
      if (bookings.length >= 3) {
        isAddButtonVisible.value = false;
      }
    }
  }

  void removeBooking(int index) {
    if (bookings.length > 1) {
      bookings.removeAt(index);

      isAddButtonVisible.value = true;
    }
  }

  void updateDestination(int index, String value) {
    if (index < bookings.length) {
      bookings[index].destination = value;
      bookings.refresh();
    }
  }

  void updateNumberOfPeople(int index, int value) {
    if (index < bookings.length && value > 0) {
      bookings[index].numberOfPeople = value;
      bookings.refresh();
    }
  }

  void updateCheckIn(int index, DateTime date) {
    if (index < bookings.length) {
      bookings[index].checkIn = date;
      // Ensure check-out is after check-in
      if (bookings[index].checkOut != null &&
          bookings[index].checkOut!.isBefore(date)) {
        bookings[index].checkOut = null;
      }
      bookings[index].calculateDays();
      bookings.refresh();
    }
  }

  void updateCheckOut(int index, DateTime date) {
    if (index < bookings.length) {
      final checkIn = bookings[index].checkIn;
      if (checkIn != null && date.isAfter(checkIn)) {
        bookings[index].checkOut = date;
        bookings[index].calculateDays();
        bookings.refresh();
      } else {
        _showError('Check-out date must be after check-in date');
      }
    }
  }

  // Updated method to handle multiple room type selections
  void updateRoomType(int index, String type, bool isSelected) {
    if (index < bookings.length) {
      final booking = bookings[index];
      if (isSelected) {
        if (!booking.selectedRoomTypes.contains(type)) {
          booking.selectedRoomTypes.add(type);
        }
      } else {
        booking.selectedRoomTypes.remove(type);
      }
      bookings.refresh();
    }
  }

  // Updated method to handle multiple star rating selections
  void updateStarRating(int index, int rating, bool isSelected) {
    if (index < bookings.length && rating >= 1 && rating <= 5) {
      final booking = bookings[index];
      if (isSelected) {
        if (!booking.selectedStarRatings.contains(rating)) {
          booking.selectedStarRatings.add(rating);
        }
      } else {
        booking.selectedStarRatings.remove(rating);
      }
      bookings.refresh();
    }
  }

  // Helper method to check if room type is selected
  bool isRoomTypeSelected(int index, String type) {
    if (index < bookings.length) {
      return bookings[index].selectedRoomTypes.contains(type);
    }
    return false;
  }

  // Helper method to check if star rating is selected
  bool isStarRatingSelected(int index, int rating) {
    if (index < bookings.length) {
      return bookings[index].selectedStarRatings.contains(rating);
    }
    return false;
  }

  void updateRequirement(String requirement, bool value) {
    if (globalRequirements.containsKey(requirement)) {
      globalRequirements[requirement] = value;
    }
  }

  double getClosingBalance() {
    return totalReceipt.value - totalPayment.value;
  }

  bool validateForm() {
    for (int i = 0; i < bookings.length; i++) {
      final booking = bookings[i];

      if (booking.destination.isEmpty) {
        _showError('Please enter destination for booking ${i + 1}');
        return false;
      }

      if (booking.selectedRoomTypes.isEmpty) {
        _showError('Please select at least one room type for booking ${i + 1}');
        return false;
      }

      if (booking.selectedStarRatings.isEmpty) {
        _showError(
            'Please select at least one star rating for booking ${i + 1}');
        return false;
      }

      if (booking.numberOfPeople <= 0) {
        _showError(
            'Number of people must be greater than 0 for booking ${i + 1}');
        return false;
      }
    }
    return true;
  }

  void _showError(String message) {
    Get.snackbar(
      'Validation Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  void _showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  void submitBooking() {
    if (validateForm()) {
      // Process booking submission
      final bookingData = {
        'bookings': bookings.map((b) => b.toJson()).toList(),
        'requirements': globalRequirements,
      };
      print('Booking submitted: $bookingData');
      _showSuccess('Booking submitted successfully!');

      // Here you would typically send the data to your API
      // await apiService.submitBooking(bookingData);
    }
  }

  void resetBookings() {
    bookings.clear();
    addBooking();
    isAddButtonVisible.value = true;
    msg_controller.clear();
    // Reset global requirements
    globalRequirements.updateAll((key, value) => false);
  }
}
