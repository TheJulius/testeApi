class CarModel {
  String? model;
  // ignore: prefer_typing_uninitialized_variables
  var price;
  int? id;

  CarModel({this.model, this.price, this.id});

  CarModel.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    price = json['price'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['model'] = model;
    data['price'] = price;
    return data;
  }
}
