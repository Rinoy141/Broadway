
import 'package:broadway/hospital_app/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class BookingScreen2 extends StatelessWidget {
  const BookingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppointmentConfirmationProvider(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Appointment', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004CFF))),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
          child: Consumer<AppointmentConfirmationProvider>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Time Slot Booked', DateFormat('hh:mm a').format(provider.appointmentDate)),
                  const SizedBox(height: 30),
                  _buildDetailRow('Token Number Recieved', provider.tokenNumberReceived),
                  const SizedBox(height: 30),
                  _buildDetailRow('Token Number Inside', provider.tokenNumberInside),
                  const SizedBox(height: 35),
                  _buildAttentionCard(provider),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFE6EDFF),
            borderRadius: BorderRadius.circular(8),border: Border.all(color:Color(0xFF004CFF) )
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF004CFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttentionCard(AppointmentConfirmationProvider provider) {
    return Container(alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: const Color(0xffEBF1FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.error_outline,
              color: Color(0xFF004CFF),
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Attention !',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your have an appointment',
            style: TextStyle(fontSize: 16,color: Color(0xff6F7977)),
          ),
          const SizedBox(height: 16),
          Text(
            'You booked an appointment on\n${DateFormat('MMMM d').format(provider.appointmentDate)}\nat ${DateFormat('hh:mm a').format(provider.appointmentDate)}.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16,color: Color(0xff6F7977)),
          ),
          const SizedBox(height: 8),
          Text(
            'It is already ${DateFormat('hh:mm').format(DateTime.now())} !\nand token number ${provider.tokenNumberInside} is inside.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16,color: Color(0xff6F7977)),
          ),
        ],
      ),
    );
  }
}