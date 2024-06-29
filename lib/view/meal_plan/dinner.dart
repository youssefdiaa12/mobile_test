import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Dinner extends StatefulWidget {
  const Dinner({Key? key}) : super(key: key);

  @override
  State<Dinner> createState() => _DinnerState();
}

class _DinnerState extends State<Dinner> {
  // Define static dinner items with online URLs for photos
  final List<Map<String, String>> dinnerItems = [
     {
      "image": "https://lh6.googleusercontent.com/0PRlw2K-x5IDCm7x15HISc7WzO02BJsrD8DLydcC0XHOxkfue1cYbfhLGYJdexWY9_FJFmwqZZRmf3Zk7CBC6cpBN3h6HzhrZqWCoCPet4SvXbedUt6z_JdYkWwtRIdeWfrXNq9dkyIDap6OHyhS7S6T-4sj0vOKHZPoFQ60ProKJGhJwWiH0ROy9hCBlQ",
      "description": "½ loaf of local bread + 1 serving of eggs with spinach + 1 tomato + a box of light yogurt.",
      "calories": "Calories: 320 kcal"
    },
    {
      "image":"https://lh4.googleusercontent.com/5GqRZ8RImlzs_8weV7RUcJfBlmBvUyUkZpjSahip8iv1N35yB15zO-8nMWz3tKvWywddR9ErtI8UVHY6kypDVhqs163CZAggqltMOWQ_NHeHVGBxP7k9dzuHB8BZ1PSmxoBoxVcq92FgxQhZhYwHgdY1g3SzeFcBKN5mDaXpw83Xlgym_wuMv4y8Uzd2dQ",
      "description": "One serving of pancakes + 1 teaspoon of honey + 5 strawberries + a cup of light yogurt.",
      "calories": "Calories: 300 kcal"
    },
    {
      "image": "https://lh4.googleusercontent.com/Q7KHTfwEvxPNcU6K3jZdKA-P3DvmUeftrC6bazgt62pj5TfpwFy_d6EfXoARTPJD9UdXgaX_5e8cImnx_-YpjuyJZ4z7V_4di5jIJ0UhoaPIbkQlQX76IPgPo_0uHNZWRJM-418Muq2UXULSIFJ02yQLNWf_7r3UcB_CKxLL1kpm9OqQetPNGDCS3b-uFw",
      "description": "One serving of tuna salad + 5 almonds + a cup of light yogurt.",
      "calories": "Calories: 300 kcal"
    },
    {
      "image": "https://lh4.googleusercontent.com/goApwe_nh0kyVyPQzfuX7N3RRpZfxDFlXEpK52n4F3xeB7QuEjbsRYItqZFIyLYdBm92b5YAJeWkexOaYfHI95KIu5Cf6JwMVXMN7rlQAbktAPwY9GmaeovoQpr9nJPa_1AGmCxwxOvJuZ8onXtiO4yxg-Z48Xq-zJAeWmesnaA2wXRD69kbU2R6WXncdQ",
      "description": "1 serving of sweet potatoes with chicken sausage + 1 apple + 1 cup of light yogurt.",
      "calories": "Calories: 300 kcal"
    },
    {
      "image": "https://lh4.googleusercontent.com/rMgM_j5xAXKJJzeP8c-0cuUAh-jV5oAMFfrI_7FycT6amtKlbPHqnZlhpYhhb_v8N0GssFL1dX-vY6Yd4_GLfqiJQeKMkSJGMBdgpWzKxkql6hqj7EEhtVssRkS_hLHzwY4r4nwvLTAN2VlYg3GNmJOv9U6m-MIFXcmM7_-Vj4yGxeEVRYBOY2Xl_E0CWQ",
      "description": "¼ loaf of local bread + 1 boiled egg + 1 slice of smoked turkey + 3 olives + lettuce + 1 cup of light yogurt.t",
      "calories": "Calories: 350 kcal"
    },
    {
      "image": "https://lh4.googleusercontent.com/hkEoDNah0OcspQg7kmsb0iuMvh119DfwV8g6moR5_Jz9STxKjYZdd0jBSRkv16G9kdXx38qbpJHWytX7FLrdLkJJdPiElrSoc2gFBqbegnx5WhbRUrQQHO2OVGY4p9b-xLNbCfarHWsTr2KGVhNt8163iydo9Er80Ygcud53rgJCm7IHJPMbvHmJA0arHg",
      "description": "2 slices of brown toast + 2 tablespoons of peanut butter + 1 banana + 1 cup of light yogurt.",
      "calories": "Calories: 300 kcal"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Dinner List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: dinnerItems.map((dinnerItem) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CachedNetworkImage(
                  imageUrl: dinnerItem["image"]!,
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
                    dinnerItem["description"]!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      dinnerItem["calories"]!,
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
