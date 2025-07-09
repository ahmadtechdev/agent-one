import 'package:flutter/material.dart';

class umrah {
  final String name;
  final String description;
  final String image;

  umrah({
    required this.name,
    required this.description,
    required this.image,
  });
}

class GroupTicket extends StatefulWidget {
  const GroupTicket({super.key});

  @override
  State<GroupTicket> createState() => _GroupTicketState();
}

class _GroupTicketState extends State<GroupTicket> {
  final List<umrah> allumrahs = [
    umrah(
      name: 'One Way Group Tickets',
      description: 'Explore available one-way group ticket options for your travels.',
      image: 'assets/img/g_ticket/1.png',
    ),
    umrah(
      name: 'Umrah Group Tickets',
      description: 'Book group tickets for your Umrah trip with ease and convenience.',
      image: 'assets/img/g_ticket/2.png',
    ),
    umrah(
      name: 'All Group Tickets',
      description: 'Browse and book tickets for all group options available at the best rates.',
      image: 'assets/img/g_ticket/3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allumrahs.length,
                itemBuilder: (context, index) {
                  final umrah = allumrahs[index];
                  return InkWell(
                    onTap: () {
                      // Add your navigation or action here
                      print('Clicked on ${umrah.name}');
                    },
                    child: Container(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 270,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              image: DecorationImage(
                                image: AssetImage(umrah.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            child: Text(
                              umrah.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              umrah.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}