import 'package:app_library/presentation/screens/transaction/transaction_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../../../core/constants/debug_log.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({super.key});

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _validation_transaction_status({String? message, String? type}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message!),
      backgroundColor: type == 'error' ? Colors.red : Colors.blue,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Approval'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Dengan menggunakan qr scanner ini anda dapat langsung menuju ke halaman approval persetejuan peminjaman atau pengembalian',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 48),
              ScaleTransition(
                scale: _animation,
                child: GestureDetector(
                  onTap: () async {
                    // Action when button is tapped
                    print('Button tapped!');
                    String resultScanner =
                        await FlutterBarcodeScanner.scanBarcode(
                            "#ff6666", "Cancel", false, ScanMode.DEFAULT);

                    DebugLog()
                        .printLog('scanning response: $resultScanner', 'info');

                    if (resultScanner.isEmpty || resultScanner == '-1') {
                      return _validation_transaction_status(
                          message:
                              'Terjadi kesalahan pda proses scanning atau data tidak valid',
                          type: 'error');
                    } else {
                      DebugLog().printLog(resultScanner, 'debug');
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionDetailScreen(
                                    transactionId: resultScanner,
                                  )));
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.qr_code_scanner_sharp,
                        size: 42,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
