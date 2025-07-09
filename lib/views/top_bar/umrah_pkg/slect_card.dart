import 'package:agent1/common/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroupTicketsCard extends StatelessWidget {
  final List<FlightData> selectedFlights;
  final Function(FlightData) onFlightSelected;
  final Function(FlightData) onFlightRemoved;

  const GroupTicketsCard({
    Key? key,
    required this.selectedFlights,
    required this.onFlightSelected,
    required this.onFlightRemoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        color: TColors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            ListTile(
              onTap: () => _showFlightSelectionDialog(context),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(Icons.airplane_ticket, color: TColors.primary),
              title: Text(
                'Group Tickets',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: TColors.primaryText,
                ),
              ),
              trailing: Icon(Icons.add_circle_outline, color: TColors.primary),
            ),

            // Selected Flights
            if (selectedFlights.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: selectedFlights.length,
                itemBuilder: (context, index) =>
                    _buildSelectedFlightTile(selectedFlights[index]),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedFlightTile(FlightData flight) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Flight Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Flight Number and Sector
                Row(
                  children: [
                    Text(
                      flight.flightNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: TColors.primary,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: TColors.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        flight.sector,
                        style: TextStyle(
                          color: TColors.secondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Date and Time
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 14, color: TColors.secondaryText),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('dd MMM yyyy').format(flight.date),
                      style: TextStyle(
                        color: TColors.secondaryText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),

                // Time, Seat, and Baggage
                Row(
                  children: [
                    Icon(Icons.schedule,
                        size: 14, color: TColors.secondaryText),
                    const SizedBox(width: 4),
                    Text(
                      '${flight.departureTime} - ${flight.arrivalTime}',
                      style: TextStyle(
                        color: TColors.secondaryText,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.event_seat,
                        size: 14, color: TColors.secondaryText),
                    const SizedBox(width: 4),
                    Text(
                      'Seat ${flight.seat}',
                      style: TextStyle(
                        color: TColors.secondaryText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.luggage, size: 14, color: TColors.secondaryText),
                    const SizedBox(width: 4),
                    Text(
                      '${flight.baggage}kg',
                      style: TextStyle(
                        color: TColors.secondaryText,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.price_change,
                        size: 14, color: TColors.secondaryText),
                    const SizedBox(width: 4),
                    Text(
                      'Rs${flight.price}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Remove Button
          IconButton(
            icon: Icon(Icons.close, size: 20, color: TColors.third),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () => onFlightRemoved(flight),
          ),
        ],
      ),
    );
  }

  void _showFlightSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dialog Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Flight',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: TColors.primaryText,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: TColors.third),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // Flight List
              Flexible(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _getDummyFlights().length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child:
                        _buildFlightOption(context, _getDummyFlights()[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlightOption(BuildContext context, FlightData flight) {
    final isSelected = selectedFlights.contains(flight);

    return InkWell(
      onTap: isSelected
          ? null
          : () {
              onFlightSelected(flight);
              Navigator.pop(context);
            },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? Colors.grey.shade300
                : TColors.primary.withOpacity(0.2),
          ),
          color: isSelected ? Colors.grey.shade50 : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flight Number and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      flight.flightNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.grey : TColors.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: (isSelected ? Colors.grey : TColors.secondary)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        flight.sector,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Colors.grey : TColors.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'PKR ${NumberFormat('#,###').format(flight.price)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.grey : TColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Flight Details
            DefaultTextStyle(
              style: TextStyle(
                color: TColors.secondaryText,
                fontSize: 12,
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 14, color: TColors.secondaryText),
                  const SizedBox(width: 4),
                  Text(DateFormat('dd MMM yyyy').format(flight.date)),
                  const SizedBox(width: 16),
                  Icon(Icons.schedule, size: 14, color: TColors.secondaryText),
                  const SizedBox(width: 4),
                  Text('${flight.departureTime} - ${flight.arrivalTime}'),
                ],
              ),
            ),
            const SizedBox(height: 4),

            // Seat and Baggage
            DefaultTextStyle(
              style: TextStyle(
                color: TColors.secondaryText,
                fontSize: 12,
              ),
              child: Row(
                children: [
                  Icon(Icons.event_seat,
                      size: 14, color: TColors.secondaryText),
                  const SizedBox(width: 4),
                  Text('Seat ${flight.seat}'),
                  const SizedBox(width: 16),
                  Icon(Icons.luggage, size: 14, color: TColors.secondaryText),
                  const SizedBox(width: 4),
                  Text('${flight.baggage}kg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FlightData> _getDummyFlights() {
    return [
      FlightData(
        flightNumber: 'ER-421',
        sector: 'LHE-JED',
        date: DateTime(2025, 2, 12),
        departureTime: '08:05',
        arrivalTime: '11:40',
        seat: '01',
        baggage: 50,
        price: 168500,
      ),
      FlightData(
        flightNumber: '739',
        sector: 'LHE-JED',
        date: DateTime(2025, 2, 14),
        departureTime: '01:50',
        arrivalTime: '01:50',
        seat: '02',
        baggage: 23,
        price: 168500,
      ),
      FlightData(
        flightNumber: '740',
        sector: 'LHE-JED',
        date: DateTime(2025, 2, 15),
        departureTime: '01:50',
        arrivalTime: '01:50',
        seat: '02',
        baggage: 23,
        price: 16850,
      ),
    ];
  }
}

class FlightData {
  final String flightNumber;
  final String sector;
  final DateTime date;
  final String departureTime;
  final String arrivalTime;
  final String seat;
  final int baggage;
  final double price;

  FlightData({
    required this.flightNumber,
    required this.sector,
    required this.date,
    required this.departureTime,
    required this.arrivalTime,
    required this.seat,
    required this.baggage,
    required this.price,
  });
}
