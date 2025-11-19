import 'package:flutter/material.dart';
// 1. Impor yang benar: Ganti 'profiledetail.dart' dengan 'menu_detail_screens.dart' 
// (sesuaikan path impor jika file Anda tidak berada di 'project_1/views/menu_detail_screens.dart')
import 'package:project_1/views/profiledetail.dart'; 

// =======================================================
// CLASS UTAMA
// =======================================================

class AkunLaptop extends StatefulWidget {
  const AkunLaptop({super.key});

  @override
  State<AkunLaptop> createState() => _AkunLaptopState();
}

class _AkunLaptopState extends State<AkunLaptop> {
  // 2. Default Path: Menggunakan URL jaringan agar sesuai dengan logika NetworkImage di bawah.
  // Jika ingin menggunakan aset lokal, pastikan aset terdaftar di pubspec.yaml.
  String _userProfilePicture = 'assets/foto.jpg'; // Ganti dengan URL atau path aset lokal yang valid
  
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black87,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.indigo),
          title: Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
          onTap: onTap,
        ),
        const Divider(height: 0, thickness: 1, indent: 16, endIndent: 16),
      ],
    );
  }

  // ✨ FUNGSI MENAMPILKAN MODAL BOTTOM SHEET
  void _showEditPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Text(
                  'Pilih Sumber Foto Profil',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
              const Divider(),
              // Opsi 1: Dari Link (URL) - Navigasi dan Tunggu Hasil
              ListTile(
                leading: const Icon(Icons.link, color: Colors.blueAccent),
                title: const Text('Gunakan Link (URL Web)'),
                onTap: () async { // <-- Tambahkan 'async'
                  Navigator.pop(bc); // Tutup bottom sheet
                  
                  // 3. IMPLEMENTASI NAVIGASI DENGAN MENGHARAPKAN HASIL (URL BARU)
                  final newUrl = await Navigator.push( // <-- Tambahkan 'await'
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditFotoProfilScreen(),
                    ),
                  );

                  // Perbarui state jika hasil navigasi adalah String non-kosong yang valid
                  if (newUrl != null && newUrl is String && newUrl.isNotEmpty) {
                    setState(() {
                      _userProfilePicture = newUrl;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Foto profil berhasil diperbarui dari URL.')),
                    );
                  }
                },
              ),
              // Opsi 2: Dari Asset Lokal
              ListTile(
                leading: const Icon(
                  Icons.photo_library_outlined,
                  color: Colors.green,
                ),
                title: const Text('Pilih dari Asset Lokal'),
                onTap: () {
                  Navigator.pop(bc);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Simulasi: Membuka file explorer untuk Asset.'),
                    ),
                  );
                },
              ),
              // Opsi 3: Hapus Foto
              ListTile(
                leading: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                ),
                title: const Text('Hapus Foto Profil'),
                onTap: () {
                  Navigator.pop(bc); 
                  setState(() {
                    _userProfilePicture = ''; 
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Foto profil telah dihapus.')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // WIDGET PROFILE SECTION (Logika rendering foto dan AnimatedSwitcher)
  Widget _buildProfileSection(
    BuildContext context, {
    required String profilePictureUrl,
  }) {
    bool isNetworkImage =
        profilePictureUrl.startsWith('http') || profilePictureUrl.startsWith('https');
    
    Widget profileImageWidget;

    if (profilePictureUrl.isNotEmpty) {
      if (isNetworkImage) {
        profileImageWidget = Image.network(
          profilePictureUrl,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          key: ValueKey(profilePictureUrl), // Tambahkan Key untuk AnimatedSwitcher
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                strokeWidth: 2,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.person_off_outlined,
              size: 40,
              color: Colors.indigo,
            );
          },
        );
      } else {
        // Menggunakan Image.asset untuk path lokal
        profileImageWidget = Image.asset(
          profilePictureUrl,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          key: ValueKey(profilePictureUrl), // Tambahkan Key untuk AnimatedSwitcher
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.person_off_outlined,
              size: 40,
              color: Colors.indigo,
            );
          },
        );
      }
    } else {
      // Tampilkan ikon default jika _userProfilePicture kosong (telah dihapus)
      profileImageWidget = const Icon(
        Icons.person_outline,
        size: 40,
        color: Colors.indigo,
        key: ValueKey('default_icon'),
      );
    }

    return Card(
      elevation: 6,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          children: [
            // Kontainer Foto yang juga bisa diklik untuk edit
            InkWell(
              onTap: () => _showEditPhotoOptions(context),
              borderRadius: BorderRadius.circular(35),
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.indigo.shade100,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: ClipOval(
                    // Key Value digunakan untuk memaksa AnimatedSwitcher beranimasi saat URL berubah
                    key: ValueKey(profilePictureUrl.isNotEmpty ? profilePictureUrl : 'empty'), 
                    child: profileImageWidget,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Halo, Avis!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'avis@example.com (Akun Aktif)',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            // Tombol Edit yang memunculkan sheet yang sama
            IconButton(
              onPressed: () => _showEditPhotoOptions(context),
              icon: const Icon(Icons.edit_outlined, color: Colors.blueAccent),
              tooltip: 'Edit Profil',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          ' Akun Saya',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.indigo,
            fontSize: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildProfileSection(
              context,
              profilePictureUrl: _userProfilePicture,
            ),
            const SizedBox(height: 10),

            const SizedBox(height: 20),

            const Text(
              'Pengaturan Umum',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),

            _buildMenuItem(
              icon: Icons.map_outlined,
              title: 'Daftar Alamat Pengiriman',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AlamatPengirimanScreen(),
                  ),
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.lock_open_outlined,
              title: 'Ganti Kata Sandi',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GantiKataSandiScreen(),
                  ),
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.description_outlined,
              title: 'Ketentuan Layanan & Privasi',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KetentuanLayananScreen(),
                  ),
                );
              },
            ),

            _buildMenuItem(
              icon: Icons.info_outline,
              title: 'Ketentuan Lainnya',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KetentuanLainnyaScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Anda berhasil Logout.')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                ),
                icon: const Icon(Icons.logout),
                label: const Text(
                  'LOGOUT',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}