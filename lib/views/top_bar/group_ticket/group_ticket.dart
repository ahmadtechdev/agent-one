import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/api_service_group_tickets.dart';
import 'package:agent1/views/top_bar/group_ticket/flight_pkg/select_pkg.dart';

class GroupTicket extends StatefulWidget {
  const GroupTicket({super.key});

  @override
  State<GroupTicket> createState() => _GroupTicketState();
}

class _GroupTicketState extends State<GroupTicket> {
  @override
  Widget build(BuildContext context) {
    // Create the controller once and reuse it
    final GroupTicketingController controller = Get.put(
      GroupTicketingController(),
      permanent: true,
    );

    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              // First Container - One Way Group Tickets
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () async {
                    await controller.fetchCombinedGroups(
                      'UAE',
                      'UAE     ',
                    );
                    Get.to(() => SelectPkgScreen());
                    Get.snackbar(
                      "Loading",
                      "UAE One Way Groups data loaded",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 270,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          image: DecorationImage(
                            image: AssetImage('assets/img/g_ticket/1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Align(
                        child: Text(
                          'One Way Group Tickets',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Explore available one-way group ticket options for your travels.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              // Second Container - Umrah Group Tickets
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () async {
                    await controller.fetchCombinedGroups(
                      'UMRAH',
                      'UMRAH',
                    );
                    Get.to(() => SelectPkgScreen());
                    Get.snackbar(
                      "Loading",
                      "UMRAH data loaded",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 270,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          image: DecorationImage(
                            image: AssetImage('assets/img/g_ticket/2.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Align(
                        child: Text(
                          'Umrah Group Tickets',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Book group tickets for your Umrah trip with ease and convenience.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              // Third Container - All Group Tickets
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () async {
                    await controller.fetchCombinedGroups(
                      '     ',
                      '     ',
                    );
                    Get.to(() => SelectPkgScreen());
                    Get.snackbar(
                      "Loading",
                      "All Types data loaded",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 270,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          image: DecorationImage(
                            image: AssetImage('assets/img/g_ticket/3.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Align(
                        child: Text(
                          'All Group Tickets',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Browse and book tickets for all group options available at the best rates.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
