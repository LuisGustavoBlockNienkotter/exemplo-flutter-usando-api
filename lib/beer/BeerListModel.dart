// ignore_for_file: deprecated_member_use, avoid_function_literals_in_foreach_calls, file_names

import 'BeerModel.dart';

class BeerListModel {
  List<BeerModel> beerList = <BeerModel>[];

  BeerListModel({required this.beerList});

  BeerListModel.fromJson(List<dynamic> parsedJson) {
    beerList = <BeerModel>[];
    parsedJson.forEach((v) {
      beerList.add(BeerModel.fromJson(v));
    });
  }
}
