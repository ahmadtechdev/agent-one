import 'package:agent1/views/top_bar/umrah_pkg/slect_card.dart';
import 'package:agent1/views/top_bar/umrah_pkg/umrah_pkg_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:agent1/common/color_extension.dart';

class UmrahPkg extends GetView<UmrahPackageController> {
  const UmrahPkg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVisaSection(),
              const SizedBox(height: 16),
              _buildTransportSection(),
              const SizedBox(height: 16),
              _buildGroupTicketsSection(),
              const SizedBox(height: 16),
              _buildHotelSection(),
              const SizedBox(height: 16),
              _buildSubmitButton(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: TColors.primary, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: TColors.primaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildVisaSection() {
    return Card(
      color: TColors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Visa Details', Icons.card_membership),
            const SizedBox(height: 16),
            Obx(() => DropdownButtonFormField<String>(
                  decoration: _inputDecoration('Select Visa Type'),
                  value: controller.selectedVisaType.value,
                  items: ['Tourist Visa', 'Business Visa', 'Transit Visa']
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) =>
                      controller.selectedVisaType.value = value,
                )),
            const SizedBox(height: 16),
            _buildCounterField('Adult Count', controller.adultCount),
            const SizedBox(height: 8),
            _buildCounterField('Child Count', controller.childCount),
            const SizedBox(height: 8),
            _buildCounterField('Infant Count', controller.infantCount),
            const SizedBox(height: 16),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Total Visa Cost: ',
                      style: TextStyle(color: TColors.primaryText),
                    ),
                    Text(
                      '\$${controller.calculateVisaCost()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: TColors.primary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterField(String label, RxString counter) {
    return Obx(() => Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: TextStyle(color: TColors.primaryText),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline,
                        color: TColors.primary),
                    onPressed: () => controller.decrementCount(counter),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(text: counter.value),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration(''),
                      onChanged: (value) => counter.value = value,
                    ),
                  ),
                  IconButton(
                    icon:
                        Icon(Icons.add_circle_outline, color: TColors.primary),
                    onPressed: () => controller.incrementCount(counter),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _buildTransportSection() {
    return Card(
      color: TColors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Transport Details', Icons.directions_car),
            const SizedBox(height: 16),
            Obx(() => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.transportRows.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) => _buildTransportRow(index),
                )),
            const SizedBox(height: 8),
            Obx(() {
              if (controller.transportRows.length < 3) {
                return TextButton.icon(
                  icon: Icon(Icons.add_circle, color: TColors.primary),
                  label: const Text('Add Transport'),
                  onPressed: controller.addTransportRow,
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTransportRow(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Transport ${index + 1}'),
            if (index > 0)
              IconButton(
                icon: Icon(Icons.cancel, color: TColors.third),
                onPressed: () => controller.removeTransportRow(index),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Obx(() => DropdownButtonFormField<String>(
              decoration: _inputDecoration('Select Transport'),
              value: controller.transportRows[index].transport,
              items: ['Bus', 'Car', 'Van']
                  .map((type) =>
                      DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) =>
                  controller.updateTransportType(index, value),
            )),
        const SizedBox(height: 8),
        Obx(() => DropdownButtonFormField<String>(
              decoration: _inputDecoration('Select Route'),
              value: controller.transportRows[index].route,
              items: ['Route 1', 'Route 2', 'Route 3']
                  .map((type) =>
                      DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) =>
                  controller.updateTransportRoute(index, value),
            )),
        const SizedBox(height: 8),
        TextFormField(
          decoration: _inputDecoration('Rate'),
          keyboardType: TextInputType.number,
          onChanged: (value) => controller.updateTransportRate(index, value),
        ),
      ],
    );
  }

  Widget _buildGroupTicketsSection() {
    return GroupTicketsCard(
      selectedFlights: controller.selectedGroupFlights,
      onFlightSelected: controller.addGroupFlight,
      onFlightRemoved: controller.removeGroupFlight,
    );
  }

  Widget _buildHotelSection() {
    return Card(
      color: TColors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Hotel Details', Icons.hotel),
            const SizedBox(height: 16),
            Obx(() => Row(
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: controller.isPrivateRoom.value,
                      onChanged: (value) =>
                          controller.isPrivateRoom.value = value!,
                      activeColor: TColors.primary,
                    ),
                    const Text(
                      'Private Room',
                      style: TextStyle(fontSize: 10),
                    ),
                    Radio<bool>(
                      value: false,
                      groupValue: controller.isPrivateRoom.value,
                      onChanged: (value) =>
                          controller.isPrivateRoom.value = value!,
                      activeColor: TColors.primary,
                    ),
                    const Text(
                      'Sharing Room',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                )),
            const SizedBox(height: 16),
            Obx(() => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.hotelRows.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) =>
                      _buildHotelRow(context, index),
                )),
            const SizedBox(height: 8),
            Obx(() {
              if (controller.hotelRows.length < 3) {
                return TextButton.icon(
                  icon: Icon(Icons.add_circle, color: TColors.primary),
                  label: const Text('Add Hotel'),
                  onPressed: controller.addHotelRow,
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildHotelRow(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Hotel ${index + 1}'),
            if (index > 0)
              IconButton(
                icon: Icon(Icons.cancel, color: TColors.third),
                onPressed: () => controller.removeHotelRow(index),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Obx(() => DropdownButtonFormField<String>(
              decoration: _inputDecoration('Select City'),
              value: controller.hotelRows[index].city,
              items: ['Makkah', 'Madinah']
                  .map((city) =>
                      DropdownMenuItem(value: city, child: Text(city)))
                  .toList(),
              onChanged: (value) => controller.updateHotelCity(index, value),
            )),
        const SizedBox(height: 8),
        Obx(() => DropdownButtonFormField<String>(
              decoration: _inputDecoration('Select Hotel'),
              value: controller.hotelRows[index].hotel,
              items: ['Hotel A', 'Hotel B', 'Hotel C']
                  .map((hotel) =>
                      DropdownMenuItem(value: hotel, child: Text(hotel)))
                  .toList(),
              onChanged: (value) => controller.updateHotelName(index, value),
            )),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: _inputDecoration('Rooms'),
                initialValue: controller.hotelRows[index].rooms.toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) => controller.updateHotelRooms(index, value),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Obx(() => DropdownButtonFormField<String>(
                    decoration: _inputDecoration('Room Type'),
                    value: controller.hotelRows[index].roomType,
                    items: ['Standard', 'Deluxe', 'Suite']
                        .map((type) =>
                            DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (value) =>
                        controller.updateHotelRoomType(index, value),
                  )),
            ),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final DateTimeRange? dateRange = await showDateRangePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              initialDateRange: controller.hotelRows[index].dateRange,
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(primary: TColors.primary),
                  ),
                  child: child!,
                );
              },
            );
            if (dateRange != null) {
              controller.updateHotelDateRange(index, dateRange);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, size: 18, color: TColors.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Obx(() => Text(
                        controller.hotelRows[index].dateRange != null
                            ? '${DateFormat('dd/MM/yyyy').format(controller.hotelRows[index].dateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(controller.hotelRows[index].dateRange!.end)}'
                            : 'Select dates',
                        style: TextStyle(color: TColors.primaryText),
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: controller.submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: TColors.primary,
            foregroundColor: TColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(48),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          icon: const Icon(Icons.arrow_forward_ios, size: 16),
          label: const Text(
            'Book Package',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: TColors.placeholder),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: TColors.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: TColors.primary),
      ),
      filled: true,
      fillColor: TColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }
}
