import 'package:agent1/common/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TypeSelector extends StatefulWidget {
  final ValueChanged<String> onTypeChanged;
  final String initialType; // Add initialType parameter

  const TypeSelector({
    super.key,
    required this.onTypeChanged,
    required this.initialType, // Make initialType required
  });

  @override
  TypeSelectorState createState() => TypeSelectorState();
}

class TypeSelectorState extends State<TypeSelector> {
  late String selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = widget.initialType; // Use the initialType
  }

  final List<Map<String, dynamic>> travelTypes = [
    {'icon': Icons.flight, 'label': 'Flights'},
    {'icon': MdiIcons.mosque, 'label': 'Umrah'},
    {'icon': MdiIcons.bed, 'label': 'Hotels'},
    {'icon': MdiIcons.creditCard, 'label': 'Visas'},
    {'icon': MdiIcons.earth, 'label': 'Tours'},
    {'icon': MdiIcons.car, 'label': 'Cars'},
    {'icon': MdiIcons.fileDocument, 'label': 'Circulars'},
    {'icon': MdiIcons.accountGroup, 'label': 'Group Query'},
    {'icon': MdiIcons.accountGroup, 'label': 'Group Tickets'},
    {'icon': MdiIcons.bed, 'label': 'Domestic Hotels'},
    {'icon': MdiIcons.packageVariant, 'label': 'Umrah Package'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: travelTypes.map((type) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedType = type['label'];
                  widget.onTypeChanged(selectedType);
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    type['icon'],
                    color: selectedType == type['label']
                        ? TColors.primary
                        : Colors.grey,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    type['label'],
                    style: TextStyle(
                      color: selectedType == type['label']
                          ? TColors.primary
                          : Colors.grey,
                      fontWeight: selectedType == type['label']
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
