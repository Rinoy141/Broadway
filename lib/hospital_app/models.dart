import 'package:flutter/material.dart';

class Doctor {
  final String name;
  final String imagePath;
  final String ?specialization;
  final String description;
  final double rating;
  final double? payment;
  final List<WorkingHours>? workingHours;

  Doctor({
    required this.name,
    required this.imagePath,
    this.specialization,
    required this.description,
    required this.rating,
     this.payment,
     this.workingHours,
  });
}

class WorkingHours {
  final int dayOfWeek; // 1 = Monday, 7 = Sunday
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  WorkingHours({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });
}

final List<Doctor> doctors = [
  Doctor(
    name: 'Dr. Harry',
    imagePath: 'Assets/image 6.png',
    specialization: 'Cardiologist',
    description:
    'Passionate about innovation and continuous improvement, Dr. Harry is dedicated to offering state-of-the-art solutions for optimal heart health outcomes.',
    rating: 5.0,
    payment: 150.0,
    workingHours: [
      WorkingHours(dayOfWeek: 1, startTime: const TimeOfDay(hour: 9, minute: 0), endTime: const TimeOfDay(hour: 17, minute: 0)),
      WorkingHours(dayOfWeek: 3, startTime: const TimeOfDay(hour: 9, minute: 0), endTime: const TimeOfDay(hour: 17, minute: 0)),
      WorkingHours(dayOfWeek: 5, startTime: const TimeOfDay(hour: 9, minute: 0), endTime: const TimeOfDay(hour: 17, minute: 0)),
    ],
  ),
  Doctor(
    name: 'Dr. gg',
    imagePath: 'Assets/image 7.png',
    specialization: 'Pediatrician',
    description:
    'With a gentle approach and a wealth of experience, Dr. Panda ensures the best care for your children, focusing on their growth and well-being.',
    rating: 4.8,
    payment: 120.0,
    workingHours: [
      WorkingHours(dayOfWeek: 2, startTime: const TimeOfDay(hour: 8, minute: 30), endTime: const TimeOfDay(hour: 16, minute: 30)),
      WorkingHours(dayOfWeek: 4, startTime: const TimeOfDay(hour: 8, minute: 30), endTime: const TimeOfDay(hour: 16, minute: 30)),
      WorkingHours(dayOfWeek: 6, startTime: const TimeOfDay(hour: 10, minute: 0), endTime: const TimeOfDay(hour: 14, minute: 0)),
    ],
  ),
  Doctor(
    name: 'Dr. Emma',
    imagePath: 'Assets/image 5.png',
    specialization: 'Dermatologist',
    description:
    'Dr. Emma combines cutting-edge techniques with a holistic approach to skincare, helping patients achieve healthy, radiant skin.',
    rating: 4.9,
    payment: 180.0,
    workingHours: [
      WorkingHours(dayOfWeek: 1, startTime: const TimeOfDay(hour: 10, minute: 0), endTime: const TimeOfDay(hour: 18, minute: 0)),
      WorkingHours(dayOfWeek: 2, startTime: const TimeOfDay(hour: 10, minute: 0), endTime: const TimeOfDay(hour: 18, minute: 0)),
      WorkingHours(dayOfWeek: 4, startTime: const TimeOfDay(hour: 10, minute: 0), endTime: const TimeOfDay(hour: 18, minute: 0)),
      WorkingHours(dayOfWeek: 5, startTime: const TimeOfDay(hour: 10, minute: 0), endTime: const TimeOfDay(hour: 18, minute: 0)),
    ],
  ),
];

class Category {
  final String name;
  final String description;
  final String image;
  bool isFavorite;

  Category({
    required this.name,
    required this.description,
    required this.image,
    this.isFavorite = false,
  });
}
final List<Category> category = [
  Category(
    name: 'Dr.Harry',
    description: 'Passionate about innovation and continuous improvement, Dr. Harry is dedicated to offering state-of-the-art solutions for optimal health outcomes.',
    image: 'Assets/image 6.png',
  ),
  Category(
    name: 'Dental Care',
    description: 'Committed to lifelong learning and excellence in medicine, Dr. Jack is dedicated to enhancing the health and well-being of each patient.',
    image: 'Assets/image 6.png',
  ),
  Category(
    name: 'Smile Clinc',
    description: 'Actively involved in local health initiatives, Dr. Leo is committed to making a positive impact on the well-being of patients and the community.',
    image: 'Assets/image 7.png',
  ),
  Category(
    name: 'Dr.George',
    description: 'Passionate about progress and excellence, Dr. George is dedicated to pushing the boundaries of traditional medicine',
    image: 'Assets/image 7.png',
  ),
];

class Hospital {
  final String name;
  final String imagePath;
  final String description;
  final double rating;
  bool isFavorite;

  Hospital({
    required this.name,
    required this.imagePath,
    required this.description,
    required this.rating,
    this.isFavorite = false,
  });
}
final List<Hospital> hospital = [
  Hospital(
    name: 'Amrita Hospital',
    imagePath: 'Assets/image 6.png',
    description:
    'Providing world-class healthcare, Amrita Hospital is known for its advanced medical technology and a compassionate team of professionals.',
    rating: 5.0,
  ),
  Hospital(
    name: 'City General Hospital',
    imagePath: 'Assets/image 7.png',
    description:
    'City General Hospital offers comprehensive medical services with a focus on patient-centered care and innovative treatments.',
    rating: 4.8,
  ),
  // Add more hospitals as needed
];



