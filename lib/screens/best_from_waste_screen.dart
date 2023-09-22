import 'package:flutter/material.dart';
import 'package:sustainify/dummy_data/product_dummy_data.dart';

class BestFromWasteScreen extends StatelessWidget {
  const BestFromWasteScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 32, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Agricultural',
                style: TextStyle(
                  letterSpacing: -0.4,
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 300, // Set the desired height for your product cards
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 270, // Set the overall height of your BestFromWasteScreen
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductDisplayCard(
                          heading: dummyAgriculturalProducts[index].heading,
                          state: dummyAgriculturalProducts[index].state,
                          quantity: dummyAgriculturalProducts[index].quantity,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text(
                'Household',
                style: TextStyle(
                  letterSpacing: -0.4,
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 270,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductDisplayCard(
                          heading: dummyHouseholdProducts[index].heading,
                          state: dummyHouseholdProducts[index].state,
                          quantity: dummyHouseholdProducts[index].quantity,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDisplayCard extends StatelessWidget {
  const ProductDisplayCard({super.key, required this.heading, required this.state, required this.quantity});

  final String heading;
  final int quantity;
  final String state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 157, // Set the desired width for your product cards
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 157,
              width: 157,
              color: Colors.red,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                heading,
                style: const TextStyle(
                  letterSpacing: -0.4,
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                'Qty: $quantity',
                style: const TextStyle(
                  letterSpacing: -0.4,
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.all(4),
                child: Text(
                  state,
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
      ),
    );
  }
}
