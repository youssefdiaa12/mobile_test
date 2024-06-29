import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Lunch extends StatefulWidget {
  const Lunch({Key? key}) : super(key: key);

  @override
  State<Lunch> createState() => _LunchState();
}

class _LunchState extends State<Lunch> {
  // Define static lunch items with online URLs for photos
  final List<Map<String, String>> lunchItems = [
    {
      "image": "https://www.kholoudabouzid.com/wp-content/uploads/2022/09/img_7221-810x908.jpg",
      "description": "Chicken kofta, 6 tablespoons rice and colored pepper",
      "calories": "Calories: 600 kcal"
    },
    {
      "image":"https://lh3.googleusercontent.com/g_TAs5kJKEdhzmzfZQOTwfK_tShIAY37DURp3mBrfOIRIR_mh9V4LBKnPUWJlCYV4AcQeQz6ACwia1OYJQZYrM3wNixmcH4nj_UqooYdQ7sOm8sWMLRxMJwBDta14KHLUOyx_XiBV6UuzYT2yims-RHtpm1qPdIoCgO-AhDJ5tu8hkxjkNHDVrSWXXEg0g",
      "description": "150 grams of Al-Falah liver + 1 loaf of local brown bread + a plate of vegetable salad + 1 cup",
      "calories": "Calories: 700 kcal"
    },
    {
      "image": "https://lh5.googleusercontent.com/452QKZT8jTU5UY2uVMSLyJSKuoYhb-cgBoYx-1IFm4A1G7yiINd5VxNdA1Jxvi2Alg-p1k8KQrugKid8UJgo4rQI4wf12INNNnyRPTKmM93s2Hvyk5nfCtO6Ls6Hm3N6VXYsidIaZiL2gCbHvOhQy7hK8ARRRgqjg_6h-lfaeOJpAhPjbTpx65FoD860wg",
      "description": "¼ grilled chicken + 6 tablespoons of rice + 1 molokhiya plate + vegetable salad plate + 1 cup of juice without sugar.",
      "calories": "Calories: 600 kcal"
    },
    {
      "image": "https://lh3.googleusercontent.com/s2Nqm-hxQ1_z2UfydiwplfaLKKn73CaMT5lMPokRFEkwSJJzbvWIaf6x3m9xoC7G673nCifYrzqgZx_dZeef6Ch03e6nRjBJ_Jr9Yu_F74GE2XoJIgFEHmUzjEXU96jc7SdfAYj2QMt5ebXTJtK4MWDAVqvyo3ssBl_agRVb8rhQmRJ7y5-YiUUzFKLICg",
      "description": "1 chicken tortilla sandwich + 1 cup of yogurt + salad plate + 10 almonds.",
      "calories": "Calories: 600 kcal"
    },
    {
      "image": "https://lh3.googleusercontent.com/LT2f4q_GT8snpg92MeolOgqSVrv1YLV2wbuT0Gv7pbNe-a4zd8t6be0Igoj49X23r1sf5JEZM9ly7nS0tpvc9dODJlYQR0L-l-ck02ZJk4OcHR0mGex5RfUe0iHSNiJICEntwrsW-DlN60pEoUdPJazpXpWG50cuM0za_qE77JknUPcmftHxz8VNMw-2sg",
      "description": "150 grams of grilled steak + 5 tablespoons of pasta + a plate of vegetable salad + 1 apple.",
      "calories": "Calories: 650 kcal"
    },
    {
      "image": "https://lh5.googleusercontent.com/79vYDag7eoV-U-q6sKlIHFAbAQVL1NYikh8RBGnTE4SLYhSXCw_fisNqLXr5mX6iwFmD4JGEPQ-n6DzN-LI2XdM5uPg0gSQ9prihACHd3prxnVmSEQqd88YAjXPYTVbIp61uvZpc24bnwMRhxqxXRsgwI3CBO2VZeWVPnK2_bNu8zwz5WDUAesOwfaN6Kg",
      "description": "2 grilled fish (tilapia or mullet) + 5 tablespoons of brown rice + a plate of vegetable salad + a cup of juice without sugar.",
      "calories": "Calories: 600 kcal"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Lunch List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: lunchItems.map((lunchItem) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CachedNetworkImage(
                  imageUrl: lunchItem["image"]!,
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
                    lunchItem["description"]!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      lunchItem["calories"]!,
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
