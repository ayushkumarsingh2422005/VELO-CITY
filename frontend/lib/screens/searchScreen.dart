import 'package:flutter/material.dart';
import 'package:frontend/screens/searchResultScreen.dart';

void main() {
  runApp(SearchScreen());
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  final List<String> youMightLikeCategories = [
    'AI apps',
    'Brain teaser games',
    'Music recognition',
    'Photo editor',
  ];

  final List<String> exploreGamesCategories = [
    'Action',
    'Simulation',
    'Adventure',
    'Racing',
    'Role Playing',
    'Sports',
    'Strategy',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          onSubmitted: (text) {
            // Navigate to the new screen with typed text
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchResultScreen(query: text),
              ),
            );
          },
          decoration: InputDecoration(
            hintText: 'Search Apps & Games',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "You might like" section
            Text(
              'You might like',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GridView.builder(
              itemCount: youMightLikeCategories.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to the new screen with category title
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchResultScreen(
                          query: youMightLikeCategories[index],
                        ),
                      ),
                    );
                  },
                  child: CategoryTile(title: youMightLikeCategories[index]),
                );
              },
            ),
            SizedBox(height: 20),
            // "Explore games" section
            Text(
              'Explore games',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GridView.builder(
              itemCount: exploreGamesCategories.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to the new screen with category title
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchResultScreen(
                          query: exploreGamesCategories[index],
                        ),
                      ),
                    );
                  },
                  child: CategoryTile(title: exploreGamesCategories[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


class CategoryTile extends StatelessWidget {
  final String title;
  const CategoryTile({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 5),
          Icon(Icons.search, size: 20, color: Colors.blue),
        ],
      ),
    );
  }
}
