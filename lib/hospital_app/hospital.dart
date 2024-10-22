import 'dart:math' as math;






import 'package:broadway/hospital_app/provider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import 'all_hospitals.dart';
import 'appointment.dart';
import 'categories_show_all.dart';
import 'models.dart';

class MedicalApp extends StatelessWidget {
  const MedicalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( create: (context) => HospitalProvider(),
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackgroundDesign(),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    _buildSearchBar(),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: _buildCarousel(context),
                    ),
                    _buildCategories(context),
                    _buildNearbyDoctors(context),
                    _buildAllHospitals(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundDesign() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 350,
            height: 475,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffD9E4FF), // Very light blue with opacity
            ),
          ),
        ),
        Positioned(
          top: -20,
          right: -10,
    child: Transform.rotate(
    angle:   1* (math.pi / 180), // Rotate by 45 degrees (in radians)
    child: Image.asset('Assets/bubble 2.png'),
        ),
        )],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('Assets/image 4.png'),
            radius: 25,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Hi, Welcome,', style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text('John', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Opacity(opacity: 0.2,
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey, // Light blue background
            hintText: 'Search a Doctor',
            hintStyle: const TextStyle(color: Colors.black),
            prefixIcon: const Icon(Icons.search, color: Colors.black),
            suffixIcon: const Icon(Icons.mic, color: Colors.black),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.24,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Image.asset(
                    'Assets/image 5.png',
                    fit: BoxFit.fitWidth,
                  )),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = ['Dental', 'Therapist', 'Surgeon'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Categories',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DentalCategoriesPage(),));
                  // Navigate to categories page
                },
                child: const Text('See all', style: TextStyle(color: Colors.grey)),
              )
            ],
          ),
        ),
        SizedBox(
          height: 75,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 28),
                decoration: BoxDecoration(
                  color: const Color(0xff85A8FB),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                    child: Text(
                      categories[index],
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    )),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNearbyDoctors(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Text('Nearby You',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HospitalCategoriesPage(),));
                  // Navigate to all doctors page
                },
                child: const Text('See all', style: TextStyle(color: Colors.grey)),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.26,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              Doctor doctor = doctors[index];
              return Container(
                width: 400,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(217, 217, 217, 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(doctor.name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  doctor.imagePath,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              MaterialButton(
                                color: const Color(0xff004CFF),
                                shape: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () { Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => AppointmentPage(doctor: doctor),
                                  ),
                                );

                                },
                                child: const Text('Book',
                                    style: TextStyle(color: Colors.white)),
                              )
                            ],
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Icon(Icons.favorite_border, color: Colors.blue),
                                const SizedBox(height: 8),
                                Text(
                                  doctor.description,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.orangeAccent, size: 20),
                                    Text(' ${doctor.rating}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAllHospitals(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('All Hospitals',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Consumer<HospitalProvider>(
            builder: (context, hospitalProvider, child) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hospitalProvider.hospitals.length,
                itemBuilder: (context, index) {
                  Hospital hospital = hospitalProvider.hospitals[index];
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(217, 217, 217, 0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(hospital.name,
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  hospital.imagePath,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              MaterialButton(
                                color: const Color(0xff004CFF),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  // Implement booking functionality
                                },
                                child: const Text(
                                  'Book',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    hospital.isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: hospital.isFavorite ? Colors.red : null,
                                  ),
                                  onPressed: () => hospitalProvider.toggleFavorite(index),
                                ),
                                Text(
                                  hospital.description,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.orangeAccent, size: 20),
                                    Text(' ${hospital.rating}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}







