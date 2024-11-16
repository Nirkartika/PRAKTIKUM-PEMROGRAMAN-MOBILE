enum KategoriProduk { DataManagement, NetworkAutomation }

enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

class Produk {
  String namaProduk;
  int harga;
  KategoriProduk kategori;
  int jumlahTerjual;

  Produk(this.namaProduk, this.harga, this.kategori, this.jumlahTerjual) {
    if (kategori == KategoriProduk.NetworkAutomation && harga < 200000) {
      throw Exception("Harga produk NetworkAutomation harus minimal 200.000");
    } else if (kategori == KategoriProduk.DataManagement && harga >= 200000) {
      throw Exception("Harga produk DataManagement harus di bawah 200.000");
    }
  }

  double hargaSetelahDiskon() {
    if (kategori == KategoriProduk.NetworkAutomation && jumlahTerjual > 50) {
      double hargaDiskon = harga * 0.85;
      return hargaDiskon >= 200000 ? hargaDiskon : 200000;
    }
    return harga.toDouble();
  }
}

class Karyawan {
  String nama;
  int umur;
  String peran;

  Karyawan(this.nama, {required this.umur, required this.peran});
}

class KaryawanTetap extends Karyawan {
  KaryawanTetap(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);
}

class KaryawanKontrak extends Karyawan {
  KaryawanKontrak(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);
}

mixin Kinerja {
  int produktivitas = 0;
  DateTime? lastUpdate;

  void updateProduktivitas(int nilai) {
    DateTime now = DateTime.now();
    if (lastUpdate == null || now.difference(lastUpdate!).inDays >= 30) {
      if (nilai >= 0 && nilai <= 100) {
        produktivitas = nilai;
        lastUpdate = now;
        print("Sary dengan Produktivitas $nilai sedang mengelola tim.");
      } else {
        throw Exception("Nilai produktivitas harus antara 0 hingga 100.");
      }
    } else {
      throw Exception("Produktivitas hanya dapat diperbarui setiap 30 hari.");
    }
  }
}

class Manager extends Karyawan with Kinerja {
  Manager(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);


  void updateProduktivitas(int nilai) {
    super.updateProduktivitas(nilai);
    if (nilai < 85) {
      throw Exception("Produktivitas Manager harus minimal 85.");
    }
  }
}

class Proyek {
  FaseProyek fase = FaseProyek.Perencanaan;
  int jumlahKaryawanAktif;
  DateTime startDate;

  Proyek(this.jumlahKaryawanAktif) : startDate = DateTime.now();

  void nextFase() {
    if (fase == FaseProyek.Perencanaan && jumlahKaryawanAktif >= 5) {
      fase = FaseProyek.Pengembangan;
      print("Proyek beralih ke fase Pengembangan.");
    } else if (fase == FaseProyek.Pengembangan &&
        DateTime.now().difference(startDate).inDays > 45) {
      fase = FaseProyek.Evaluasi;
      print("Proyek beralih ke fase Evaluasi.");
    } else {
      throw Exception(
          "Syarat untuk beralih ke fase berikutnya belum terpenuhi.");
    }
  }
}

class TongIT {
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < 20) {
      karyawanAktif.add(karyawan);
      print("${karyawan.nama} ditambahkan sebagai karyawan aktif.");
    } else {
      throw Exception("Maksimal 20 karyawan aktif.");
    }
  }

  void resignKaryawan(Karyawan karyawan) {
    if (karyawanAktif.contains(karyawan)) {
      karyawanAktif.remove(karyawan);
      karyawanNonAktif.add(karyawan);
      print("${karyawan.nama} telah resign dan menjadi karyawan non-aktif.");
    } else {
      throw Exception("Karyawan tidak ditemukan dalam daftar aktif.");
    }
  }
}

void main() {
  try {
    var produk2 =
        Produk("ProdukB", 250000, KategoriProduk.NetworkAutomation, 60);
    print("Harga produk setelah diskon: ${produk2.hargaSetelahDiskon()}");

    var perusahaan = TongIT();
    var karyawan1 = KaryawanTetap("Nir", umur: 20, peran: "Developer");
    var manager = Manager("Sary", umur: 20, peran: "Manager");

    perusahaan.tambahKaryawan(karyawan1);
    perusahaan.tambahKaryawan(manager);

    manager.updateProduktivitas(90);

    var proyek = Proyek(5);
    proyek.nextFase();

    proyek.startDate = proyek.startDate.subtract(Duration(days: 46));
    proyek.nextFase();

    perusahaan.resignKaryawan(karyawan1);
  } catch (e) {
    print("Error: $e");
  }
}