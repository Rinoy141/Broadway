import 'package:broadway/hospital_app/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'models.dart';



class AppointmentCalendarPage extends StatelessWidget {
  final Doctor doctor;
  const AppointmentCalendarPage({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppointmentProvider(doctor),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Appointment'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCalendar(),
                const SizedBox(height: 16),
                _buildTimeSlots(),
                const SizedBox(height: 16),
                _buildSetAppointmentButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Consumer<AppointmentProvider>(
      builder: (context, provider, child) {
        final now = DateTime.now();
        final firstDay = DateTime(now.year, now.month, now.day);
        final lastDay = DateTime(now.year, now.month + 3, now.day);

        return TableCalendar<dynamic>(calendarStyle: CalendarStyle( selectedDecoration: BoxDecoration(
          color: Color(0xff004BFE),
          shape: BoxShape.circle,
        ),),
          firstDay: firstDay,
          lastDay: lastDay,
          focusedDay: provider.selectedDate ?? now,
          selectedDayPredicate: (day) {
            return provider.selectedDate != null && isSameDay(provider.selectedDate, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            provider.selectDate(selectedDay);
          },
          calendarFormat: CalendarFormat.month,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
        );
      },
    );
  }


  Widget _buildTimeSlots() {
    return Consumer<AppointmentProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Time Slots',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: provider.availableTimeSlots.map((timeSlot) {
                return ChoiceChip(  side: BorderSide.none,
                  backgroundColor: Color.fromRGBO(217, 217, 217, 0.3),
                  selectedColor: Color(0xffC7D6FB),
                  showCheckmark: false,
                  label: Text(timeSlot),
                  selected: provider.selectedTimeSlot == timeSlot,
                  onSelected: (selected) {
                    if (selected) {
                      provider.selectTimeSlot(timeSlot);
                    }
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSetAppointmentButton() {
    return Consumer<AppointmentProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: provider.canBookAppointment
                ? () {
              // Implement booking logic here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Appointment set for ${provider.selectedDate} at ${provider.selectedTimeSlot}')),
              );
              Navigator.of(context).pop();
            }
                : null,
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              backgroundColor: Color(0xff004CFF),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Set Appointment',style: TextStyle(color: Colors.white),),
          ),
        );
      },
    );
  }

  String _getDayName(int day) {
    switch (day) {
      case 1: return 'Mon';
      case 2: return 'Tue';
      case 3: return 'Wed';
      case 4: return 'Thu';
      case 5: return 'Fri';
      case 6: return 'Sat';
      case 7: return 'Sun';
      default: return '';
    }
  }
}