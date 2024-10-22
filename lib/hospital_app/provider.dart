import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models.dart';
import 'models/history model.dart';



// ChangeNotifier for managing the list of category providers
class CategoryProvider extends ChangeNotifier {
  List<Category> get providers => category;

  void toggleFavorite(int index) {
    category[index].isFavorite = !category[index].isFavorite;
    notifyListeners();
  }
}





class AppointmentProvider extends ChangeNotifier {
  final Doctor doctor;
  List<String> availableTimeSlots = [];
  List<DateTime> availableDates = [];
  String? selectedTimeSlot;
  DateTime? selectedDate;

  AppointmentProvider(this.doctor) {
    _initializeAvailability();
  }

  void _initializeAvailability() {
    // Generate available time slots based on doctor's working hours
    availableTimeSlots = _generateUniqueTimeSlots();

    // Generate available dates for the next 7 days
    availableDates = List.generate(7, (index) {
      return DateTime.now().add(Duration(days: index));
    });

    notifyListeners();
  }

  List<String> _generateUniqueTimeSlots() {
    Set<String> uniqueSlots = {};
    for (var workingHour in doctor.workingHours ?? []) {
      DateTime startTime = DateTime(2022, 1, 1, workingHour.startTime.hour, workingHour.startTime.minute);
      DateTime endTime = DateTime(2022, 1, 1, workingHour.endTime.hour, workingHour.endTime.minute);

      while (startTime.isBefore(endTime)) {
        uniqueSlots.add('${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}');
        startTime = startTime.add(const Duration(minutes: 30));
      }
    }
    return uniqueSlots.toList()..sort();
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

  void selectTimeSlot(String timeSlot) {
    selectedTimeSlot = timeSlot;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  bool get canBookAppointment => selectedTimeSlot != null && selectedDate != null;
}

class AppointmentConfirmationProvider extends ChangeNotifier {
  DateTime _appointmentDate = DateTime(2024, 5, 18, 11, 0);
  String _tokenNumberReceived = '24';
  String _tokenNumberInside = '07';
  int _remindBefore = 25;
  int _notifyAt = 16;

  DateTime get appointmentDate => _appointmentDate;
  String get tokenNumberReceived => _tokenNumberReceived;
  String get tokenNumberInside => _tokenNumberInside;
  int get remindBefore => _remindBefore;
  int get notifyAt => _notifyAt;

  void setRemindBefore(int minutes) {
    _remindBefore = minutes;
    notifyListeners();
  }

  void setNotifyAt(int tokenNumber) {
    _notifyAt = tokenNumber;
    notifyListeners();
  }
}






class HospitalProvider extends ChangeNotifier {


  List<Hospital> get hospitals => hospital;

  void toggleFavorite(int index) {
    hospital[index].isFavorite = !hospital[index].isFavorite;
    notifyListeners();
  }
}



class AppointmentsProvider with ChangeNotifier {
  List<Appointment> _appointments = [
    Appointment(
      doctorName: 'Dr. Joseph Brostito',
      specialization: 'Dental Specialist',
      date: 'Sunday, 12 June',
      time: '11:00 - 12:00 AM',
      patientName: 'Joy',
      age: 55,
      gender: 'Male',
      mobileNumber: '123456789',
      address: 'xyz uk',
      tokenNumber: 24,
    ),

  ];

  List<Appointment> get appointments => _appointments;

  Appointment getAppointment(int index) => _appointments[index];
}


