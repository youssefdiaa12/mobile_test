import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewsScreen(),
    );
  }
}

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bodybuilding News'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            NewsCard(
              title: 'New Bodybuilding Champion Crowned',
              imageUrl:
                  'https://image-cdn.essentiallysports.com/wp-content/uploads/maxresdefault-383-69-740x710.jpg',
              description:
                  'John Doe won the Mr. Universe title in a fierce competition held in Miami yesterday.',
            ),
            NewsCard(
              title: 'Tips for Building Muscle Mass',
              imageUrl:
                  'https://image-cdn.essentiallysports.com/wp-content/uploads/8d798c_65f4bcea168d46dca2d4de038a43fd14.jpg?width=600',
              description:
                  'Experts share their advice on how to bulk up and gain muscle effectively.',
            ),
            NewsCard(
              title: 'Top Supplements for Bodybuilders',
              imageUrl:
                  'https://image-cdn.essentiallysports.com/wp-content/uploads/WhatsApp-Image-2023-01-14-at-8.34.58-AM-800x999.jpeg',
              description:
                  'Discover the essential supplements every bodybuilder should consider adding to their regimen.',
            ),
          ],
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;

  const NewsCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
