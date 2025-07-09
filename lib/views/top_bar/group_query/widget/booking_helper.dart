import 'package:agent1/common/color_extension.dart';
import 'package:agent1/views/top_bar/group_query/group_query_controller.dart';
import 'package:agent1/views/top_bar/group_query/model/model.dart';
import 'package:flutter/material.dart';
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
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Row(
              children: [
                Expanded(child: _buildDateField(
                  'Check-in',
                  booking.checkIn,
                  (date) => controller.updateCheckIn(index, date),
                )),
                const SizedBox(width: 16),
                Expanded(child: _buildDateField(
                  'Check-out',
                  booking.checkOut,
                  (date) => controller.updateCheckOut(index, date),
                )),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Room Types
            Text(
              'Room Type',
              style: TextStyle(
                color: TColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                'Single',
                'Double',
                'Triple',
                'Quad',
                'Quint',
              ].map((type) => ChoiceChip(
                label: Text(type),
                selected: booking.selectedRoomType == type,
                onSelected: (selected) {
                  if (selected) controller.updateRoomType(index, type);
                },
                selectedColor: TColors.primary,
                labelStyle: TextStyle(
                  color: booking.selectedRoomType == type
                      ? TColors.white
                      : TColors.primaryText,
                ),
              )).toList(),
            ),
            
            const SizedBox(height: 16),
            
            // Star Rating
            Text(
              'Hotel Star Rating',
              style: TextStyle(
                color: TColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(5, (starIndex) => IconButton(
                icon: Icon(
                  starIndex < booking.starRating 
                      ? Icons.star 
                      : Icons.star_border,
                  color: TColors.secondary,
                ),
                onPressed: () => controller.updateStarRating(index, starIndex + 1),
              )),
            ),
            
            const SizedBox(height: 16),
            
            // Requirements
            Text(
              'Requirements',
              style: TextStyle(
                color: TColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: booking.requirements.entries.map((entry) => FilterChip(
                label: Text(entry.key),
                selected: entry.value,
                onSelected: (selected) => 
                    controller.updateRequirement(index, entry.key, selected),
                selectedColor: TColors.primary,
                labelStyle: TextStyle(
                  color: entry.value ? TColors.white : TColors.primaryText,
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }Widget _buildDateField(
  String label,
  DateTime? initialDate,
  Function(DateTime) onDateSelected,
) {
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
            firstDate: DateTime.now(),
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
          ),
          child: Row(
            children: [
              Icon(Icons.calendar_today, color: TColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                initialDate != null
                    ? DateFormat('yyyy-MM-dd').format(initialDate)
                    : 'Select a date',
                style: TextStyle(
                  color: TColors.primaryText,
                  fontSize: 16,
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