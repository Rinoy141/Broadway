
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
  double _minPrice = 0;
  double _maxPrice = 1000;
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
            if (appBarState.isFilterOpen) _buildFilterSection(context),
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
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                  ),
                ),

              ],
            ),
            GestureDetector(
              onTap: () => context.read<AppBarState>().toggleFilter(),
              child: const Row(
                children: [
                  Icon(Icons.filter_list, size: 16),
                  SizedBox(width: 4),
                  Text('Filter'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          _buildFilterTabs(context),
          const SizedBox(height: 16),
          Consumer<AppBarState>(
            builder: (context, appBarState, child) {
              switch (appBarState.selectedTab) {
                case 'Category':
                  return _buildCategoryIcons();
                case 'Sort by':
                  return _buildSortByOptions(context);
                case 'Price':
                  return _buildPriceRange();
                default:
                  return const SizedBox.shrink();
              }
            },
          ),

        ],
      ),
    );
  }

  Widget _buildFilterTabs(BuildContext context) {
    return Consumer<AppBarState>(
      builder: (context, appBarState, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['Category', 'Sort by', 'Price'].map((tab) {
            return GestureDetector(
              onTap: () => appBarState.setSelectedTab(tab),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: appBarState.selectedTab == tab
                          ? Colors.blue
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    color: appBarState.selectedTab == tab
                        ? Color(0xff004CFF)
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildCategoryIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildCategoryIcon('🥪', 'Sandwich'),
        _buildCategoryIcon('🍕', 'Pizza'),
        _buildCategoryIcon('🍔', 'Burgers'),
      ],
    );
  }

  Widget _buildCategoryIcon(String emoji, String label) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 32),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label),

      ],
    );
  }

  Widget _buildSortByOptions(BuildContext context) {
    return Consumer<AppBarState>(
      builder: (context, appBarState, child) {
        return Column(
          children: [
            'Recomended',
            'Fastest delivery ',
            'Most popular',

          ].map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: appBarState.sortBy,
              onChanged: (value) {
                if (value != null) {
                  appBarState.setSortBy(value);
                }
              },
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildPriceRange() {
    // Implement price range slider or options here
     return Container(
       child: Column(
         children: [Padding(
           padding: const EdgeInsets.symmetric(horizontal: 25,),
           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text('\$${_minPrice.round()} ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
               Text(' \$${_maxPrice.round()}',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18)),
             ],
           ),
         ),
           RangeSlider(activeColor: Color(0xff004CFF),
            values: RangeValues(_minPrice, _maxPrice),
            min: 0,
            max: 1000,
            divisions: 100,

            onChanged: (values) {
              setState(() {
                _minPrice = values.start;
                _maxPrice = values.end;
              });
            },
               ),
           const SizedBox(height: 16),
           ElevatedButton(
             onPressed: () {},
             style: ElevatedButton.styleFrom(
               backgroundColor: Color(0xff004CFF),
               minimumSize: const Size(double.infinity, 48),
             ),
             child: const Text(
               'Apply',
               style: TextStyle(color: Colors.white),
             ),
           ),
         ],
       ),
     );
  }
}


