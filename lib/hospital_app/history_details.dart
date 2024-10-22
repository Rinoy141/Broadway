
import 'package:broadway/hospital_app/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HistoryDetailPage extends StatelessWidget {
  final int appointmentIndex;

  HistoryDetailPage({required this.appointmentIndex});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => AppointmentsProvider(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('History Detail'),
        ),
        body: Consumer<AppointmentsProvider>(
          builder: (context, appointmentsProvider, child) {
            final appointment = appointmentsProvider.getAppointment(appointmentIndex);
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(appointment.doctorName[0]),
                    ),
                    title: Text(appointment.doctorName),
                    subtitle: Text(appointment.specialization),
                  ),
                  SizedBox(height: 20),
                  _buildDetailRow('Patient Name', appointment.patientName),
                  _buildDetailRow('Age', appointment.age.toString()),
                  _buildDetailRow('Gender', appointment.gender),
                  _buildDetailRow('Mobile number', appointment.mobileNumber),
                  _buildDetailRow('Address', appointment.address),
                  _buildDetailRow('Token Number Received', appointment.tokenNumber.toString()),
                  _buildDetailRow('Date', appointment.date),
                  _buildDetailRow('Time', appointment.time),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}