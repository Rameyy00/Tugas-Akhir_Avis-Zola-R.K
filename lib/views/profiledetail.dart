// menu_detail_screens.dart

import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 80, color: Colors.indigo.shade300),
              const SizedBox(height: 20),
              Text(
                'Ini adalah halaman $title.',
                style: const TextStyle(fontSize: 18, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Implementasi UI dan logika data yang sebenarnya akan dilakukan di sini.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget untuk masing-masing halaman agar lebih mudah diakses

class AlamatPengirimanScreen extends StatelessWidget {
  const AlamatPengirimanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Daftar Alamat Pengiriman',
      icon: Icons.map_outlined,
    );
  }
}

class GantiKataSandiScreen extends StatelessWidget {
  const GantiKataSandiScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Ganti Kata Sandi',
      icon: Icons.lock_open_outlined,
    );
  }
}

class KetentuanLayananScreen extends StatelessWidget {
  const KetentuanLayananScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Ketentuan Layanan & Privasi',
      icon: Icons.description_outlined,
    );
  }
}

class EditFotoProfilScreen extends StatelessWidget {
  const EditFotoProfilScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Edit Foto Profil',
      icon: Icons.photo_camera_outlined,
    );
  }
}

class KetentuanLainnyaScreen extends StatelessWidget {
  const KetentuanLainnyaScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Ketentuan Lainnya',
      icon: Icons.info_outline,
    );
  }
}