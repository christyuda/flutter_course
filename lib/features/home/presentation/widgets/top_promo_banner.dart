import 'package:flutter/material.dart';

class TopPromoBanner extends StatelessWidget {
  const TopPromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pinkAccent, // warna sesuai contoh gambar
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Text(
          "Today deal sale off 70%. End in 87 weeks 03 days 08:19:48. Hurry Up →",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
