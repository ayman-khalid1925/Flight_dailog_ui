import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextformField extends StatefulWidget {
  const CustomTextformField({super.key});

  @override
  State<CustomTextformField> createState() => _CustomTextformFieldState();
}

class _CustomTextformFieldState extends State<CustomTextformField> {
  String selectedTripType = 'Round Trip';

  TextEditingController flighteditingController = TextEditingController();
  TextEditingController passengereditingController = TextEditingController();

  List<String> dropMenuList = [
    'First Class',
    'Bussiness Class',
    'Economy Class',
  ];

  DateTime? selectedDate;
  DateTime selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF16213E),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search Flight',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.flight_takeoff,
                              color: Colors.white70,
                              size: 16,
                            ),
                          ),
                          Container(
                            width: 1.5,
                            height: 55,
                            color: Colors.white30,
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.flight_land,
                              color: Colors.white70,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          children: [
                            FlightTextField(
                              label: 'From',
                              hintText: 'Jakarta, Indonesia(CGK)',
                            ),
                            SizedBox(height: 2),
                            FlightTextField(
                              label: 'To',
                              hintText: 'Lahore, Pakistan(CGK)',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Positioned.fill(
              top: 250,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Trip Segment Selector (Round Trip, One Way, Multi City)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTripTypeTab('Round Trip'),
                          _buildTripTypeTab('One Way'),
                          _buildTripTypeTab('Multi City'),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Departure & Return Dates
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (_) => Container(
                                    height: 300,
                                    color: CupertinoColors.systemBackground
                                        .resolveFrom(context),
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.time,
                                      initialDateTime: selectedTime,
                                      use24hFormat:
                                          false, // true for 24-hour format
                                      onDateTimeChanged: (DateTime newTime) {
                                        setState(() {
                                          selectedTime = newTime;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: _buildInfoField(
                                'Time',
                                "${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}",
                              ),
                            ),
                            // child: _buildInfoField(
                            //   'Departure',
                            //   '21 January 2022',
                            // ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,

                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );

                                if (picked != null) {
                                  setState(() {
                                    selectedDate = picked;
                                  });
                                }
                              },
                              child: _buildInfoField(
                                'Date',
                                selectedDate == null
                                    ? "Select Date"
                                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                              ),
                            ),
                            // child: _buildInfoField('Time', '23-May-2025'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      flightDropDownField(
                        context: context,
                        controller: flighteditingController,
                        label: 'Flight Class',
                        items: const [
                          'First Class',
                          'Bussiness Class',
                          'Economy Class',
                        ],
                      ),
                      const SizedBox(height: 16),
                      flightDropDownField(
                        context: context,
                        controller: passengereditingController,
                        label: 'Total Passengers',
                        items: const [
                          'One Passengers',
                          'Two Passengers',
                          'three Passengers',
                          'Four Passengers',
                          'Five Passengers',
                          'Six Passengers',
                        ],
                      ),
                      const SizedBox(height: 28),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Search Flights',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripTypeTab(String type) {
    final isSelected = selectedTripType == type;
    return GestureDetector(
      onTap: () => setState(() => selectedTripType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF16213E) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          type,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black38,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.black38, fontSize: 11),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget flightDropDownField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required List<String> items,
  }) {
    return TextFormField(
      controller: controller,

      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black38, fontSize: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: PopupMenuButton<String>(
          constraints: const BoxConstraints(),
          icon: const Icon(Icons.keyboard_arrow_down),
          onSelected: (value) {
            controller.text = value;
          },
          itemBuilder: (context) => items
              .map(
                (item) => PopupMenuItem<String>(value: item, child: Text(item)),
              )
              .toList(),
        ),
      ),
    );
  }
}

class FlightTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;

  const FlightTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        TextFormField(
          style: TextStyle(color: Colors.white, fontSize: 16),
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 190, 190, 190),
              fontSize: 15,
            ),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 0,
            ),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            border: InputBorder.none,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
