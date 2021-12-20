// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:books/book/BookListModel.dart';
import 'package:books/beer/BeerListModel.dart';
// import 'package:restSample/car/CarListModel.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:books/book/BookModel.dart';

//Apenas para verificar se foi passado parametro ou não para a função
// const String _noValueGiven = "";

// API url
Uri beers = "https://api.punkapi.com/v2/beers" as Uri;
// Uri books = "http://openlibrary.org/search.json?author=harari" as Uri;
// Uri books = Uri.http("openlibrary.org", "/search.json", {"author": "tolkien"});
// String carGet = "http://10.0.2.2/api/list";
// String carPost = "http://10.0.2.2/api/store";
// Aqui usamos o package http para carregar os dados da API
// definimos o retorno para BookListModel
Future<BookListModel> getBookListData({String author = "tolkien"}) async {
  Uri books = Uri.http("openlibrary.org", "/search.json", {"author": author});

  final response = await http.get(
    books,
  );

  //json.decode usado para decodificar o response.body(string to map)
  return BookListModel.fromJson(json.decode("[" + response.body + "]"));
}

Future<BeerListModel> getBeerListData() async {
  final response = await http.get(
    beers,
  );
  //json.decode usado para decodificar o response.body(string to map)
  return BeerListModel.fromJson(json.decode(response.body));
}

// Future<CarListModel> getCarListData([String id = _noValueGiven]) async {
//   await Future.delayed(const Duration(seconds: 2), () {});
//   var response;
//   if (identical(id, _noValueGiven)) {
//     response = await http.get(
//       carGet,
//     );
//   } else {
//     response = await http.get(
//       carGet + "?id=" + id,
//     );
//   }
//   //json.decode usado para decodificar o response.body(string to map)
//   return CarListModel.fromJson(json.decode(response.body));
// }

Future<http.Response> createBook(BookModel book) async {
  Uri bookPost = Uri.http("127.0.0.1", "/www/optativa-III-books/store.php");

  final response = await http.post(bookPost,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '*',
      },
      body: jsonEncode(book));

  return response;
}

// CarListModel postFromJson(String str) {
//   final jsonData = json.decode(str);
//   return CarListModel.fromJson(jsonData);
// }

// Future<CarListModel> callAPI(CarModel car) async {
//   //CarModel car = CarModel(id: "15", model: "teste", price: 17.0);
//   print(car.toJson());
//   //CarListModel.fromJson(json.decode(response.body));
//   createPost(car, carPost).then((response) {
//     print(response.body);
//     if (response.statusCode == 200) {
//       print("1 " + response.body);
//       print("gfff " +
//           CarListModel.fromJson(json.decode(response.body))
//               .carList
//               .first
//               .model);
//       return CarListModel.fromJson(json.decode(response.body));
//     } else {
//       print("2 " + response.statusCode.toString());
//       return null;
//     }
//   }).catchError((error) {
//     print('errors : $error');
//     return error;
//   });
// }

/*Future<CarListModel> postCar(int idd, String modell, double pricee) async {
  CarModel car = new CarModel(id: idd, model: modell, price: pricee);
  final response = await http.post(carPost, body: json.encode([car.toJson()]));
  print("3 " + response.toString());
  return CarListModel.fromJson(json.decode(response.body));
}*/

// método para definir se há conexão com a internet
Future<bool> isConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

Widget loadingView() {
  return const Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.red,
    ),
  );
}

Widget noDataView(String msg) => Center(
      child: Text(
        msg,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
      ),
    );
