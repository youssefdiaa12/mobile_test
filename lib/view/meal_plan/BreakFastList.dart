import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BreakfastList extends StatefulWidget {
  const BreakfastList({Key? key}) : super(key: key);

  @override
  State<BreakfastList> createState() => _BreakfastListState();
}

class _BreakfastListState extends State<BreakfastList> {
  // Define static breakfast items with online URLs for photos
  final List<Map<String, String>> breakfastItems = [
     {
      "image": "https://www.safefood.net/getmedia/b01b0826-14c8-42a3-baf3-20c21fb5bddd/Cheese_veg_omelette_6.aspx?ext=.jpg",
      "description": "Omelette with vegetables",
      "calories": "Calories: 250 kcal"
    },
    {
      "image":"https://goodinthesimple.com/wp-content/uploads/2022/06/cinnamon-maple-pancakes-28-1.jpg",
      "description": "Pancakes with maple syrup",
      "calories": "Calories: 300 kcal"
    },
    {
      "image": "https://joybauer.com/wp-content/uploads/2016/02/thumb_878_gallery_big.jpg",
      "description": "Greek yogurt with fruits",
      "calories": "Calories: 180 kcal"
    },
    {
      "image": "https://images.immediate.co.uk/production/volatile/sites/30/2022/12/Smoothie-bowl-16df176.jpg?resize=768,574",
      "description": "Smoothie bowl",
      "calories": "Calories: 200 kcal"
    },
    {
      "image": "https://cdn.jwplayer.com/v2/media/MNay5QBU/poster.jpg?width=720",
      "description": "Avocado toast",
      "calories": "Calories: 350 kcal"
    },
    {
      "image": "https://images.squarespace-cdn.com/content/v1/6508404030fe0519d54c5c79/974e4f72-7e58-40b6-b624-ef20cce71431/cereal-and-milk.png",
      "description": "Cereal with milk",
      "calories": "Calories: 150 kcal"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Breakfast List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: breakfastItems.map((breakfastItem) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CachedNetworkImage(
                  imageUrl: breakfastItem["image"]!,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    height: 200, // Adjust this value according to your design needs
                    margin: const EdgeInsets.all(10),
                  ),
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                  imageBuilder: (context, imageProvider) => Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 200, // Adjust this value according to your design needs
                  ),
                ),
                ListTile(
                  title: Text(
                    breakfastItem["description"]!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      breakfastItem["calories"]!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Add space between items
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
