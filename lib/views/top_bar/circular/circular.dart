import 'package:agent1/common/color_extension.dart';
import 'package:agent1/views/top_bar/circular/circular_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Main Screen Widget
class AirlineCircularsScreen extends StatelessWidget {
  const AirlineCircularsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AirlineCircularsController());
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Enhanced Header Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  TColors.primary,
                  TColors.primary.withOpacity(0.8),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: TColors.primary.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with icon
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: TColors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.airplane_ticket,
                        color: TColors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Airline Circulars',
                      style: TextStyle(
                        color: TColors.white,
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenWidth * 0.04),
                // Enhanced Filter Section
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenWidth * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: TColors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: TColors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Obx(() => DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedAirline.value.isEmpty
                              ? null
                              : controller.selectedAirline.value,
                          hint: Row(
                            children: [
                              Icon(
                                Icons.filter_list,
                                color: TColors.white.withOpacity(0.8),
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Filter by airline',
                                style: TextStyle(
                                  color: TColors.white.withOpacity(0.9),
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          dropdownColor: TColors.primary,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: TColors.white,
                            size: 20,
                          ),
                          isExpanded: true,
                          items: [
                            DropdownMenuItem<String>(
                              value: '',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.all_inclusive,
                                    color: TColors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'All Airlines',
                                    style: TextStyle(
                                      color: TColors.white,
                                      fontSize: screenWidth * 0.035,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ...controller.uniqueAirlines
                                .map((airline) => DropdownMenuItem<String>(
                                      value: airline,
                                      child: Text(
                                        airline,
                                        style: TextStyle(
                                          color: TColors.white,
                                          fontSize: screenWidth * 0.035,
                                        ),
                                      ),
                                    )),
                          ],
                          onChanged: (value) =>
                              controller.filterByAirline(value ?? ''),
                        ),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // Enhanced Circulars List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(TColors.primary),
                        strokeWidth: 3,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Loading circulars...',
                        style: TextStyle(
                          color: TColors.secondaryText,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (controller.filteredCirculars.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: screenWidth * 0.12,
                        color: TColors.placeholder,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No circulars found',
                        style: TextStyle(
                          color: TColors.secondaryText,
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                // padding: EdgeInsets.all(screenWidth * 0.04),
                itemCount: controller.filteredCirculars.length,
                itemBuilder: (context, index) {
                  final circular = controller.filteredCirculars[index];

                  return Obx(() {
                    final isExpanded = controller.isExpanded(circular.id);

                    return Container(
                      margin: EdgeInsets.only(bottom: screenWidth * 0.03),
                      decoration: BoxDecoration(
                        color: TColors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isExpanded
                              ? TColors.primary.withOpacity(0.3)
                              : Colors.transparent,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isExpanded
                                ? TColors.primary.withOpacity(0.15)
                                : TColors.primary.withOpacity(0.08),
                            blurRadius: isExpanded ? 12 : 8,
                            offset: Offset(0, isExpanded ? 4 : 2),
                          ),
                        ],
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Column(
                          children: [
                            // Enhanced Header Row
                            InkWell(
                              onTap: () =>
                                  controller.toggleExpansion(circular.id),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: EdgeInsets.all(screenWidth * 0.04),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Enhanced Date Column
                                    Container(
                                      width: screenWidth * 0.18,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: TColors.primary.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            circular.date.split(' ')[1],
                                            style: TextStyle(
                                              color: TColors.primary,
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenWidth * 0.035,
                                            ),
                                          ),
                                          Text(
                                            circular.date.split(' ')[2],
                                            style: TextStyle(
                                              color: TColors.primary,
                                              fontWeight: FontWeight.w600,
                                              fontSize: screenWidth * 0.03,
                                            ),
                                          ),
                                          Text(
                                            circular.date.split(' ')[3],
                                            style: TextStyle(
                                              color: TColors.secondaryText,
                                              fontSize: screenWidth * 0.025,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.03),
                                    // Enhanced Airline Column
                                    Container(
                                      width: screenWidth * 0.22,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: TColors.secondary
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              circular.airlineLogo,
                                              style: TextStyle(
                                                  fontSize:
                                                      screenWidth * 0.045),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            circular.airline,
                                            style: TextStyle(
                                              color: TColors.primaryText,
                                              fontWeight: FontWeight.w600,
                                              fontSize: screenWidth * 0.028,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.03),
                                    // Enhanced Subject Column
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            circular.subject,
                                            style: TextStyle(
                                              color: TColors.primaryText,
                                              fontWeight: FontWeight.w600,
                                              fontSize: screenWidth * 0.033,
                                              height: 1.3,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                        ],
                                      ),
                                    ),
                                    // Enhanced Animated Arrow
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: isExpanded
                                            ? TColors.primary.withOpacity(0.1)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: AnimatedRotation(
                                        turns: isExpanded ? 0.5 : 0.0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: isExpanded
                                              ? TColors.primary
                                              : TColors.placeholder,
                                          size: screenWidth * 0.06,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Enhanced Expandable Content
                            AnimatedSize(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                              child: isExpanded
                                  ? Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.fromLTRB(
                                        screenWidth * 0.04,
                                        0,
                                        screenWidth * 0.04,
                                        screenWidth * 0.04,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: TColors.primary
                                                .withOpacity(0.2),
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: screenWidth * 0.04),
                                          Container(
                                            padding: EdgeInsets.all(
                                                screenWidth * 0.04),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  TColors.background,
                                                  TColors.background
                                                      .withOpacity(0.7),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: TColors.primary
                                                    .withOpacity(0.1),
                                              ),
                                            ),
                                            child: Text(
                                              circular.content,
                                              style: TextStyle(
                                                color: TColors.primaryText,
                                                fontSize: screenWidth * 0.032,
                                                height: 1.6,
                                                letterSpacing: 0.2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
