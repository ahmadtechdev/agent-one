import 'package:agent1/common/color_extension.dart';
import 'package:agent1/views/booking_card/type_selector/type_selector.dart';
import 'package:agent1/views/top_bar/cars/search_cars/search_cars.dart';
import 'package:agent1/views/top_bar/circular/circular.dart';
import 'package:agent1/views/top_bar/domastic_hotels/hotel/domastic_hotel_form.dart';
import 'package:agent1/views/top_bar/flight/form/flight_form.dart';
import 'package:agent1/views/top_bar/group_query/group_query.dart';
import 'package:agent1/views/top_bar/group_ticket/group_ticket.dart';
import 'package:agent1/views/top_bar/hotel/hotel/hotel_form.dart';
import 'package:agent1/views/top_bar/tour/search_tour/tour_form.dart';
import 'package:agent1/views/top_bar/umrah/umrah.dart';
import 'package:agent1/views/top_bar/umrah_pkg/umrah_pkg.dart';
import 'package:agent1/views/top_bar/visa/visa_view.dart';
import 'package:flutter/material.dart';

class BookingCard extends StatefulWidget {
  final String? initialType;

  const BookingCard({
    super.key,
    this.initialType,
  });

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  late String selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = widget.initialType ?? 'Flights';
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 40),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: TColors.primary.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TypeSelector(
                initialType: selectedType,
                onTypeChanged: (String type) {
                  setState(() {
                    selectedType = type;
                  });
                },
              ),
              const SizedBox(height: 16),
              if (selectedType == 'Flights') FlightBookingScreen(),
              if (selectedType == 'Umrah') Umrah(),
              if (selectedType == 'Hotels') HotelForm(),
              if (selectedType == 'Visas') VisaListScreen(),
              if (selectedType == 'Tours') const ToursForm(),
              if (selectedType == 'Cars') const SearchCars(),
              if (selectedType == 'Circulars') AirlineCircularsScreen(),
              if (selectedType == 'Group Tickets') GroupTicket(),
              if (selectedType == 'Domestic Hotels') DomasticHotelForm(),
              if (selectedType == 'Umrah Package') UmrahPkg(),
              if (selectedType == 'Group Query') GroupQuery(),
            ],
          ),
        ),
      ),
    );
  }
}
