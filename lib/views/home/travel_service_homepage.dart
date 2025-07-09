import 'package:agent1/views/home/home.dart';
import 'package:flutter/material.dart';

class TravelServicesHomePage extends StatelessWidget {
  final List<Map<String, dynamic>> services = [
    {'title': 'Flights', 'icon': 'assets/img/home/1.png', 'type': 'Flights'},
    {'title': 'Umrah 2024', 'icon': 'assets/img/home/2.png', 'type': 'Umrah'},
    {
      'title': 'International Hotels',
      'icon': 'assets/img/home/3.png',
      'type': 'Hotels'
    },
    {
      'title': 'Group Ticketing',
      'icon': 'assets/img/home/4.png',
      'type': 'Group Tickets'
    },
    {
      'title': 'Domestic Hotels',
      'icon': 'assets/img/home/5.png',
      'type': 'Domestic Hotels'
    },
    {
      'title': 'Domestic Tours',
      'icon': 'assets/img/home/6.png',
      'type': 'Tours'
    },
    {
      'title': 'World Wide Visa',
      'icon': 'assets/img/home/7.png',
      'type': 'Visas'
    },
    {
      'title': 'International Tours',
      'icon': 'assets/img/home/8.png',
      'type': 'Tours'
    },
    {
      'title': 'Travel Insurance',
      'icon': 'assets/img/home/9.png',
      'type': 'Insurance'
    },
    {'title': 'Car Rental', 'icon': 'assets/img/home/10.png', 'type': 'Cars'},
    {
      'title': 'Group Query',
      'icon': 'assets/img/home/11.png',
      'type': 'Group Query'
    },
    {
      'title': 'Airline Circulars',
      'icon': 'assets/img/home/12.png',
      'type': 'Circulars'
    },
    {
      'title': 'Travel Accounts',
      'icon': 'assets/img/home/13.png',
      'type': 'Accounts'
    },
    {
      'title': 'Technology Partner',
      'icon': 'assets/img/home/14.png',
      'type': 'Technology'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff0D13A1),
              Color.fromARGB(255, 30, 148, 232),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                child: Text(
                  'Travel Services',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      return ServiceCard(
                        title: services[index]['title']!,
                        iconPath: services[index]['icon']!,
                        type: services[index]['type']!,
                        onTap: () =>
                            _navigateToHome(context, services[index]['type']!),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToHome(BuildContext context, String type) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(initialType: type),
      ),
    );
    print('the type is ${type}');
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final String type;
  final VoidCallback onTap;

  const ServiceCard({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.type,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          title == 'Flights'
                              ? Colors.orange
                              : Colors.blue.shade900,
                          title == 'Flights'
                              ? Colors.deepOrange
                              : Colors.blue.shade800,
                        ],
                      ),
                    ),
                    child: Image.asset(
                      iconPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.image_not_supported,
                          size: 48,
                          color: Colors.white54,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20)),
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade900,
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
}
