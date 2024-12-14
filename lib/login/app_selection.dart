
import 'package:broadway/food_app/main_page.dart';
import 'package:flutter/material.dart';

class AppSelection extends StatelessWidget {
   final String userId;
  const AppSelection({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'What are\nyou seeking?',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.85,
                children: [
                  _buildCategoryItem(
                    'Food',
                    Icons.restaurant,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage(),
                          ));

                    },context
                  ),
                  _buildCategoryItem(
                      'Jobs', Icons.work, () => print('Jobs tapped'),context),
                  _buildCategoryItem('Doctors', Icons.local_hospital,
                      () => print('Doctors tapped'),context),
                  _buildCategoryItem('Buy & Sell', Icons.shopping_bag,
                      () => print('Buy & Sell tapped'),context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
      String label, IconData icon, VoidCallback onPressed,BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff004CFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xffC7D6FB),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: const Color(0xff004CFF), size: 80),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
