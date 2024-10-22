

import 'package:broadway/hospital_app/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'booking_screen_2.dart';

class AppointmentConfirmationPage extends StatelessWidget {
  const AppointmentConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppointmentConfirmationProvider(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Appointment', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004CFF))),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppointmentDetails(),
                const SizedBox(height: 24),
                _buildTokenNumbers(),
                const SizedBox(height: 24),
                _buildRemindMeBefore(),
                const SizedBox(height: 24),
                _buildNotifyMeAt(),
                const SizedBox(height: 24),
                _buildConfirmButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentDetails() {
    return Consumer<AppointmentConfirmationProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Date', DateFormat('dd/MM/yyyy').format(provider.appointmentDate)),
            const SizedBox(height: 16),
            _buildDetailRow('Time Slot Booked', DateFormat('hh:mm a').format(provider.appointmentDate)),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
        Text(value, style: const TextStyle(fontSize: 16, color: Color(0xFF004CFF), fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTokenNumbers() {
    return Consumer<AppointmentConfirmationProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            _buildTokenNumberField('Token Number Recieved', provider.tokenNumberReceived),
            const SizedBox(height: 16),
            _buildTokenNumberField('Token Number Inside', provider.tokenNumberInside),
          ],
        );
      },
    );
  }

  Widget _buildTokenNumberField(String label, String value) {
    return Row(

      children: [
        Text(label, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
        Spacer(),

        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
          decoration: BoxDecoration(border: Border.all(color: Color(0xff004CFF)),
            color: const Color(0xFFEEF1FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildRemindMeBefore() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Remind Me Before', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Consumer<AppointmentConfirmationProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [30, 40, 25, 10, 35].map((minutes) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15 ),
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide.none,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          provider.setRemindBefore(minutes);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: provider.remindBefore == minutes
                                ? const Color(0xFF004CFF)
                                : Color.fromRGBO(0, 75, 254, 0.08),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '$minutes',
                                style: TextStyle(
                                  color: provider.remindBefore == minutes ? Colors.white : Color(0xff004CFF),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Min',
                                style: TextStyle(
                                  color: provider.remindBefore == minutes ? Colors.white : Color(0xff004CFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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


  Widget _buildNotifyMeAt() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Notify Me at', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
        const Text('*Token No.', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 12),
        Consumer<AppointmentConfirmationProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [14, 15, 16, 17, 18].map((tokenNumber) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Material(
                      shape: CircleBorder(
                        side: BorderSide.none, // No border
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          provider.setNotifyAt(tokenNumber);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: provider.notifyAt == tokenNumber
                                ? const Color(0xFF004CFF)
                                : Color.fromRGBO(0, 75, 254, 0.08),
                            shape: BoxShape.circle, // Make it circular
                          ),
                          padding: const EdgeInsets.all(16), // Adjust padding as needed
                          child: Text(
                            '$tokenNumber',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,
                              color: provider.notifyAt == tokenNumber ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
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


  Widget _buildConfirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen2(),));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF004CFF),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }
}