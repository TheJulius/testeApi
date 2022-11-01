import 'package:flutter/material.dart';
import 'package:apirequest/car/CarModel.dart';
import 'package:apirequest/car/CarListModel.dart';
import 'package:apirequest/conexao/EndPoints.dart';

class PostCar extends StatefulWidget {
  const PostCar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PostCar createState() => _PostCar();
}

class _PostCar extends State {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  CarModel car = CarModel();
  Future<CarListModel>? carListFuture;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                keyboardType: TextInputType.number,
                onSaved: (String? inValue) {
                  car.id = int.parse(inValue!);
                },
                decoration: const InputDecoration(labelText: "Id")),
            TextFormField(
                keyboardType: TextInputType.text,
                validator: (String? inValue) {
                  if (inValue!.isEmpty) {
                    return "Por favor entre com o modelo";
                  }
                  return null;
                },
                onSaved: (String? inValue) {
                  car.model = inValue!;
                },
                decoration: const InputDecoration(labelText: "Model")),
            TextFormField(
                keyboardType: TextInputType.number,
                onSaved: (String? inValue) {
                  this.car.price = double.parse(inValue!);
                },
                decoration: const InputDecoration(labelText: "Price")),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print("Model: ${car.model}");
                  print("Price: ${car.price}");
                  callAPI(car);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
