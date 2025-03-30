import 'package:flutter/material.dart';

class CustomToast {
  static void showToast(BuildContext context, String message, String type) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0, // Atur posisi toast
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info,
                    color: type == 'success'
                        ? Colors.green
                        : Colors.red), // Ganti dengan ikon yang diinginkan
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Hapus toast setelah beberapa detik
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
