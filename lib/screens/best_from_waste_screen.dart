import 'package:flutter/material.dart';
import 'package:sustainify/dummy_data/product_dummy_data.dart';
import 'package:sustainify/models/product_model.dart';

class BestFromWasteScreen extends StatelessWidget {
  const BestFromWasteScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Best From Waste'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: 'Agricultural'),
            ProductList(products: recycleAgriculturalProducts),
            SectionTitle(title: 'Household'),
            ProductList(products: dummyHouseholdProducts),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 16),
      child: Text(
        title,
        style: TextStyle(
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

  const ProductList({required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductDisplayCard(product: products[index]);
        },
      ),
    );
  }
}

class ProductDisplayCard extends StatelessWidget {
  final Product product;

  const ProductDisplayCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 157,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 2.0,
            spreadRadius: 1.0,
            offset: Offset(0, 1),
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
            color: Colors.red,
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              product.heading,
              style: TextStyle(
                letterSpacing: -0.4,
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              'Qty: ${product.quantity}',
              style: TextStyle(
                letterSpacing: -0.4,
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.only(left: 8, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(6),
              ),
              padding: EdgeInsets.all(4),
              child: Text(
                product.state,
                style: TextStyle(
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
