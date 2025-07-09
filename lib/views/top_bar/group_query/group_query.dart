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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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

            Obx(() => Visibility(
                  visible: controller.isAddButtonVisible.value,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary,
                      foregroundColor: TColors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    onPressed: controller.addBooking,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Destination'),
                  ),
                )),

            const SizedBox(height: 24),

            // Summary Card
            Obx(() => _buildSummaryCard()),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  if (controller.validateForm()) {
                    // Handle booking submission
                    print(controller.bookings.map((b) => b.toJson()).toList());
                  }
                },
                child: Text(
                  'Book Now',
                  style: TextStyle(
                    color: TColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Summary',
              style: TextStyle(
                color: TColors.primaryText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow(
                'Total Receipt', '\$${controller.totalReceipt.value}'),
            const Divider(height: 24),
            _buildSummaryRow('Payment', '\$${controller.totalPayment.value}'),
            const Divider(height: 24),
            _buildSummaryRow(
              'Closing Balance',
              '\$${controller.getClosingBalance()}',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: TColors.primaryText,
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isTotal ? TColors.primary : TColors.primaryText,
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
