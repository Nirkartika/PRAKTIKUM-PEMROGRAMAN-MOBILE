import 'dart:async';

enum Role { Admin, Customer }

class Product {
  String productName;
  double price;
  bool available;

  Product(this.productName, this.price, this.available);
}

class User {
  String name;
  int age;
  late List<Product> productList;
  Role? role;

  User(this.name, this.age, this.role) {
    productList = [];
  }

  void viewProducts() {
    if (productList.isEmpty) {
      print("Tidak ada produk yang tersedia.");
    } else {
      productList.forEach((product) {
        print(
            "Nama Produk: ${product.productName}, Harga: Rp${product.price}, Tersedia: ${product.available}");
      });
    }
  }
}

class AdminUser extends User {
  Map<String, Product> productMap = {};

  AdminUser(String name, int age) : super(name, age, Role.Admin);

  void addProduct(Product product) {
    if (product.available) {
      var productSet = Set<Product>.from(productList);
      if (!productSet.contains(product)) {
        productList.add(product);
        productMap[product.productName] = product;
        print("Produk ${product.productName} berhasil ditambahkan.");
      } else {
        print("Produk ${product.productName} sudah ada dalam daftar.");
      }
    } else {
      throw OutOfStockException(
          "Tidak dapat menambahkan produk ${product.productName} karena stok habis.");
    }
  }

  void removeProduct(Product product) {
    if (productList.contains(product)) {
      productList.remove(product);
      productMap.remove(product.productName);
      print("Produk ${product.productName} berhasil dihapus.");
    } else {
      print("Produk tidak ditemukan.");
    }
  }
}

class CustomerUser extends User {
  CustomerUser(String name, int age) : super(name, age, Role.Customer);
}

class OutOfStockException implements Exception {
  final String message;
  OutOfStockException(this.message);

  String toString() => message;
}

Future<void> fetchProductDetails() async {
  print("Mengambil detail produk...");
  await Future.delayed(Duration(seconds: 2));
  print("Detail produk berhasil diambil.");
}

void main() async {
  var admin = AdminUser("Admin1", 30);
  var customer = CustomerUser("Customer1", 25);

  var product1 = Product("Laptop", 15000000.0, true);
  var product2 = Product("Handphone", 8000000.0, false);

  try {
    admin.addProduct(product1);
    admin.addProduct(product2);
  } on OutOfStockException catch (e) {
    print("OutOfStockException: $e");
  } catch (e) {
    print("Terjadi kesalahan: $e");
  }

  print("\nDaftar Produk Admin:");
  admin.viewProducts();

  print("\nDaftar Produk Pelanggan:");
  customer.viewProducts();

  await fetchProductDetails();
}
