import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            // Konten untuk tab "Waiting"
            ListView(
              children: const [
                ListTile(
                  title: Text('Transaction 1 - Waiting'),
                  subtitle: Text('Details about transaction 1'),
                ),
                ListTile(
                  title: Text('Transaction 2 - Waiting'),
                  subtitle: Text('Details about transaction 2'),
                ),
              ],
            ),
            // Konten untuk tab "Completed"
            ListView(
              children: const [
                ListTile(
                  title: Text('Transaction 1 - Completed'),
                  subtitle: Text('Details about transaction 1'),
                ),
                ListTile(
                  title: Text('Transaction 2 - Completed'),
                  subtitle: Text('Details about transaction 2'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
