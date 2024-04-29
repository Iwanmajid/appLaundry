class ModelTransaksi {
  String? id;
  String? nama;
  String? noHp;
  String? alamat;
  String? status;
  String? tanggalMasuk;
  String? tanggalAmbil;
  String? cucian;
  String? berat;
  String? harga;
  String? totalHarga;
  String? cucianId;

  ModelTransaksi.empty();

  ModelTransaksi(
      {this.id,
      this.nama,
      this.noHp,
      this.alamat,
      this.status,
      this.tanggalMasuk,
      this.tanggalAmbil,
      this.cucian,
      this.berat,
      this.harga,
      this.totalHarga,
      this.cucianId});

  ModelTransaksi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    noHp = json['no_hp'];
    alamat = json['alamat'];
    status = json['status'];
    tanggalMasuk = json['tanggal_masuk'];
    tanggalAmbil = json['tanggal_ambil'];
    cucian = json['cucian'];
    berat = json['berat'];
    harga = json['harga'];
    totalHarga = json['total_harga'];
    cucianId = json['cucian_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['no_hp'] = this.noHp;
    data['alamat'] = this.alamat;
    data['status'] = this.status;
    data['tanggal_masuk'] = this.tanggalMasuk;
    data['tanggal_ambil'] = this.tanggalAmbil;
    data['cucian'] = this.cucian;
    data['berat'] = this.berat;
    data['harga'] = this.harga;
    data['total_harga'] = this.totalHarga;
    data['cucian_id'] = this.cucianId;
    return data;
  }
}
