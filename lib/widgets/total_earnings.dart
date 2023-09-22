import 'package:flutter/material.dart';

class TotalEarnings extends StatelessWidget {
  const TotalEarnings({
    super.key,
    required this.totalPoints,
  });
  final int totalPoints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        height: 136,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.indigo,
          border: Border.all(color: Colors.transparent),
          boxShadow: const [BoxShadow(offset: Offset(0, -1), blurRadius: 5, color: Color.fromRGBO(0, 0, 0, 0.1))],
        ),
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'TOTAL EARNINGS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
            ),
            Text(
              '₹ $totalPoints',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.99,
              ),
            )
          ],
        ),
      ),
    );
  }
}
