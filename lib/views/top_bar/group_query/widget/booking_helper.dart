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
      margin: const EdgeInsets.only(bottom: 16),
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

            // Room Types (Multiple Selection with Checkboxes)
            Text(
              'Select Room Types:',
              style: TextStyle(
                color: TColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Obx(() => Column(
                  children: [
                    'Single',
                    'Double',
                    'Triple',
                    'Quad',
                    'Quint',
                  ]
                      .map((type) => CheckboxListTile(
                            title: Text(type),
                            value: controller.isRoomTypeSelected(index, type),
                            onChanged: (bool? value) {
                              controller.updateRoomType(
                                  index, type, value ?? false);
                            },
                            activeColor: TColors.primary,
                            dense: true,
                          ))
                      .toList(),
                )),

            const SizedBox(height: 16),

            // Star Rating (Multiple Selection with Checkboxes)
            Text(
              'Choose Hotel Stars:',
              style: TextStyle(
                color: TColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Obx(() => Column(
                  children: List.generate(5, (starIndex) {
                    final stars = starIndex + 1;
                    return CheckboxListTile(
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
                      value: controller.isStarRatingSelected(index, stars),
                      onChanged: (bool? value) {
                        controller.updateStarRating(
                            index, stars, value ?? false);
                      },
                      activeColor: TColors.primary,
                      dense: true,
                    );
                  }),
                )),

            const SizedBox(height: 16),

            // Display selected options (Optional - for better UX)
            if (booking.selectedRoomTypes.isNotEmpty) ...[
              Text(
                'Selected Room Types:',
                style: TextStyle(
                  color: TColors.primaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                children: booking.selectedRoomTypes
                    .map((type) => Chip(
                          label: Text(type),
                          backgroundColor: TColors.primary.withOpacity(0.1),
                          labelStyle: TextStyle(color: TColors.primary),
                          deleteIcon: Icon(Icons.close, size: 16),
                          onDeleted: () =>
                              controller.updateRoomType(index, type, false),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 8),
            ],

            if (booking.selectedStarRatings.isNotEmpty) ...[
              Text(
                'Selected Star Ratings:',
                style: TextStyle(
                  color: TColors.primaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                children: booking.selectedStarRatings
                    .map((rating) => Chip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...List.generate(
                                  rating,
                                  (index) => Icon(
                                        Icons.star,
                                        color: TColors.secondary,
                                        size: 16,
                                      )),
                              const SizedBox(width: 4),
                              Text('$rating Star${rating > 1 ? 's' : ''}'),
                            ],
                          ),
                          backgroundColor: TColors.secondary.withOpacity(0.1),
                          labelStyle: TextStyle(color: TColors.secondary),
                          deleteIcon: Icon(Icons.close, size: 16),
                          onDeleted: () =>
                              controller.updateStarRating(index, rating, false),
                        ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
