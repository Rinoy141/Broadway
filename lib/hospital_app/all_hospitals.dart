
import 'package:broadway/hospital_app/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';

class HospitalCategoriesPage extends StatelessWidget {
  const HospitalCategoriesPage({ super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => HospitalProvider(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'All Hospital',
            style: TextStyle(color: Color(0xff004BFE), fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(217, 217, 217, 0.3),
                  hintText: 'Search a Hospital',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: const Icon(Icons.mic, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<HospitalProvider>(
                builder: (context, hospitalProvider, child) {
                  return ListView.builder(
                    itemCount: hospitalProvider.hospitals.length,
                    itemBuilder: (context, index) {
                      return HospitalCard(
                        hospital: hospitalProvider.hospitals[index],
                        onFavoriteToggle: () => hospitalProvider.toggleFavorite(index),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HospitalCard extends StatelessWidget {
  final Hospital hospital;
  final VoidCallback onFavoriteToggle;

  const HospitalCard({
    Key? key,
    required this.hospital,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        hospital.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          hospital.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: hospital.isFavorite ? Colors.red : Colors.blue,
                        ),
                        onPressed: onFavoriteToggle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hospital.description,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      MaterialButton(
                        color: const Color(0xff004CFF),
                        shape: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {},
                        child: const Text('Book',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const Spacer(),
                      const Icon(Icons.star, color: Color(0xffF89603)),
                      const SizedBox(width: 15),
                      Text(
                        '${hospital.rating}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 15)
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(hospital.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}