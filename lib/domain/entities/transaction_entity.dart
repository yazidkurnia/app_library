class TransactionEntity {
  String? transaksiid;
  String? noTransaksi;
  String? transactionDate;
  String? status;
  String? loaningTotal;
  String? userid;
  List<String>? bookIds;
  String? loanerName;

  TransactionEntity(
      {this.transaksiid,
      this.noTransaksi,
      this.transactionDate,
      this.status,
      this.loaningTotal,
      this.userid,
      this.bookIds,
      this.loanerName});
}
