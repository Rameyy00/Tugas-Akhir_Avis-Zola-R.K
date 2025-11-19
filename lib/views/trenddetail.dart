// trend_detail_screen.dart

import 'package:flutter/material.dart';
// Asumsi kelas TrendItem ada di file yang sama atau sudah di-import
import 'trend_laptop.dart'; // Sesuaikan jika TrendItem berada di file terpisah

class TrendDetailScreen extends StatelessWidget {
  final TrendItem item;

  const TrendDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.isNews ? 'Berita Tren' : 'Review & Spek',
          style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo),
        ),
       
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Utama (Header)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                item.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
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
                  // Label Kategori
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: item.isNews ? Colors.white.withOpacity(0.15) : Colors.blue.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      item.isNews ? '🔥 BERITA UTAMA' : '✨ UJI COBA MENDALAM',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: item.isNews ? Colors.red.shade700 : Colors.blue.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Judul
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Sumber dan Tanggal
                  Row(
                    children: [
                      const Icon(Icons.public, size: 16, color: Colors.indigo),
                      const SizedBox(width: 8),
                      Text(
                        'Sumber: ${item.source}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.indigo,
                        ),
                      ),
                      // Anda bisa menambahkan tanggal di sini jika data memiliki tanggal
                      // const Spacer(), 
                      // Text('18 Nov 2025', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                  const Divider(height: 30),

                  // Konten (Snippet diperpanjang untuk detail)
                  const Text(
                    'Ringkasan Singkat:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.snippet + 
                    "\n\nIni adalah ringkasan yang lebih detail dari artikel/review tersebut. Anda dapat menampilkan konten penuh di sini (jika tersedia). Artikel ini membahas tentang " + 
                    item.title.toLowerCase() + 
                    " dan implikasinya di pasar laptop saat ini. Baca selengkapnya di situs resmi.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Tombol Aksi
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Aksi: Navigasi ke sumber eksternal (simulasi)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Mengunjungi situs sumber ${item.source}...')),
                        );
                      },
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Baca Selengkapnya'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: const BorderSide(color: Colors.indigo),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}