import 'package:flutter/material.dart';

class umrah {
  final String name;
  final String image;

  umrah({
    required this.name,
    required this.image,
  });
}

class Umrah extends StatefulWidget {
  const Umrah({super.key});

  @override
  State<Umrah> createState() => _UmrahState();
}

class _UmrahState extends State<Umrah> {
  final List<umrah> allumrahs = [
    umrah(
      name: 'Umrah Group Tickets',
      image: 'assets/img/umrah/1.png',
    ),
    umrah(
      name: '485 SAR Today\'s R.O.E: 76',
      image: 'assets/img/umrah/2.png',
    ),
    umrah(
      name: 'Umrah Hotels',
      image: 'assets/img/umrah/3.png',
    ),
    umrah(
      name: 'Umrah Transport',
      image: 'assets/img/umrah/4.png',
    ),
    umrah(
      name: 'Umrah Package Calculator',
      image: 'assets/img/umrah/5.png',
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
                          SizedBox(height: 10),
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
                          SizedBox(height: 10),
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
