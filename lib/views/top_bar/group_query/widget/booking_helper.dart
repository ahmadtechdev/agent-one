import 'package:agent1/common/color_extension.dart';
import 'package:agent1/common_widget/date_range_slector.dart';
import 'package:agent1/views/top_bar/group_query/group_query_controller.dart';
import 'package:agent1/views/top_bar/group_query/model/model.dart';
import 'package:agent1/views/top_bar/hotel/hotel/hotel_date_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

  Widget _buildDateField(
    String label,
    DateTime? initialDate,
    Function(DateTime) onDateSelected, {
    DateTime? firstDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: TColors.primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: Get.context!,
              initialDate: initialDate ?? DateTime.now(),
              firstDate: firstDate ?? DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              onDateSelected(date);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: TColors.textField,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: TColors.primary.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: TColors.primary, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    initialDate != null
                        ? DateFormat('dd/MM/yyyy').format(initialDate)
                        : 'dd/mm/yyyy',
                    style: TextStyle(
                      color: initialDate != null
                          ? TColors.primaryText
                          : TColors.primaryText.withOpacity(0.6),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
