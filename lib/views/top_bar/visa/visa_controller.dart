// visa_controller.dart
import 'package:agent1/views/top_bar/visa/visa_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class VisaController extends GetxController {
  // Observable variables
  final RxList<VisaModel> visaList = <VisaModel>[].obs;
  final RxList<VisaModel> filteredVisaList = <VisaModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedFilter = 'All'.obs;
  
  // Form variables
  final RxInt numberOfAdults = 1.obs;
  final RxInt numberOfChildren = 0.obs;
  final RxList<PassengerModel> passengers = <PassengerModel>[].obs;
  final Rx<BookerModel> booker = BookerModel(name: '', email: '', phone: '').obs;
  final RxDouble totalFee = 0.0.obs;
  final RxString selectedVisaId = ''.obs;
  
  // Form controllers
  final TextEditingController bookerNameController = TextEditingController();
  final TextEditingController bookerEmailController = TextEditingController();
  final TextEditingController bookerPhoneController = TextEditingController();
  final RxList<TextEditingController> firstNameControllers = <TextEditingController>[].obs;
  final RxList<TextEditingController> lastNameControllers = <TextEditingController>[].obs;
  final RxList<TextEditingController> passportControllers = <TextEditingController>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadVisaData();
    initializePassengerControllers();
  }

  @override
  void onClose() {
    // Dispose controllers
    bookerNameController.dispose();
    bookerEmailController.dispose();
    bookerPhoneController.dispose();
    disposePassengerControllers();
    super.onClose();
  }

  void loadVisaData() {
    isLoading.value = true;
    
    // Mock data based on the screenshots
    final mockVisas = [
      VisaModel(
        id: '1',
        title: 'Tourist 30 Days Single Entry Visa',
        description: 'Single entry tourist visa valid for 30 days',
        country: 'United Arab Emirates',
        duration: '30 Days',
        entryType: 'Single Entry',
        processingTime: '3-5 working days',
        price: 23000,
        currency: 'PKR',
        imageUrl: 'assets/images/uae_visa.png',
        requirements: ['Valid Passport', 'Passport Photos', 'Bank Statement'],
        isTransit: false,
      ),
      VisaModel(
        id: '2',
        title: 'Tourist 60 Days Single Entry Visa',
        description: 'Single entry tourist visa valid for 60 days',
        country: 'United Arab Emirates',
        duration: '60 Days',
        entryType: 'Single Entry',
        processingTime: '3-5 working days',
        price: 39000,
        currency: 'PKR',
        imageUrl: 'assets/images/uae_visa.png',
        requirements: ['Valid Passport', 'Passport Photos', 'Bank Statement'],
        isTransit: false,
      ),
      VisaModel(
        id: '3',
        title: '48 Hours Transit Visa',
        description: 'Transit visa valid for 48 hours',
        country: 'United Arab Emirates',
        duration: '48 Hours',
        entryType: 'Transit',
        processingTime: '1-2 working days',
        price: 9000,
        currency: 'PKR',
        imageUrl: 'assets/images/uae_visa.png',
        requirements: ['Valid Passport', 'Onward Ticket'],
        isTransit: true,
      ),
      VisaModel(
        id: '4',
        title: 'Emirates 96 Hours Transit Visa',
        description: 'Emirates transit visa valid for 96 hours',
        country: 'United Arab Emirates',
        duration: '96 Hours',
        entryType: 'Transit',
        processingTime: '1-2 working days',
        price: 28500,
        currency: 'PKR',
        imageUrl: 'assets/images/uae_visa.png',
        requirements: ['Valid Passport', 'Emirates Ticket'],
        isTransit: true,
      ),
    ];

    visaList.value = mockVisas;
    filteredVisaList.value = mockVisas;
    isLoading.value = false;
  }

  void searchVisas(String query) {
    searchQuery.value = query;
    filterVisas();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    filterVisas();
  }

  void filterVisas() {
    List<VisaModel> filtered = visaList.where((visa) {
      final matchesSearch = visa.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          visa.country.toLowerCase().contains(searchQuery.value.toLowerCase());
      
      final matchesFilter = selectedFilter.value == 'All' ||
          (selectedFilter.value == 'Tourist' && !visa.isTransit) ||
          (selectedFilter.value == 'Transit' && visa.isTransit);
      
      return matchesSearch && matchesFilter;
    }).toList();
    
    filteredVisaList.value = filtered;
  }

  void selectVisa(String visaId) {
    selectedVisaId.value = visaId;
    calculateTotalFee();
  }

  void updatePassengerCount(int adults, int children) {
    numberOfAdults.value = adults;
    numberOfChildren.value = children;
    initializePassengerControllers();
    calculateTotalFee();
  }

  void initializePassengerControllers() {
    // Dispose existing controllers
    disposePassengerControllers();
    
    // Create new controllers
    final totalPassengers = numberOfAdults.value + numberOfChildren.value;
    
    firstNameControllers.clear();
    lastNameControllers.clear();
    passportControllers.clear();
    
    for (int i = 0; i < totalPassengers; i++) {
      firstNameControllers.add(TextEditingController());
      lastNameControllers.add(TextEditingController());
      passportControllers.add(TextEditingController());
    }
  }

  void disposePassengerControllers() {
    for (var controller in firstNameControllers) {
      controller.dispose();
    }
    for (var controller in lastNameControllers) {
      controller.dispose();
    }
    for (var controller in passportControllers) {
      controller.dispose();
    }
  }

  void calculateTotalFee() {
    if (selectedVisaId.value.isEmpty) {
      totalFee.value = 0.0;
      return;
    }
    
    final selectedVisa = visaList.firstWhere(
      (visa) => visa.id == selectedVisaId.value,
      orElse: () => visaList.first,
    );
    
    final adultPrice = selectedVisa.price;
    final childPrice = selectedVisa.price * 0.8; // 20% discount for children
    
    totalFee.value = (numberOfAdults.value * adultPrice) + (numberOfChildren.value * childPrice);
  }

  bool validateForm() {
    // Validate booker details
    if (bookerNameController.text.trim().isEmpty ||
        bookerEmailController.text.trim().isEmpty ||
        bookerPhoneController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please fill all booker details');
      return false;
    }

    // Validate passenger details
    for (int i = 0; i < firstNameControllers.length; i++) {
      if (firstNameControllers[i].text.trim().isEmpty ||
          lastNameControllers[i].text.trim().isEmpty ||
          passportControllers[i].text.trim().isEmpty) {
        Get.snackbar('Error', 'Please fill all passenger details');
        return false;
      }
    }

    return true;
  }

  void submitApplication() {
    if (!validateForm()) return;
    
    isLoading.value = true;
    
    // Create passengers list
    final List<PassengerModel> passengerList = [];
    for (int i = 0; i < firstNameControllers.length; i++) {
      final isAdult = i < numberOfAdults.value;
      final selectedVisa = visaList.firstWhere((visa) => visa.id == selectedVisaId.value);
      final price = isAdult ? selectedVisa.price : selectedVisa.price * 0.8;
      
      passengerList.add(PassengerModel(
        id: 'passenger_${i + 1}',
        firstName: firstNameControllers[i].text.trim(),
        lastName: lastNameControllers[i].text.trim(),
        passportNumber: passportControllers[i].text.trim(),
        isAdult: isAdult,
        price: price,
      ));
    }
    
    // Create application
    final application = VisaApplicationModel(
      id: 'app_${DateTime.now().millisecondsSinceEpoch}',
      visaId: selectedVisaId.value,
      numberOfAdults: numberOfAdults.value,
      numberOfChildren: numberOfChildren.value,
      passengers: passengerList,
      booker: BookerModel(
        name: bookerNameController.text.trim(),
        email: bookerEmailController.text.trim(),
        phone: bookerPhoneController.text.trim(),
      ),
      totalFee: totalFee.value,
      status: 'pending',
      applicationDate: DateTime.now(),
    );
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Visa application submitted successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      // Reset form
      clearForm();
      Get.back();
    });
  }

  void clearForm() {
    numberOfAdults.value = 1;
    numberOfChildren.value = 0;
    selectedVisaId.value = '';
    totalFee.value = 0.0;
    
    bookerNameController.clear();
    bookerEmailController.clear();
    bookerPhoneController.clear();
    
    for (var controller in firstNameControllers) {
      controller.clear();
    }
    for (var controller in lastNameControllers) {
      controller.clear();
    }
    for (var controller in passportControllers) {
      controller.clear();
    }
  }
}