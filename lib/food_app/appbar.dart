import 'package:broadway/food_app/search_br.dart';
import 'package:broadway/providerss/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'food_provider.dart';

class CustomAppBarContent extends StatefulWidget {
  const CustomAppBarContent({super.key});

  @override
  State<CustomAppBarContent> createState() => _CustomAppBarContentState();
}

class _CustomAppBarContentState extends State<CustomAppBarContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppBarState>(
      builder: (context, appBarState, child) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Colors.white),
              child: Column(
                children: [
                  _buildSearchBar(context),
                  const SizedBox(height: 16),
                  buildLocationRow(context),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPage(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const TextField(
          enabled: false,
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget buildLocationRow(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        if (provider.userProfile == null) {
          provider.fetchUserProfile();
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.blue),
                const SizedBox(width: 4),
                const Text('Delivery to', style: TextStyle(color: Colors.blue)),
                const SizedBox(width: 4),
                Text(
                  provider.userProfile != null
                      ? '${provider.userProfile!.place}'
                      : 'Loading...',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
