import 'BeerModel.dart';

class BeerListModel {
  List<BeerModel>? beerList;

  BeerListModel({this.beerList});

  BeerListModel.fromJson(List<dynamic> parsedJson) {
    beerList = [];
    for (var v in parsedJson) {
      beerList!.add(BeerModel.fromJson(v));
    }
  }
}
