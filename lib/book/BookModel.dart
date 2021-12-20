// ignore_for_file: file_names

class BookModel {
  late String title;
  late String url;
  late String author;
  late num? publishYear;
  late num? numberPages;

  BookModel({
    required this.title,
    required this.url,
    required this.author,
    required this.publishYear,
    required this.numberPages,
  });

  BookModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['key'];
    author = json['author_name'][0];
    publishYear = json['first_publish_year'];
    numberPages = json['number_of_pages_median'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['url'] = url;
    data['author'] = author;
    data['publishYear'] = publishYear;
    data['numberPages'] = numberPages;

    return data;
  }
}
