import 'package:flutter/material.dart';

class ContentDetailBook extends StatelessWidget {
  final String? bookTitle;
  final String? descBook;
  const ContentDetailBook({super.key, this.bookTitle, this.descBook});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bookTitle ?? '',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          descBook ?? '',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        const Spacer(),
        const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Tahun terbit'), Text('2023')]),
        const SizedBox(
          height: 12,
        ),
        const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Penulis'), Text('Rio Ferdinan')]),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
