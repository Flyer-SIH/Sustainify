import 'package:flutter/material.dart';
import 'package:sustainify/dummy_data/product_dummy_data.dart';
import 'package:sustainify/models/product_model.dart';
import 'package:sustainify/widgets/custom_app_bar.dart';

class BestFromWasteScreen extends StatelessWidget {
  const BestFromWasteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Best From Waste'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Agricultural'),
            ProductList(
              products: recycleAgriculturalProducts,
              type: 'agricultural',
            ),
            const SectionTitle(title: 'Household'),
            ProductList(
              products: dummyHouseholdProducts,
              type: 'household',
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: Text(
        title,
        style: const TextStyle(
          letterSpacing: -0.4,
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products;
  final String type;
  const ProductList({super.key, required this.products, required this.type});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductDisplayCard(
            product: products[index],
            index: index,
            type: type,
          );
        },
      ),
    );
  }
}

class ProductDisplayCard extends StatelessWidget {
  final Product product;
  final String type;
  final int index;

  const ProductDisplayCard({super.key, required this.product, required this.type, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 157,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 2.0,
            spreadRadius: 1.0,
            offset: const Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 157,
            width: 157,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/$type/$index.jpg'), fit: BoxFit.cover)),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              product.heading,
              style: const TextStyle(
                letterSpacing: -0.4,
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Qty: ${product.quantity}',
              style: const TextStyle(
                letterSpacing: -0.4,
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.all(4),
              child: Text(
                product.state,
                style: const TextStyle(
                  letterSpacing: -0.4,
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
