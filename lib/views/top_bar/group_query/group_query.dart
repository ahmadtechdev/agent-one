import 'package:agent1/common/color_extension.dart';
import 'package:agent1/views/top_bar/group_query/group_query_controller.dart';
import 'package:agent1/views/top_bar/group_query/widget/booking_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupQuery extends StatelessWidget {
  GroupQuery({Key? key}) : super(key: key);

  final BookingController controller = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Container(
      // backgroundColor: TColors.background ?? Colors.grey[50],
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Number Of People',
                        filled: true,
                        fillColor: TColors.textField,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [],
                      onChanged: (value) {
                        // final intValue = int.tryParse(value) ?? 1;
                        // controller.updateNumberOfPeople(index, intValue);
                      },
                    ),
                  ),
                  // Display calculated days
                ],
              ),

              // Header

              // Booking Cards
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.bookings.length,
                    itemBuilder: (context, index) => BookingCard(
                      index: index,
                      booking: controller.bookings[index],
                    ),
                  )),

              const SizedBox(height: 16),

              // Add Destination Button
              Obx(() => Visibility(
                    visible: controller.isAddButtonVisible.value,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primary,
                          foregroundColor: TColors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: controller.addBooking,
                        icon: const Icon(Icons.add),
                        label: const Text('+ Add Destination'),
                      ),
                    ),
                  )),

              const SizedBox(height: 24),

              // Global Requirements Card (Outside booking cards)
              _buildRequirementsCard(),

              const SizedBox(height: 24),

              // Message/Notes Section
              _buildMessageSection(),

              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.primary,
                        foregroundColor: TColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: controller.submitBooking,
                      child: const Text(
                        'Send Message',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: TColors.primary,
                        side: BorderSide(color: TColors.primary),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: controller.resetBookings,
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Specific Requirements:',
              style: TextStyle(
                color: TColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: controller.globalRequirements.entries
                      .map((entry) => FilterChip(
                            label: Text(entry.key),
                            selected: entry.value,
                            onSelected: (selected) => controller
                                .updateRequirement(entry.key, selected),
                            selectedColor: TColors.primary,
                            backgroundColor: TColors.textField,
                            labelStyle: TextStyle(
                              color: entry.value
                                  ? TColors.white
                                  : TColors.primaryText,
                            ),
                          ))
                      .toList(),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Additional Message (Optional)',
              style: TextStyle(
                color: TColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.msg_controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter any additional requirements or messages...',
                filled: true,
                fillColor: TColors.textField,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                // Store additional message if needed
              },
            ),
          ],
        ),
      ),
    );
  }
}
