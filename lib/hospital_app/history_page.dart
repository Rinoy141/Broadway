
import 'package:broadway/hospital_app/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'history_details.dart';
import 'models/history model.dart';


class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => AppointmentsProvider(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('History'),
        ),
        body: Consumer<AppointmentsProvider>(
          builder: (context, appointmentsProvider, child) {
            return ListView.builder(
              itemCount: appointmentsProvider.appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointmentsProvider.getAppointment(index);
                return AppointmentCard(appointment: appointment, onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryDetailPage(appointmentIndex: index),
                    ),
                  );
                });
              },
            );
          },
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onTap;

  const AppointmentCard({Key? key, required this.appointment, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('Assets/image 5.png'), // Replace with actual image
                      radius: 24,
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.doctorName,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          appointment.specialization
                            ,style: TextStyle(color: Color(0xff8696BB)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(appointment.date,style: TextStyle(color: Color(0xff8696BB)),),
                    SizedBox(width: 16),
                    Icon(Icons.access_time, size: 16, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(appointment.time,style: TextStyle(color: Color(0xff8696BB))),
                  ],
                ),
                SizedBox(height: 16),
                Align(alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blue, backgroundColor: Colors.blue[50],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text('Detail'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}