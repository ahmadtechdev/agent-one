// visa_list_screen.dart
import 'package:agent1/views/top_bar/visa/visa_apply/visa_apply.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'visa_controller.dart';

class VisaListScreen extends StatelessWidget {
  final VisaController controller = Get.put(VisaController());

  VisaListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      // Add height constraint to prevent unbounded height issues
      height: 600, // You can adjust this value or make it dynamic
      child: Column(
        children: [
          // Search and Filter Section
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  onChanged: (value) => controller.searchVisas(value),
                  decoration: InputDecoration(
                    hintText: 'Search Visas Here...',
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xff040677)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xff040677)),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                ),
                const SizedBox(height: 12),
                // Filter Chips
                Row(
                  children: [
                    const Text(
                      'Filter: ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4A4B4D),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: ['All', 'Tourist', 'Transit'].map((filter) {
                            return Obx(() => Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: FilterChip(
                                    label: Text(filter),
                                    selected: controller.selectedFilter.value ==
                                        filter,
                                    onSelected: (bool selected) {
                                      if (selected) {
                                        controller.setFilter(filter);
                                      }
                                    },
                                    selectedColor: const Color(0xff040677)
                                        .withOpacity(0.2),
                                    checkmarkColor: const Color(0xff040677),
                                  ),
                                ));
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Visa Count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            child: Row(
              children: [
                Obx(() => Text(
                      '${controller.filteredVisaList.length} Visas found',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff4A4B4D),
                      ),
                    )),
              ],
            ),
          ),
          // Visa List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff040677)),
                  ),
                );
              }

              if (controller.filteredVisaList.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flight_takeoff,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No visas found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                // physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(0),
                itemCount: controller.filteredVisaList.length,
                itemBuilder: (context, index) {
                  final visa = controller.filteredVisaList[index];
                  return VisaCard(visa: visa);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class VisaCard extends StatelessWidget {
  final dynamic visa;

  const VisaCard({Key? key, required this.visa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with flag and passport image
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              gradient: LinearGradient(
                colors: [
                  const Color(0xff040677).withOpacity(0.8),
                  const Color(0xff040677).withOpacity(0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                'assets/images/1.png',
                width: double.infinity,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.white,
                          Colors.black,
                          Colors.green
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Visa Details
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  visa.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff4A4B4D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'From ${visa.country} Immigration',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Duration: ${visa.duration}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff7C7D7E),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Entry: ${visa.entryType}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff7C7D7E),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'RS ${visa.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff040677),
                          ),
                        ),
                        Text(
                          visa.currency,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      visa.country.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff7C7D7E),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => VisaApplicationScreen(visa: visa));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff040677),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'APPLY NOW',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
