class ProdukDigital {
  String namaProduk;
  double harga;
  String kategori;

  ProdukDigital({
    required this.namaProduk,
    required this.harga,
    required this.kategori,
  });

  void terapkanDiskon(double diskon) {
    harga -= harga * diskon / 100;
    print('Diskon diterapkan: Harga baru produk $namaProduk adalah Rp. $harga');
  }
}

abstract class Karyawan {
  String nama;
  int umur;
  String peran;

  Karyawan({
    required this.nama,
    required this.umur,
    required this.peran,
  });

  void bekerja();
}

class KaryawanTetap extends Karyawan {
  KaryawanTetap({
    required String nama,
    required int umur,
    required String peran,
  }) : super(nama: nama, umur: umur, peran: peran);

  void bekerja() {
    print('$nama bekerja sebagai Karyawan Tetap dengan penuh tanggung jawab.');
  }
}

class KaryawanKontrak extends Karyawan {
  KaryawanKontrak({
    required String nama,
    required int umur,
    required String peran,
  }) : super(nama: nama, umur: umur, peran: peran);

  void bekerja() {
    print('$nama bekerja sebagai Karyawan Kontrak dengan batas waktu kontrak.');
  }
}

class KaryawanPerusahaan {
  final String nama;
  final int umur;
  final String peran;

  KaryawanPerusahaan(this.nama, {required this.umur, required this.peran});

  void tampilkanInformasi() {
    print('Nama: $nama, Umur: $umur, Peran: $peran');
  }
}

mixin Kinerja {
  int produktivitas = 80;

  void naikkanProduktivitas() {
    produktivitas += 5;
    if (produktivitas > 100) {
      produktivitas = 100;
    }
    print('Produktivitas meningkat: $produktivitas');
  }
}

class KaryawanDenganKinerja extends Karyawan with Kinerja {
  KaryawanDenganKinerja({
    required String nama,
    required int umur,
    required String peran,
  }) : super(nama: nama, umur: umur, peran: peran);

  void bekerja() {
    print('$nama bekerja dengan produktivitas $produktivitas.');
    naikkanProduktivitas();
  }
}

enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

class Proyek {
  FaseProyek fase;

  Proyek(this.fase);

  void transisiFase(FaseProyek faseBaru) {
    if ((fase == FaseProyek.Perencanaan &&
            faseBaru == FaseProyek.Pengembangan) ||
        (fase == FaseProyek.Pengembangan && faseBaru == FaseProyek.Evaluasi)) {
      fase = faseBaru;
      print('Transisi fase berhasil: $fase');
    } else {
      print('Transisi fase tidak valid!');
    }
  }
}

class Perusahaan {
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];
  final int maxKaryawanAktif = 20;

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < maxKaryawanAktif) {
      karyawanAktif.add(karyawan);
      print('Karyawan ${karyawan.nama} ditambahkan sebagai karyawan aktif.');
    } else {
      print('Batas karyawan aktif tercapai!');
    }
  }

  void resignKaryawan(Karyawan karyawan) {
    karyawanAktif.remove(karyawan);
    karyawanNonAktif.add(karyawan);
    print('Karyawan ${karyawan.nama} sekarang menjadi karyawan non-aktif.');
  }
}

void main() {
  var produk = ProdukDigital(
      namaProduk: 'NetworkAutomation', harga: 5000000, kategori: 'Network');
  produk.terapkanDiskon(10);

  var karyawanTetap = KaryawanTetap(nama: 'Cika', umur: 30, peran: 'Manager');
  var karyawanKontrak =
      KaryawanKontrak(nama: 'Caca', umur: 25, peran: 'Developer');

  var karyawanDenganKinerja =
      KaryawanDenganKinerja(nama: 'Fifi', umur: 28, peran: 'Staff');
  karyawanDenganKinerja.bekerja();

  var proyek = Proyek(FaseProyek.Perencanaan);
  proyek.transisiFase(FaseProyek.Pengembangan);

  var perusahaan = Perusahaan();
  perusahaan.tambahKaryawan(karyawanTetap);
  perusahaan.tambahKaryawan(karyawanKontrak);
  perusahaan.resignKaryawan(karyawanKontrak);

  var karyawanPerusahaan = KaryawanPerusahaan('Arzio', umur: 29, peran: 'HR');
  karyawanPerusahaan.tampilkanInformasi();
}
