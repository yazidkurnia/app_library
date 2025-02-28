import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> with SingleTickerProviderStateMixin {
  final TextEditingController _searchBookController = TextEditingController();
  late TabController _tabController;
  final List<String> _tabTitles = [
    'Mobile',
    'Web',
    'Artificial Intelligence',
    'Desktop'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabTitles.length, vsync: this);
  }

  @override
  void dispose() {
    _searchBookController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchBookController,
      decoration: InputDecoration(
        hintText: 'Cari buku...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: Theme.of(context).secondaryHeaderColor,
      unselectedLabelColor: Colors.blue[800],
      indicatorSize: TabBarIndicatorSize.label,
      tabs: _tabTitles.map((title) => Tab(text: title)).toList(),
    );
  }

  Widget _buildBookCard(String title) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 130,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildBestBooksSection(String sectionTitle) {
    final bookTitles = [
      'Tutorial Mahir Flutter',
      'Belajar React.js untuk Pemula',
      'Dasar-dasar Machine Learning',
      'Mobile App Development dengan Kotlin',
      'Frontend Web Development'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            sectionTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: bookTitles.length,
            itemBuilder: (context, index) => _buildBookCard(bookTitles[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent(String title) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      children: [
        _buildBestBooksSection('5 Buku $title Terbaik'),
        const SizedBox(height: 16),
        _buildBestBooksSection('Buku $title Populer'),
        const SizedBox(height: 16),
        _buildBestBooksSection('Buku $title Terbaru'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Katalog Buku'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: _buildTabBar(),
          ),
        ),
        body: Column(
          children: [
            // Search field stays static here
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildSearchField(),
            ),

            // Tab content takes remaining space
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:
                    _tabTitles.map((title) => _buildTabContent(title)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
