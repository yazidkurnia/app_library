import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  final String? badgeTitle;
  const CustomBadge({super.key, this.badgeTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: badgeTitle == 'Waiting'
            ? Colors.amber
            : badgeTitle == 'Reject'
                ? Colors.red
                : Colors.green,
      ),
      child: Center(child: Text(badgeTitle ?? '-')),
    );
  }
}
