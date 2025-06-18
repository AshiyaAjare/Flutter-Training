import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Card'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ProfileCard(
          name: 'Fred',
          imageUrl: 'https://picsum.photos/150/150',
          description: 'Flutter developer | Passionate about coding | continuous learner',
          isFollowing: isFollowing,
          onFollowPressed: () {
            setState(() {
              isFollowing = !isFollowing;
            });
          },
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;
  final bool isFollowing;
  final VoidCallback onFollowPressed;

  const ProfileCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.isFollowing,
    required this.onFollowPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile Image
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: Colors.grey[300],
              ),
              
              SizedBox(height: 16),
              
              // Name
              Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              
              SizedBox(height: 12),
              
              // Description
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
              
              SizedBox(height: 20),
              
              // Follow Button
              ElevatedButton(
                onPressed: onFollowPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFollowing ? Colors.grey : Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  isFollowing ? 'Following' : 'Follow',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}