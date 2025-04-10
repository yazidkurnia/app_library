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
  void fetchTransactionData(var transactionId) async {
    final transactionState =
        Provider.of<TransactionState>(context, listen: false);
    final transactionData =
        Provider.of<TransactionPresenter>(context, listen: false);

    try {
      transactionState.setLoading(true);
      TransactionEntity? transaction =
          await transactionData.getTransactionDetail(transactionId);
      if (transaction?.transaksiid != null) {
        transactionState.setSingleTransactionData(transaction!);
        transactionState.setLoading(false);
      }
      transactionState.setLoading(false);
    } catch (e) {
      // Handle error here, e.g., log it or show a message
      transactionState.setLoading(false);
      DebugLog().printLog('$e', 'error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTransactionData(widget.transactionId);
  }

  @override
  Widget build(BuildContext context) {
    Widget titleAndData(String title, String data, CrossAxisAlignment axist) {
      return Column(
        crossAxisAlignment: axist,
        children: [Text(title), Text(data)],
      );
    }

    Widget statusTransaction(status) {
      return SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        child: CustomBadge(
          badgeTitle: status,
        ),
      );
    }

    Widget detailTransaction() {
      return Consumer<TransactionState>(
        builder: (context, value, child) {
          bool isLoading = value.isLoading;
          var data = value.singleTransactionData;
          if (isLoading == true) {
            return ListView(
              padding: const EdgeInsets.all(18),
              children: const [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomShimmer(width: 100, height: 30, child: SizedBox()),
                      CustomShimmer(width: 100, height: 30, child: SizedBox()),
                    ],
                  ),
                ),
              ],
            );
          }
          return ListView(
            padding: const EdgeInsets.all(18),
            children: [
              statusTransaction(data.status),
              const SizedBox(height: 12),
              titleAndData('No Transaksi', data.noTransaksi ?? '-',
                  CrossAxisAlignment.start),
              const SizedBox(
                height: 12,
              ),
              titleAndData('Tanggal Transaksi', data.transactionDate ?? '-',
                  CrossAxisAlignment.start),
              const SizedBox(
                height: 12,
              ),
              titleAndData('Total Peminjaman', data.loaningTotal!,
                  CrossAxisAlignment.start),
              const SizedBox(
                height: 12,
              ),
              titleAndData('Nama Peminjaman', data.loanerName!,
                  CrossAxisAlignment.start),
            ],
          );
        },
      );
    }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
      ),
      body: detailTransaction(),
    ));
  }
}
