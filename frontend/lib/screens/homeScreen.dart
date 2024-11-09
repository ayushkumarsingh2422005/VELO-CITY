import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search for app categories...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),

            // login card
            SizedBox(
              width: double.infinity,
              // margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 8),

                      // Subtitle
                      Text(
                        "Login to continue to your account",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 24),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {
                            // Handle login logic here
                          },
                          child: Text(
                            "Login",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Explore Categories section
            Text(
              'Explore Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                CategoryCard('Restaurants', 'assets/images/icons/google.png'),
                CategoryCard('Retail Shops', 'assets/images/icons/google.png'),
                CategoryCard('Student Tools', 'assets/images/icons/google.png'),
                CategoryCard('Teacher Tools', 'assets/images/icons/google.png'),
              ],
            ),
            SizedBox(height: 20),

            // Consult section
            Text(
              'Consult',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ConsultCard('Smart Inventory', '4.5',
                      'assets/images/icons/google.png'),
                  ConsultCard(
                      'EduTools', '4.7', 'assets/images/icons/google.png'),
                  ConsultCard(
                      'Shop Manager', '4.3', 'assets/images/icons/google.png'),
                ],
              ),
            ),
            SizedBox(height: 20),

            // What our customers say
            Text(
              'What our Users say',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  PeopleCard('Smart Inventory', '4.5',
                      'assets/images/icons/google.png'),
                  PeopleCard(
                      'EduTools', '4.7', 'assets/images/icons/google.png'),
                  PeopleCard(
                      'Shop Manager', '4.3', 'assets/images/icons/google.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Category card widget
class CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;

  CategoryCard(this.title, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black54,
          ),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

// Consult card widget
class ConsultCard extends StatelessWidget {
  final String title;
  final String rating;
  final String imagePath;

  const ConsultCard(this.title, this.rating, this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 16),
              SizedBox(width: 4),
              Text(rating),
            ],
          ),
        ],
      ),
    );
  }
}

class PeopleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  PeopleCard(this.title, this.subtitle, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        width: 150,
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 16),
                SizedBox(width: 4),
                Text(subtitle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}