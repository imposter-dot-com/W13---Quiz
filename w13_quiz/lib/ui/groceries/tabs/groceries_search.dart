import 'package:flutter/material.dart';
import 'package:w13_quiz/data/mock_grocery_repository.dart';

class GrocerySearch extends StatefulWidget {
  const GrocerySearch({super.key}); 

  @override
  State<GrocerySearch> createState() => _GrocerySearchState();
}

class _GrocerySearchState extends State<GrocerySearch> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredGroceries = dummyGroceryItems.where((grocery) {
      return grocery.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search groceries..',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              filled: true,
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          const SizedBox(height: 16),

          Expanded(
            child: filteredGroceries.isEmpty
                ? const Center(
                    child: Text(
                      'No items found',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredGroceries.length,
                    itemBuilder: (context, index) {
                      final grocery = filteredGroceries[index];
                      return ListTile(
                        leading: Container(
                          width: 15,
                          height: 15,
                          color: grocery.category.color,
                        ),
                        title: Text(grocery.name),
                        trailing: Text(grocery.quantity.toString()),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
