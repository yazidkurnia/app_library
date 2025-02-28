class BookModel {
  String? bookid;
  String? title;
  String? deskripsi;
  String? categoryId;
  String? imgUrl;

  BookModel(
      {this.bookid, this.title, this.deskripsi, this.categoryId, this.imgUrl});

  BookModel.fromJson(Map<String, dynamic> json) {
    bookid = json['bookid'];
    title = json['title'];
    deskripsi = json['deskripsi'];
    categoryId = json['category_id'];
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookid'] = this.bookid;
    data['title'] = this.title;
    data['deskripsi'] = this.deskripsi;
    data['category_id'] = this.categoryId;
    data['img_url'] = this.imgUrl;
    return data;
  }
}
