import 'package:app_library/presentation/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/debug_log.dart';
import '../../../../domain/entities/transaction_entity.dart';
import '../../../presenters/transaction_presenter.dart';
import '../../../states/transactions/transaction_state.dart';
import '../transaction_detail_screen.dart';

class TransactionContent extends StatefulWidget {
  const TransactionContent({super.key});

  @override
  State<TransactionContent> createState() => _TransactionContentState();
}

class _TransactionContentState extends State<TransactionContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void fetchTransactionData() async {
    final transactionState =
        Provider.of<TransactionState>(context, listen: false);
    final transactionData =
        Provider.of<TransactionPresenter>(context, listen: false);

    try {
      List<TransactionEntity?> transaction =
          await transactionData.getTransactionState();

      // Filter out null values
      List<TransactionEntity> nonNullTransactions = transaction
          .where((t) => t != null)
          .cast<TransactionEntity>()
          .toList();

      if (nonNullTransactions.isNotEmpty) {
        transactionState.setAllTransaciton(nonNullTransactions);
      }
    } catch (e) {
      // Handle error here, e.g., log it or show a message
      DebugLog().printLog('$e', 'error');
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchTransactionData();
  }

  @override
  Widget build(BuildContext context) {
    Widget listTileDataWaiting() {
      return Consumer<TransactionState>(builder: (context, state, child) {
        if (state.isLoading) {
          return const SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                CustomShimmer(
                    width: double.infinity, height: 100, child: SizedBox()),
                CustomShimmer(
                    width: double.infinity - 100,
                    height: 40,
                    child: SizedBox()),
              ],
            ),
          );
        }

        if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage.toString()));
        }

        if (state.transactionState.isEmpty) {
          return const Center(child: Text('Maaf, data tidak ditemukan'));
        }

        // Filter untuk transaksi yang statusnya 'Waiting'
        final waitingTransactions = state.transactionState
            .where((data) => data.status == 'Waiting')
            .toList();

        return ListView.builder(
          itemCount: waitingTransactions.length,
          itemBuilder: (context, index) {
            final dataState = waitingTransactions[index];
            return ListTile(
              title: Text(dataState.noTransaksi.toString()),
              subtitle:
                  Text(dataState.transactionDate ?? 'Tanggal tidak tersedia'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransactionDetailScreen(
                              transactionId: dataState.transaksiid,
                            )));
              },
            );
          },
        );
      });
    }

    Widget listTileDataCompleted() {
      return Consumer<TransactionState>(builder: (context, state, child) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage.toString()));
        }

        if (state.transactionState.isEmpty) {
          return const Center(child: Text('Maaf, data tidak ditemukan'));
        }

        // Filter untuk transaksi yang statusnya 'Completed'
        final completedTransactions = state.transactionState
            .where((data) => data.status == 'Completed')
            .toList();

        return ListView.builder(
          itemCount: completedTransactions.length,
          itemBuilder: (context, index) {
            final dataState = completedTransactions[index];
            return ListTile(
              title: Text(dataState.noTransaksi.toString()),
              subtitle:
                  Text(dataState.transactionDate ?? 'Tanggal tidak tersedia'),
            );
          },
        );
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transactions'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Waiting'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            listTileDataWaiting(),
            listTileDataCompleted(),
          ],
        ),
      ),
    );
  }
}
