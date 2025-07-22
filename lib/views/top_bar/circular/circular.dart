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
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      // Remove height constraints to allow dynamic expansion
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Allow column to size itself based on content
        children: [
          // Enhanced Header Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.03),
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
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: TColors.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
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
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: TColors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.airplane_ticket,
                        color: TColors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        'Airline Circulars',
                        style: TextStyle(
                          color: TColors.white,
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenWidth * 0.03),
                // Enhanced Filter Section
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.025,
                    vertical: screenWidth * 0.015,
                  ),
                  decoration: BoxDecoration(
                    color: TColors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: TColors.white.withOpacity(0.3),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
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
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  'Filter by airline',
                                  style: TextStyle(
                                    color: TColors.white.withOpacity(0.9),
                                    fontSize: screenWidth * 0.032,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          dropdownColor: TColors.primary,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: TColors.white,
                            size: 18,
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
                                    size: 14,
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      'All Airlines',
                                      style: TextStyle(
                                        color: TColors.white,
                                        fontSize: screenWidth * 0.032,
                                      ),
                                      overflow: TextOverflow.ellipsis,
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
                                          fontSize: screenWidth * 0.032,
                                        ),
                                        overflow: TextOverflow.ellipsis,
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
          SizedBox(height: 12),
          // Enhanced Circulars List - Now with dynamic height and scroll-to-top
          Obx(() {
            if (controller.isLoading.value) {
              return Container(
                height: 200, // Fixed height for loading state
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(TColors.primary),
                        strokeWidth: 2.5,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Loading circulars...',
                        style: TextStyle(
                          color: TColors.secondaryText,
                          fontSize: screenWidth * 0.032,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (controller.filteredCirculars.isEmpty) {
              return Container(
                height: 200, // Fixed height for empty state
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: screenWidth * 0.1,
                        color: TColors.placeholder,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No circulars found',
                        style: TextStyle(
                          color: TColors.secondaryText,
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Calculate dynamic height based on number of items
            // Estimate height per item (collapsed state)
            double estimatedItemHeight =
                screenWidth * 0.25; // Approximate height per card
            double maxContentHeight =
                screenHeight * 0.6; // Max height before scrolling
            double contentHeight =
                controller.filteredCirculars.length * estimatedItemHeight;

            // Use calculated height or max height, whichever is smaller
            double listHeight = contentHeight > maxContentHeight
                ? maxContentHeight
                : contentHeight;

            return Container(
              height: listHeight,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  scrollbars: false, // Hide scrollbar for cleaner look
                ),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  itemCount: controller.filteredCirculars.length,
                  // Add scroll-to-top behavior when reaching the end
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final circular = controller.filteredCirculars[index];

                    return Obx(() {
                      final isExpanded = controller.isExpanded(circular.id);

                      return Container(
                        margin: EdgeInsets.only(bottom: screenWidth * 0.025),
                        decoration: BoxDecoration(
                          color: TColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isExpanded
                                ? TColors.primary.withOpacity(0.3)
                                : Colors.transparent,
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isExpanded
                                  ? TColors.primary.withOpacity(0.12)
                                  : TColors.primary.withOpacity(0.06),
                              blurRadius: isExpanded ? 8 : 6,
                              offset: Offset(0, isExpanded ? 3 : 2),
                            ),
                          ],
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          child: Column(
                            children: [
                              // Enhanced Header Row
                              InkWell(
                                onTap: () =>
                                    controller.toggleExpansion(circular.id),
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: EdgeInsets.all(screenWidth * 0.03),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Enhanced Date Column
                                      Container(
                                        width: screenWidth * 0.15,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 6,
                                          horizontal: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              TColors.primary.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        
                                        child: Column(
                                          children: [
                                            Text(
                                              circular.date.split(' ')[1],
                                              style: TextStyle(
                                                color: TColors.primary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth * 0.032,
                                              ),
                                            ),
                                            Text(
                                              circular.date.split(' ')[2],
                                              style: TextStyle(
                                                color: TColors.primary,
                                                fontWeight: FontWeight.w600,
                                                fontSize: screenWidth * 0.027,
                                              ),
                                            ),
                                            Text(
                                              circular.date.split(' ')[3],
                                              style: TextStyle(
                                                color: TColors.secondaryText,
                                                fontSize: screenWidth * 0.022,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.025),
                                      // Enhanced Airline Column
                                      Container(
                                        width: screenWidth * 0.2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                color: TColors.secondary
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              
                                              child: Text(
                                                circular.airlineLogo,
                                                style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.04),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              circular.airline,
                                              style: TextStyle(
                                                color: TColors.primaryText,
                                                fontWeight: FontWeight.w600,
                                                fontSize: screenWidth * 0.025,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.025),
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
                                                fontSize: screenWidth * 0.03,
                                                height: 1.3,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2),
                                          ],
                                        ),
                                      ),
                                      // Enhanced Animated Arrow
                                      Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: isExpanded
                                              ? TColors.primary.withOpacity(0.1)
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: AnimatedRotation(
                                          turns: isExpanded ? 0.5 : 0.0,
                                          duration:
                                              const Duration(milliseconds: 250),
                                          curve: Curves.easeInOut,
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: isExpanded
                                                ? TColors.primary
                                                : TColors.placeholder,
                                            size: screenWidth * 0.05,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Enhanced Expandable Content
                              AnimatedSize(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeInOut,
                                child: isExpanded
                                    ? Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.fromLTRB(
                                          screenWidth * 0.03,
                                          0,
                                          screenWidth * 0.03,
                                          screenWidth * 0.03,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: TColors.primary
                                                  .withOpacity(0.2),
                                              width: 0.8,
                                            ),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height: screenWidth * 0.03),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  screenWidth * 0.03),
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
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: TColors.primary
                                                      .withOpacity(0.1),
                                                ),
                                              ),
                                              child: Text(
                                                circular.content,
                                                style: TextStyle(
                                                  color: TColors.primaryText,
                                                  fontSize: screenWidth * 0.029,
                                                  height: 1.5,
                                                  letterSpacing: 0.1,
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
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
