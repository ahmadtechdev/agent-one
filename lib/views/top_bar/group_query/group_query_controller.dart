import 'package:agent1/views/top_bar/group_query/model/model.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  RxList<BookingModel> bookings = <BookingModel>[].obs;
  RxBool isAddButtonVisible = true.obs;
  RxDouble totalReceipt = 0.0.obs;
  RxDouble totalPayment = 0.0.obs;
  
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
    bookings[index].destination = value;
    update();
  }

  void updateCheckIn(int index, DateTime date) {
    bookings[index].checkIn = date;
    _calculateDays(index);
    update();
  }

  void updateCheckOut(int index, DateTime date) {
    bookings[index].checkOut = date;
    _calculateDays(index);
    update();
  }

  void _calculateDays(int index) {
    if (bookings[index].checkIn != null && bookings[index].checkOut != null) {
      final difference = bookings[index].checkOut!.difference(bookings[index].checkIn!);
      bookings[index].numberOfDays = difference.inDays.toString();
      update();
    }
  }

  void updateRoomType(int index, String type) {
    bookings[index].selectedRoomType = type;
    update();
  }

  void updateStarRating(int index, int rating) {
    bookings[index].starRating = rating;
    update();
  }

  void updateRequirement(int index, String requirement, bool value) {
    bookings[index].requirements[requirement] = value;
    update();
  }

  double getClosingBalance() {
    return totalReceipt.value - totalPayment.value;
  }

  bool validateForm() {
    for (var booking in bookings) {
      if (booking.destination == null || booking.destination!.isEmpty) {
        Get.snackbar('Error', 'Please enter destination');
        return false;
      }
      if (booking.checkIn == null || booking.checkOut == null) {
        Get.snackbar('Error', 'Please select dates');
        return false;
      }
      if (booking.selectedRoomType.isEmpty) {
        Get.snackbar('Error', 'Please select room type');
        return false;
      }
    }
    return true;
  }
}