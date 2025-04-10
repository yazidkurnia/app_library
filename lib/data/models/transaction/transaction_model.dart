import '../../../domain/entities/transaction_entity.dart';

class TransactionModel {
  String? transaksiid;
  String? noTransaksi;
  String? transactionDate;
  String? status;
  String? loaningTotal;
  String? userid;
  List<String>? bookIds;
  String? loanerName;

  TransactionModel(
      {this.transaksiid,
      this.noTransaksi,
      this.transactionDate,
      this.status,
      this.loaningTotal,
      this.userid,
      this.bookIds,
      this.loanerName});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        transaksiid: json['transaksiid'],
        noTransaksi: json['no_transaksi'],
        transactionDate: json['transaction_date'],
        status: json['status'],
        loaningTotal: json['loaning_total'],
        userid: json['userid'],
        bookIds: List<String>.from(
            json['book_ids'] ?? []), // Konversi dan tangani null
        loanerName: json['user_name']);
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
    data['user_name'] = loanerName;
    return data;
  }

  TransactionEntity transactionEntity() {
    return TransactionEntity(
        transaksiid: transaksiid,
        noTransaksi: noTransaksi,
        transactionDate: transactionDate,
        status: status,
        loaningTotal: loaningTotal,
        userid: userid,
        bookIds: bookIds,
        loanerName: loanerName);
  }
}
