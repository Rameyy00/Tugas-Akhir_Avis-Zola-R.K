import 'package:project_1/models/model_laptop.dart';

class LaptopController {
  
  // Fungsi untuk mendapatkan data laptop dummy
  List<ModelLaptop> getLaptops() {
    return [
      ModelLaptop(
          id: 1, // ✨ ID ditambahkan
          brand: 'Apple',
          model: 'MacBook Pro',
          ram: 16,
          storage: 512,
          price: 12000000, 
          // Perhatikan nama file asset: 'assets/laptop 1.jpg'
          ImageAsset: 'assets/laptop  1.jpg'), 
          
      ModelLaptop(
          id: 2, // ✨ ID ditambahkan
          brand: 'Dell',
          model: 'XPS 13',
          ram: 16,
          storage: 256,
          price: 18000000,
          ImageAsset: 'assets/laptop2.jpg'),
          
      ModelLaptop(
          id: 3, // ✨ ID ditambahkan
          brand: 'HP',
          model: 'Spectre x360',
          ram: 16,
          storage: 512,
          price: 15000000,
          ImageAsset: 'assets/laptop 3.jpg'),
          
      ModelLaptop(
          id: 4, // ✨ ID ditambahkan
          brand: 'Lenovo',
          model: 'ThinkPad X1 Carbon',
          ram: 16,
          storage: 1024,
          price: 21000000,
          ImageAsset: 'assets/laptop4.jpg'),
          
      ModelLaptop(
          id: 5, // ✨ ID ditambahkan
          brand: 'Asus',
          model: 'ZenBook 14',
          ram: 8,
          storage: 512,
          price: 20000000,
          ImageAsset: 'assets/laptop5.jpg'),
    ];
  }
}