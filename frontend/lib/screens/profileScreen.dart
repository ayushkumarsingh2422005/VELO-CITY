import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture and Name
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/icons/google.png'),
              ),
              SizedBox(height: 10),
              Text(
                'John Doe',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                '@johndoe',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text('+ Follow'),
                  ),
                  SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('Message'),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Personal Information Section
              buildSectionTitle('Personal Information'),
              buildInfoRow(Icons.person, 'Name: John Doe', 'Edit'),
              buildInfoRow(Icons.email, 'Email: ...', 'Edit'),
              buildInfoRow(Icons.phone, 'Phone Number: +1 234 567...', 'Edit'),
              SizedBox(height: 20),

              // My Purchases Section
              buildSectionTitle('My Purchases'),
              buildPurchaseTile(
                imageUrl: 'assets/images/icons/google.png',
                title: 'Spotify',
                status: 'Downloaded',
              ),
              buildPurchaseTile(
                imageUrl: 'assets/images/icons/google.png',
                title: 'Adobe Photoshop',
                status: 'In Customization',
              ),
              SizedBox(height: 20),

              // Consultations & Customizations Section
              buildSectionTitle('Consultations & Customizations'),
              buildConsultationTile(
                title: 'Consultation with Developer A',
                progress: 50,
                date: 'Jan 1 - Jan 15',
              ),
              buildConsultationTile(
                title: 'Consultation with Developer B',
                progress: 100,
                date: 'Feb 1 - Feb 10',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widgets
  Widget buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String info, String buttonText) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey[600]),
        title: Text(info),
        trailing: TextButton(
          onPressed: () {},
          child: Text(buttonText),
        ),
      ),
    );
  }

  Widget buildPurchaseTile({required String imageUrl, required String title, required String status}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: SizedBox(
          width: 100,
          // height: 100,
          child: Image.asset(
            imageUrl,
            fit: BoxFit.fitWidth,
          ),
        ),
        title: Text(title),
        subtitle: Column(children: [
          Align(alignment: Alignment.centerLeft,child: Text(status),),
          SizedBox(height: 10,),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('Download Again'),
            ),
          )
        ]),
        // trailing: ,
      ),
    );
  }

  Widget buildConsultationTile({required String title, required int progress, required String date}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/icons/google.png'),
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            LinearProgressIndicator(value: progress / 100, minHeight: 5),
            SizedBox(height: 5),
            Text(date),
          ],
        ),
      ),
    );
  }
}
