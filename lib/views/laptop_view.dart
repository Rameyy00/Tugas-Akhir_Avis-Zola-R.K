import 'package:flutter/material.dart';
import 'package:project_1/controller/laptop_controller.dart';
import 'package:project_1/models/model_laptop.dart';
// import '../views/carousel.dart'; // Jika ini digunakan, pastikan path benar

class LaptopView extends StatefulWidget {
  const LaptopView({super.key});

  @override
  State<LaptopView> createState() => _LaptopViewState();
}

class _LaptopViewState extends State<LaptopView> {
  final formKey = GlobalKey<FormState>();
  final LaptopController laptopController = LaptopController();

  final TextEditingController brand = TextEditingController();
  final TextEditingController model = TextEditingController();
  final TextEditingController ram = TextEditingController();
  final TextEditingController storage = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController imageLink = TextEditingController(); 

  List<ModelLaptop> laptop = [];
  
  String _searchText = ''; 
  
  // Path default gambar jika tidak ada input
  final String defaultImagePath = 'assets/laptop  1.jpg'; 

  @override
  void initState() {
    super.initState();
    getLaptop();
  }
  
  void getLaptop() {
    if (laptop.isEmpty) {
      // Menggunakan data dummy dari controller jika list kosong
      laptop = laptopController.getLaptops();
    }
    setState(() {});
  }
  
  // Getter untuk list yang difilter
  List<ModelLaptop> get _filteredLaptopItems {
    if (_searchText.isEmpty) {
      return laptop;
    }
    final lowerCaseSearch = _searchText.toLowerCase();
    
    return laptop.where((item) {
      final itemFullName = '${item.brand} ${item.model}'.toLowerCase();
      return itemFullName.contains(lowerCaseSearch) ||
             item.brand.toLowerCase().contains(lowerCaseSearch) ||
             item.model.toLowerCase().contains(lowerCaseSearch);
    }).toList();
  }
  
  // Fungsi untuk menampilkan form tambah/edit laptop
  // Mengambil ModelLaptop itu sendiri jika dalam mode edit, bukan hanya indeks
  void showLaptopForm({ModelLaptop? itemToEdit}) {
    
    // Inisialisasi controller berdasarkan mode (Edit atau Tambah)
    if (itemToEdit != null) {
      brand.text = itemToEdit.brand;
      model.text = itemToEdit.model;
      ram.text = itemToEdit.ram.toString();
      storage.text = itemToEdit.storage.toString();
      price.text = itemToEdit.price.toString();
      imageLink.text = itemToEdit.ImageAsset ?? defaultImagePath; 
    } else {
      brand.clear();
      model.clear();
      ram.clear();
      storage.clear();
      price.clear();
      imageLink.text = defaultImagePath; // Defaultkan ke asset path saat tambah baru
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: SingleChildScrollView( 
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  itemToEdit == null ? '💻 Tambah Produk Baru' : '✍️ Edit Detail Laptop',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: brand,
                  decoration: const InputDecoration(
                    labelText: 'Brand (mis. Asus, Lenovo)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    prefixIcon: Icon(Icons.business_center_outlined),
                  ),
                  validator: (value) => value!.isEmpty ? 'Brand wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: model,
                  decoration: const InputDecoration(
                    labelText: 'Model (mis. ROG Strix G15)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    prefixIcon: Icon(Icons.desktop_windows_outlined),
                  ),
                  validator: (value) => value!.isEmpty ? 'Model wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: ram,
                        decoration: const InputDecoration(
                          labelText: 'RAM (GB)',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          prefixIcon: Icon(Icons.memory_outlined),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) => value!.isEmpty ? 'RAM wajib diisi' : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: storage,
                        decoration: const InputDecoration(
                          labelText: 'Storage (GB/TB)',
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          prefixIcon: Icon(Icons.storage_outlined),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) => value!.isEmpty ? 'Storage wajib diisi' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: price,
                  decoration: const InputDecoration(
                    labelText: 'Harga Jual',
                    prefixText: 'Rp ', 
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    prefixIcon: Icon(Icons.payments_outlined),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Harga wajib diisi' : null,
                ),
                const SizedBox(height: 12), 
                
                // TEXT FIELD UNTUK LINK GAMBAR
                TextFormField(
                  controller: imageLink,
                  decoration: const InputDecoration(
                    labelText: 'Link/Asset Gambar (Opsional)',
                    hintText: 'Contoh: assets/laptop4.jpg atau URL Web',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    prefixIcon: Icon(Icons.link_outlined),
                  ),
                ),
                
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        
                        // Perbaikan: Gunakan trim() untuk membersihkan input string
                        final String finalImagePath = imageLink.text.trim().isNotEmpty 
                            ? imageLink.text.trim() 
                            : defaultImagePath; 
                        
                        final newLaptop = ModelLaptop(
                          // Jika itemToEdit TIDAK null, gunakan ID-nya, jika tidak, gunakan null (Controller yang akan atur ID baru)
                          id: itemToEdit != null ? itemToEdit.id : null,
                          brand: brand.text.trim(),
                          model: model.text.trim(),
                          ram: int.tryParse(ram.text) ?? 0, // Menggunakan tryParse untuk keamanan
                          storage: int.tryParse(storage.text) ?? 0, // Menggunakan tryParse untuk keamanan
                          price: double.tryParse(price.text) ?? 0.0, // Menggunakan tryParse untuk keamanan
                          ImageAsset: finalImagePath, 
                        );

                        setState(() {
                          if (itemToEdit != null) {
                            // --- LOGIKA UPDATE BERDASARKAN ID ---
                            final actualIndex = laptop.indexWhere((item) => item.id == itemToEdit.id);
                            if (actualIndex != -1) {
                              // Menggunakan .copyWith() yang telah kita tambahkan ke ModelLaptop
                              laptop[actualIndex] = newLaptop.copyWith(id: itemToEdit.id); 
                            }
                          } else {
                            // --- LOGIKA TAMBAH BARU (ID OTOMATIS) ---
                            final newId = laptop.isEmpty ? 1 : (laptop.map((e) => e.id ?? 0).reduce((a, b) => a > b ? a : b) + 1);
                            laptop.add(newLaptop.copyWith(id: newId));
                          }
                        });

                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      itemToEdit == null ? 'SIMPAN PRODUK' : 'UPDATE DATA',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // Fungsi delete juga diperbarui untuk mengambil ModelLaptop, bukan hanya indeks dari filtered list
  void deleteLaptop(ModelLaptop itemToDelete) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('⚠️ Konfirmasi Hapus', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text('Apakah Anda yakin ingin menghapus data ${itemToDelete.brand} ${itemToDelete.model} secara permanen?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('BATAL', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // --- LOGIKA HAPUS BERDASARKAN ID ---
                laptop.removeWhere((item) => item.id == itemToDelete.id);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
            child: const Text('HAPUS'),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'My Laptop',
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.indigo, fontSize: 24),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showLaptopForm(), // Tambah baru (itemToEdit = null)
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_circle_outline),
        label: const Text('Tambah Laptop'),
      ),
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
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
          // Daftar Laptop (Expanded)
          Expanded(
            child: _filteredLaptopItems.isEmpty && _searchText.isNotEmpty
                ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 60, color: Colors.grey),
                          SizedBox(height: 10),
                          Text(
                            'Data yang dicari tidak ditemukan.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                : _filteredLaptopItems.isEmpty && _searchText.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.widgets_outlined, size: 80, color: Colors.blueGrey),
                            SizedBox(height: 10),
                            Text(
                              'Kosong! Saatnya isi katalog penjualanmu.', 
                              style: TextStyle(fontSize: 16, color: Colors.blueGrey)
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 100, top: 10), 
                        itemCount: _filteredLaptopItems.length,
                        itemBuilder: (context, index) {
                          final item = _filteredLaptopItems[index]; 
                          return LaptopCardModern(
                            item: item,
                            // Kirim item ModelLaptop yang sedang diklik ke showLaptopForm
                            onEdit: () => showLaptopForm(itemToEdit: item), 
                            onDelete: (itemToDelete) => deleteLaptop(itemToDelete), // Kirim item ModelLaptop ke delete
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET CARD MODERN ---
class LaptopCardModern extends StatelessWidget {
  final ModelLaptop item;
  final VoidCallback onEdit;
  final void Function(ModelLaptop) onDelete; // Diperbarui: menerima ModelLaptop

  const LaptopCardModern({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  String _formatPrice(double price) {
    // Dipindahkan ke dalam method untuk konsistensi
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }
  
  Widget _buildSpecChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1. Tentukan apakah path adalah URL Jaringan
    final isNetworkImage = item.ImageAsset != null && 
                           (item.ImageAsset!.startsWith('http://') || item.ImageAsset!.startsWith('https://'));

    // 2. Tentukan Widget Gambar yang akan digunakan
    final Widget imageWidget = isNetworkImage
        ? Image.network(
            item.ImageAsset!,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
                  strokeWidth: 2,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                  child: Icon(Icons.cloud_off, size: 40, color: Colors.redAccent));
            },
          )
        : Image.asset(
            item.ImageAsset ?? 'assets/laptop1.jpg', 
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey));
            },
          );
          
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onEdit,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: imageWidget, 
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.brand} ${item.model}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatPrice(item.price),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_horiz, color: Colors.blueGrey),
                    onSelected: (String value) {
                      if (value == 'edit') {
                        onEdit();
                      } else if (value == 'delete') {
                        onDelete(item); // Perbaikan: Kirim item
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined, size: 20, color: Colors.blue),
                            SizedBox(width: 8),
                            Text('Edit Detail'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, color: Colors.red, size: 20),
                            SizedBox(width: 8),
                            Text('Hapus Produk', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: [
                  _buildSpecChip(Icons.flash_on, '${item.ram} GB RAM', Colors.blue),
                  _buildSpecChip(Icons.disc_full, '${item.storage} GB SSD/HDD', Colors.deepOrange),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}