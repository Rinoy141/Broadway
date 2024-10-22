
import 'package:broadway/hospital_app/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'appointment_calendar.dart';
import 'appointment_details.dart';
import 'models.dart';

class AppointmentPage extends StatelessWidget {
  final Doctor doctor;

  const AppointmentPage({Key? key, required this.doctor}) : super(key: key);

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
          centerTitle: true,  title: const Text('Appointment',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff004CFF)),),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDoctorInfo(),
                const SizedBox(height: 16),
                const SizedBox(height: 24),
                _buildDetails(),
                const SizedBox(height: 40),
                _buildWorkingHours(),
                const SizedBox(height: 24),
                _buildDateSelection(context),
                const SizedBox(height: 40),
                _buildBookButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            doctor.imagePath,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                doctor.specialization ?? 'General Practitioner',
                style: const TextStyle(color: Color(0xff85A8FB)),
              ),
              Row(
                children: [
                  Text('Payment',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text(
                    '\$${doctor.payment?.toStringAsFixed(2) ?? '150.00'}',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff85A8FB)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget _buildContactIcons() {
  //   return const Row(
  //     children: [
  //       Icon(Icons.message_outlined, color: Colors.blue),
  //       SizedBox(width: 8),
  //       Icon(Icons.phone_outlined, color: Colors.blue),
  //       SizedBox(width: 8),
  //       Icon(Icons.video_call_outlined, color: Colors.blue),
  //     ],
  //   );
  // }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(
          doctor.description,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildWorkingHours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Working Hours',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('See all', style: TextStyle(color: Color(0xff858585))),
          ],
        ),
        const SizedBox(height: 20),
        Consumer<AppointmentProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: provider.availableTimeSlots.map((timeSlot) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ChoiceChip(
                      side: BorderSide.none,
                      backgroundColor: Color.fromRGBO(217, 217, 217, 0.3),
                      selectedColor: Color(0xffC7D6FB),
                      showCheckmark: false,
                      label: Text(timeSlot,style: TextStyle(fontSize: 20),),
                      selected: provider.selectedTimeSlot == timeSlot,
                      onSelected: (selected) {
                        if (selected) {
                          provider.selectTimeSlot(timeSlot);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDateSelection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Date',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        AppointmentCalendarPage(doctor: doctor),
                  ),
                );
              },
              child: const Text('See all',
                  style: TextStyle(color: Color(0xff858585))),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Consumer<AppointmentProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: provider.availableDates.map((date) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ChoiceChip(
                      side: BorderSide.none,
                      backgroundColor: Color.fromRGBO(217, 217, 217, 0.3),
                      selectedColor: Color(0xffC7D6FB),
                      showCheckmark: false,
                      label: Text(DateFormat('E, d MMM').format(date),style: TextStyle(fontSize: 20),),
                      // Format the DateTime for display
                      selected: provider.selectedDate == date,
                      onSelected: (selected) {
                        if (selected) {
                          provider.selectDate(date);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBookButton() {
    return SizedBox(
      width: double.infinity,
      child: Consumer<AppointmentProvider>(
        builder: (context, provider, child) {
          return ElevatedButton(
            onPressed: provider.canBookAppointment
                ? () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AppointmentConfirmationPage(),
                ),
              );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Appointment booked for ${provider.selectedDate} at ${provider.selectedTimeSlot}')),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              backgroundColor:Color(0xff004CFF),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Book an Appointment',style: TextStyle(color: Colors.white,fontSize: 24),),
          );
        },
      ),
    );
  }
}
