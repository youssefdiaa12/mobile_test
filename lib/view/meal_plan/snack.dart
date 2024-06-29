import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Snack extends StatefulWidget {
  const Snack({Key? key}) : super(key: key);

  @override
  State<Snack> createState() => _SnackState();
}

class _SnackState extends State<Snack> {
  // Define static breakfast items with online URLs for photos
  final List<Map<String, String>> snackItems = [
    {
      "image": "https://static.wixstatic.com/media/8137ac_0ae0b5baa40544b2b10009098e624a29~mv2.jpg/v1/fill/w_480,h_600,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/8137ac_0ae0b5baa40544b2b10009098e624a29~mv2.jpg",
      "description": "Rice cake",
      "calories": "Calories: 35 kcal for 9 grams"
    },
    {
      "image":"https://cfdefaultstorage.blob.core.windows.net/cfimages/data/naked_popcorn_top_large_05.jpg",
      "description": "Popcorn",
      "calories": "Calories: 374 kcal for 100 grams"
    },
    {
      "image": "https://www.inspiredtaste.net/wp-content/uploads/2022/08/Peanut-Butter-Granola-Bars-3-1200.jpg",
      "description": "Granola bar",
      "calories": "Calories: 100–300 kcal"
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgW8g43KGSujJWs_DZhet3MSViZhVXzpN_nA&usqp=CAU",
      "description": "Protein bar",
      "calories": "Calories: 415 kcal"
    },
    {
      "image": "https://dealzdxb.com/wp-content/uploads/2022/05/image-25.jpg",
      "description": "Flamengo",
      "calories": "Calories: 536 kcal"
    },
    {
      "image": "https://cdnprod.mafretailproxy.com/sys-master-root/h45/hfc/47467586191390/1700Wx1700H_487642_main.jpg",
      "description": "Oat biscuits",
      "calories": "Calories: 454 kcal"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Snack List'),
      ),
      body: SingleChildScrollView(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth < 600 ? 1 : 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: screenWidth < 600 ? 1 : 0.75,
          ),
          itemCount: snackItems.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final snackItem = snackItems[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: snackItem["image"]!,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    width: double.infinity,
                    height: screenHeight * 0.3,
                    margin: const EdgeInsets.all(10),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageBuilder: (context, imageProvider) => Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: double.infinity,
                    height: screenHeight * 0.3,
                  ),
                ),
                ListTile(
                  title: Text(
                    snackItem["description"]!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      snackItem["calories"]!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
