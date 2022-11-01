import 'CarModel.dart';

class CarListModel {
  List<CarModel>? carList;

  CarListModel({this.carList});

  CarListModel.fromJson(List<dynamic>? parsedJson) {
    carList = [];
    for (var v in parsedJson!) {
      carList!.add(CarModel.fromJson(v));
    }
  }
}
