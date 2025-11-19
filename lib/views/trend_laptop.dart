import 'package:flutter/material.dart';
import 'trenddetail.dart'; // Pastikan import ini benar

class TrendItem {
  final String title;
  final String snippet;
  final String imageAsset;
  final String source;
  final bool isNews;

  TrendItem({
    required this.title,
    required this.snippet,
    required this.imageAsset,
    required this.source,
    required this.isNews,
  });
}


List<TrendItem> getDaftarTrend() {
  return [
    TrendItem(
      title: 'Intel Lunar Lake: Era Laptop Tipis dan Hemat Baterai',
      snippet: 'Prosesor terbaru Intel menjanjikan efisiensi daya 3x lebih baik, menjadikannya pilihan utama untuk ultrabook 2025.',
      imageAsset: 'assets/news.jpg',
      source: 'Tekno Update',
      isNews: true,
    ),
    TrendItem(
      title: 'Review: MacBook Pro M4 vs. Rival Windows, Siapa Raja Performa?',
      snippet: 'Uji performa mendalam chip M4 terbaru Apple melawan RTX 4080 Mobile.',
      imageAsset: 'assets/berita2.jpg',
      source: 'Gadget Mania',
      isNews: false,
    ),
    TrendItem(
      title: 'ASUS ROG Zephyrus G14: Spek Penuh & Harga Rilis di Indonesia',
      snippet: 'Laptop gaming 14 inci paling dinanti. Hadir dengan Ryzen 9 dan RTX 4070.',
      imageAsset: 'assets/images.jpg',
      source: 'Info Gaming',
      isNews: false,
    ),
    TrendItem(
      title: 'Mengenal Teknologi Layar OLED di Laptop Modern',
      snippet: 'Layar OLED menawarkan kontras tak terbatas dan warna yang akurat, kini menjadi standar baru.',
      imageAsset: 'assets/berita3.jpg',
      source: 'Display Tech',
      isNews: true,
    ),
  ];
}


class TrendLaptop extends StatefulWidget {
  const TrendLaptop({super.key});

  @override
  State<TrendLaptop> createState() => _TrendLaptopState();
}

class _TrendLaptopState extends State<TrendLaptop> {

  String _searchText = '';
  
  
  late List<TrendItem> _allTrendItems;

  @override
  void initState() {
    super.initState();
    _allTrendItems = getDaftarTrend();
  }


  List<TrendItem> get _filteredTrendItems {
    if (_searchText.isEmpty) {
      return _allTrendItems;
    }
    final lowerCaseSearch = _searchText.toLowerCase();
    

    return _allTrendItems.where((item) {
      return item.title.toLowerCase().contains(lowerCaseSearch) ||
             item.snippet.toLowerCase().contains(lowerCaseSearch) ||
             item.source.toLowerCase().contains(lowerCaseSearch);
    }).toList();
  }


  Widget _buildTrendCard(BuildContext context, TrendItem item) {
    
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          // ✨ IMPLEMENTASI NAVIGASI KE HALAMAN DETAIL
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrendDetailScreen(item: item), // Meneruskan item yang dipilih
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                item.imageAsset,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.laptop_chromebook, size: 50, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: item.isNews ? Colors.red.withOpacity(0.15) : Colors.blue.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.isNews ? '🔥 BERITA' : '✨ REVIEW/SPEK',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: item.isNews ? Colors.red : Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  Text(
                    item.snippet,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  
                  Row(
                    children: [
                      const Icon(Icons.public, size: 14, color: Colors.indigo),
                      const SizedBox(width: 5),
                      Text(
                        'Sumber: ${item.source}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column( 
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0, bottom: 8.0),
            child: Text(
              '📰 Tren & Spek Laptop Terbaru',
              style: TextStyle(
                fontWeight: FontWeight.w900, 
                color: Colors.indigo,
                fontSize: 24, 
                
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari berita, review, atau spek...',
                prefixIcon: const Icon(Icons.search, color: Colors.indigo),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.indigo.withOpacity(0.05),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              ),
            ),
          ),
          
          Expanded(
            child: _filteredTrendItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.search_off, size: 60, color: Colors.grey),
                      const SizedBox(height: 10),
                      Text(
                        _searchText.isEmpty
                            ? 'Tidak ada data tren yang tersedia.'
                            : 'Berita atau review yang dicari tidak ditemukan.',
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16, top: 8),
                  itemCount: _filteredTrendItems.length,
                  itemBuilder: (context, index) {
                    return _buildTrendCard(context, _filteredTrendItems[index]);
                  },
                ),
          ),
        ],
      ),
    );
  }
}