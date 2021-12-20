// ignore_for_file: deprecated_member_use, file_names

import 'BookModel.dart';

class BookListModel {
  List<BookModel> bookList = <BookModel>[];

  BookListModel({required this.bookList});

  BookListModel.fromJson(List<dynamic> parsedJson) {
    bookList = <BookModel>[];

    for (var books in parsedJson) {
      // print(books);
      for (var book in books['docs']) {
        bookList.add(BookModel.fromJson(book));
      }
    }
  }
}
