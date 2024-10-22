
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'food_details_page.dart';
import 'food_provider.dart';
class CustomAppBarContent extends StatelessWidget {
  const CustomAppBarContent({super.key});

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
                  _buildLocationRow(context),
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
            builder: (context) => ChangeNotifierProvider(
              create: (context) => SearchModel(RestaurantProvider()),
              child: const SearchPage(),
            ),
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

  Widget _buildLocationRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Icon(Icons.location_on, size: 16, color: Colors.blue),
            SizedBox(width: 4),
            Text('Delivery to', style: TextStyle(color: Colors.blue)),
            SizedBox(width: 4),
            Text('thrissur',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
            Icon(Icons.arrow_drop_down, size: 16, color: Colors.blue),
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
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff004CFF),
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text(
              'Complete',
              style: TextStyle(color: Colors.white),
            ),
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
    return const Text('Price range ');
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          autofocus: true,
          onChanged: (value) {
            Provider.of<SearchModel>(context, listen: false)
                .filterSearchResults(value);
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: Consumer<SearchModel>(
                builder: (context, searchModel, child) {
                  return ListView.builder(
                    itemCount: searchModel.filteredRestaurants.length,
                    itemBuilder: (context, index) {
                      final item = searchModel.filteredRestaurants[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsPage(restaurantIndex: index),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: SizedBox(
                            width: 50,
                            height: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                item.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(item.name),
                          subtitle: Text('${item.rating} • ${item.location}'),
                          trailing: const Icon(Icons.star_border),
                        ),
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
