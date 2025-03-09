// lib/data/models/book/book_model.dart
import '../../../domain/entities/book_entity.dart';

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

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['bookid'] = bookid;
  //   data['title'] = title;
  //   data['deskripsi'] = deskripsi;
  //   data['category_id'] = categoryId;
  //   data['img_url'] = imgUrl;
  //   return data;
  // }

  BookEntity bookEntity() {
    return BookEntity(
      bookId: bookid,
      title: title,
      description: deskripsi,
      categoryId: categoryId,
      imageUrl: imgUrl,
    );
  }
}
