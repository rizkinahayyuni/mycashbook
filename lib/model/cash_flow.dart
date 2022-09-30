class CashFlow {
  int? id;
  String? tgl;
  int? cash;
  String? jenis;
  String? keterangan;

  CashFlow({this.id, this.tgl, this.cash, this.jenis, this.keterangan});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['tgl'] = tgl;
    map['cash'] = cash;
    map['jenis'] = jenis;
    map['keterangan'] = keterangan;

    return map;
  }

  CashFlow.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.tgl = map['tgl'];
    this.cash = map['cash'];
    this.jenis = map['jenis'];
    this.keterangan = map['keterangan'];
  }
}
