class ModelLaptop {
  // 1. ID dijadikan opsional (nullable)
  final int? id; 
  final String brand;
  final String model;
  final int ram;
  final int storage;
  final double price;
  
  // 2. ImageAsset dijadikan opsional (nullable)
  final String? ImageAsset; 

  ModelLaptop({
    this.id, // ID opsional
    required this.brand,
    required this.model,
    required this.ram,
    required this.storage,
    required this.price,
    this.ImageAsset, // ImageAsset opsional
  });
  
  // 3. Menambahkan method copyWith untuk mempermudah update data
  ModelLaptop copyWith({
    int? id,
    String? brand,
    String? model,
    int? ram,
    int? storage,
    double? price,
    String? ImageAsset,
  }) {
    return ModelLaptop(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      ram: ram ?? this.ram,
      storage: storage ?? this.storage,
      price: price ?? this.price,
      ImageAsset: ImageAsset ?? this.ImageAsset,
    );
  }
}