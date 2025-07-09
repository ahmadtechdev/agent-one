
import 'package:agent1/common/color_extension.dart';
import 'package:agent1/common_widget/date_selection.dart';
import 'package:agent1/common_widget/snackbar.dart';
import 'package:agent1/common_widget/thank_you_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'car_controller.dart';

class CarBooking extends StatelessWidget {
  final CarController carcontroler = Get.put(CarController());

  CarBooking({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsiveness
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Complete Your Booking"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: TColors.text),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: TColors.primary.withOpacity(0.1),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset(height: 250, 'assets/img/Cbooking.png')),
              const SizedBox(height: 20),
              _buildTextField(
                controller: carcontroler.firstNameController,
                label: "Flight Number",
                hintText: "Enter your Flight Number",
                icon: MdiIcons.airplane,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: carcontroler.firstNameController,
                label: "First Name",
                hintText: "Enter your first name",
                icon: Icons.person,
              ),
              // Form Fields

              const SizedBox(height: 16),
              _buildTextField(
                controller: carcontroler.lastNameController,
                label: "Last Name",
                hintText: "Enter your last name",
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: carcontroler.emailController,
                label: "Email",
                hintText: "Enter your email",
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: carcontroler.phoneController,
                label: "Phone Number",
                hintText: "Enter your phone number",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: carcontroler.addressController,
                label: "Address",
                hintText: "Enter your address",
                icon: Icons.location_on,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: carcontroler.cityController,
                label: "City",
                hintText: "Enter your city",
                icon: Icons.location_city,
              ),
              const SizedBox(height: 20),

              // Pickup and Off Fields in One Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: carcontroler.pickupController,
                      label: "Pickup Location",
                      hintText: "Enter Pickup Location",
                      icon: Icons.location_on,
                    ),
                  ),
                  const SizedBox(width: 16), // Space between Pickup and Off
                  Expanded(
                    child: _buildTextField(
                      controller: carcontroler.offController,
                      label: "Dropoff Location",
                      hintText: "Enter Off Location",
                      icon: Icons.location_on,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(() => Container(
                    color: Colors.white,
                    height: 55,
                    child: DateSelectionField(
                      initialDate: carcontroler.departureDate.value,
                      fontSize: 12,
                      onDateChanged: (date) {
                        carcontroler.updateDepartureDate(date);
                      },
                      firstDate: DateTime.now(),
                    ),
                  )),
              const SizedBox(height: 20),

              // Submit Button
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(const ThankYouScreen());

                      // Validate input and handle submission
                      if (_validateFields()) {
                        CustomSnackBar(
                                message: "Booking Confirmed!",
                                backgroundColor: Colors.green)
                            .show();
                      } else {
                        CustomSnackBar(
                                message: "Please fill all required fields!",
                                backgroundColor: TColors.third)
                            .show();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Proceed to Complete Booking",
                      style: TextStyle(fontSize: screenSize.width * 0.045),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build text fields with icons
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: label,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: TColors.primary),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: TColors.black)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide(color: TColors.black)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      keyboardType: keyboardType,
    );
  }

  // Validate form fields
  bool _validateFields() {
    return carcontroler.firstNameController.text.isNotEmpty &&
        carcontroler.lastNameController.text.isNotEmpty &&
        carcontroler.emailController.text.isNotEmpty &&
        carcontroler.phoneController.text.isNotEmpty;
  }
}
