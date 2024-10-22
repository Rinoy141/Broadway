
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'food_details_page.dart';
import 'food_provider.dart';



class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          onChanged: (value) {
            Provider.of<SearchModel>(context, listen: false)
                .filterSearchResults(value);
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Color(0xff858585),
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
                              builder: (context) => DetailsPage(restaurantIndex: index,), // Pass the restaurant here
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
                          subtitle:
                              Text('${item.rating} • ${item.location}'),
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
