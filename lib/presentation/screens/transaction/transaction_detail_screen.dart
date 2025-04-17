import 'package:app_library/domain/entities/transaction_entity.dart';
import 'package:app_library/presentation/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/debug_log.dart';
import '../../presenters/transaction_presenter.dart';
import '../../states/transactions/transaction_state.dart';
import '../../widgets/custom_badge.dart';

class TransactionDetailScreen extends StatefulWidget {
  final String? transactionId;
  const TransactionDetailScreen({super.key, this.transactionId});

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  Future<TransactionEntity?> fetchTransactionData() async {
    final transactionData =
        Provider.of<TransactionPresenter>(context, listen: false);
    try {
      return await transactionData.getTransactionDetail(widget.transactionId);
    } catch (e) {
      // Handle error here, e.g., log it or show a message
      DebugLog().printLog('$e', 'error');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget titleAndData(String title, String data, CrossAxisAlignment axist) {
      return Column(
        crossAxisAlignment: axist,
        children: [Text(title), Text(data)],
      );
    }

    Widget statusTransaction(String status) {
      return SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        child: CustomBadge(
          badgeTitle: status,
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Transaksi'),
        ),
        body: FutureBuilder<TransactionEntity?>(
          future: fetchTransactionData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView(
                padding: const EdgeInsets.all(18),
                children: const [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomShimmer(
                            width: 100, height: 30, child: SizedBox()),
                        CustomShimmer(
                            width: 100, height: 30, child: SizedBox()),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No data found'));
            }

            var data = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(18),
              children: [
                statusTransaction(data.status!),
                const SizedBox(height: 12),
                titleAndData('No Transaksi', data.noTransaksi ?? '-',
                    CrossAxisAlignment.start),
                const SizedBox(height: 12),
                titleAndData('Tanggal Transaksi', data.transactionDate ?? '-',
                    CrossAxisAlignment.start),
                const SizedBox(height: 12),
                titleAndData('Total Peminjaman', data.loaningTotal!,
                    CrossAxisAlignment.start),
                const SizedBox(height: 12),
                titleAndData('Nama Peminjaman', data.loanerName!,
                    CrossAxisAlignment.start),
              ],
            );
          },
        ),
      ),
    );
  }
}
