import 'package:flutter/material.dart';
import 'package:flutter_course/core/utils/constants.dart';
import 'package:flutter_course/core/utils/responsive.dart'; // Import Responsive helper

class ContactInfoBar extends StatelessWidget {
  const ContactInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);

    return Container(
      color: AppColors.cardBackground,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: isMobile
          ? Center(
              child: Text(
                "+01 23456789 | Kalles@domain.com",
                style: const TextStyle(fontSize: 12),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.phone, size: 16, color: AppColors.textSecondary),
                    SizedBox(width: 4),
                    Text("+01 23456789", style: TextStyle(fontSize: 12)),
                    SizedBox(width: 16),
                    Icon(Icons.email_outlined, size: 16, color: AppColors.textSecondary),
                    SizedBox(width: 4),
                    Text("Kalles@domain.com", style: TextStyle(fontSize: 12)),
                  ],
                ),
                const Text(
                  "Summer sale discount off 50%! Shop Now",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
    );
  }
}
