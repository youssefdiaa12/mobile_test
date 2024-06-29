import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({Key? key, required this.product, required void Function() onAdd, required void Function() onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.asset(
          product['image'],
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        title: Text(product['name']),
        subtitle: Text('${product['price']} EGP'),
        onTap: () {
          // Navigate to the individual product page here
        },
      ),
    );
  }
}


