class TransactionModel {
  String? transaksiid;
  String? noTransaksi;
  String? transactionDate;
  String? status;
  String? loaningTotal;
  String? userid;
  List<String>? bookIds;

  TransactionModel(
      {this.transaksiid,
      this.noTransaksi,
      this.transactionDate,
      this.status,
      this.loaningTotal,
      this.userid,
      this.bookIds});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    transaksiid = json['transaksiid'];
    noTransaksi = json['no_transaksi'];
    transactionDate = json['transaction_date'];
    status = json['status'];
    loaningTotal = json['loaning_total'];
    userid = json['userid'];
    bookIds = json['book_ids'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['transaksiid'] = transaksiid;
    data['no_transaksi'] = noTransaksi;
    data['transaction_date'] = transactionDate;
    data['status'] = status;
    data['loaning_total'] = loaningTotal;
    data['userid'] = userid;
    data['book_ids'] = bookIds;
    return data;
  }
}
