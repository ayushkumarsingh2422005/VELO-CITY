import 'package:flutter/material.dart';


class SearchResultScreen extends StatefulWidget {
  final String query;

  SearchResultScreen({required this.query});

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late TextEditingController _searchController;

  final List<Map<String, String>> apps = [
    {
      'icon': 'assets/images/icons/google.png',
      'name': 'Freelancer: Hire & Find Jobs',
      'company': 'Freelancer.com',
      'rating': '3.7',
      'size': '33 MB',
      'downloads': '1Cr+'
    },
    {
      'icon': 'assets/images/icons/google.png',
      'name': 'Upwork for Freelancers',
      'company': 'Upwork Global Inc.',
      'rating': '4.1',
      'size': '18 MB',
      'downloads': '1Cr+'
    },
    {
      'icon': 'assets/images/icons/google.png',
      'name': 'Fiverr - Freelance Service',
      'company': 'Fiverr',
      'rating': '4.0',
      'size': '24 MB',
      'downloads': '1Cr+'
    },
    // Add more apps similarly
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onSubmitted: (newQuery) {
                setState(() {
                  // Perform search or update based on newQuery
                  // Here, you could call a function to filter the app results based on newQuery
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: apps.length,
              itemBuilder: (context, index) {
                final app = apps[index];
                return AppTile(
                  iconUrl: app['icon']!,
                  name: app['name']!,
                  company: app['company']!,
                  rating: app['rating']!,
                  size: app['size']!,
                  downloads: app['downloads']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AppTile extends StatelessWidget {
  final String iconUrl;
  final String name;
  final String company;
  final String rating;
  final String size;
  final String downloads;

  const AppTile({
    Key? key,
    required this.iconUrl,
    required this.name,
    required this.company,
    required this.rating,
    required this.size,
    required this.downloads,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            iconUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis, // Prevents text overflow
                ),
                SizedBox(height: 4),
                Text(
                  company,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.orange),
                    SizedBox(width: 2),
                    Text(
                      rating,
                      style: TextStyle(color: Colors.grey[800], fontSize: 12),
                    ),
                    SizedBox(width: 10),
                    Text(
                      size,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        downloads,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.download, color: Colors.grey),
            onPressed: () {
              // Action for download button
            },
          ),
        ],
      ),
    );
  }
}
