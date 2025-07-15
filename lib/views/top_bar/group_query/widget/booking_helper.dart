import 'package:agent1/common/color_extension.dart';
import 'package:agent1/common_widget/date_range_slector.dart';
import 'package:agent1/views/top_bar/group_query/group_query_controller.dart';
import 'package:agent1/views/top_bar/group_query/model/model.dart';
import 'package:agent1/views/top_bar/hotel/hotel/hotel_date_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BookingCard extends GetView<BookingController> {
  final int index;
  final BookingModel booking;

  const BookingCard({
    Key? key,
    required this.index,
    required this.booking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TColors.white,
      // elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with destination number and remove button
            Row(
              children: [
                Text(
                  'Destination ${index + 1}',
                  style: TextStyle(
                    color: TColors.primaryText,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (controller.bookings.length > 1)
                  IconButton(
                    icon: Icon(Icons.close, color: TColors.third),
                    onPressed: () => controller.removeBooking(index),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // Destination TextField
            TextFormField(
              initialValue: booking.destination,
              decoration: InputDecoration(
                labelText: 'Destination',
                filled: true,
                fillColor: TColors.textField,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => controller.updateDestination(index, value),
            ),

            const SizedBox(height: 16),

            // Date Selection Row
            Obx(() {
              final hotelDateController = Get.put(HotelDateController());
              return CustomDateRangeSelector(
                dateRange: hotelDateController.dateRange.value,
                onDateRangeChanged: hotelDateController.updateDateRange,
                nights: hotelDateController.nights.value,
                onNightsChanged: hotelDateController.updateNights,
              );
            }),
            const SizedBox(height: 16),

            // Room Types (Radio Buttons)
            Text(
              'Select Room Type:',
              style: TextStyle(
                color: TColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                'Single',
                'Double',
                'Triple',
                'Quad',
                'Quint',
              ]
                  .map((type) => RadioListTile<String>(
                        title: Text(type),
                        value: type,
                        groupValue: booking.selectedRoomType,
                        onChanged: (value) {
                          if (value != null)
                            controller.updateRoomType(index, value);
                        },
                        activeColor: TColors.primary,
                        dense: true,
                      ))
                  .toList(),
            ),

            const SizedBox(height: 16),

            // Star Rating (Radio Buttons)
            Text(
              'Choose Hotel Star:',
              style: TextStyle(
                color: TColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: List.generate(5, (starIndex) {
                final stars = starIndex + 1;
                return RadioListTile<int>(
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        stars,
                        (index) => Icon(
                              Icons.star,
                              color: TColors.secondary,
                              size: 20,
                            )),
                  ),
                  value: stars,
                  groupValue: booking.starRating,
                  onChanged: (value) {
                    if (value != null)
                      controller.updateStarRating(index, value);
                  },
                  activeColor: TColors.primary,
                  dense: true,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
