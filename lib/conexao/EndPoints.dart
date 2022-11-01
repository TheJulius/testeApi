// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:apirequest/beer/BeerListModel.dart';
import 'package:apirequest/car/CarListModel.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:apirequest/car/CarModel.dart';

//Apenas para verificar se foi passado parametro ou não para a função
const String _noValueGiven = "";

// API url
String beers = "https://api.punkapi.com/v2/beers";
String carGet = "http://10.0.2.2/api/list";
String carPost = "http://10.0.2.2/api/store";
// Aqui usamos o package http para carregar os dados da API
// definimos o retorno para BeerListModel
Future<BeerListModel> getBeerListData() async {
  final response = await http.get(
    Uri.parse(beers),
  );
  //json.decode usado para decodificar o response.body(string to map)
  return BeerListModel.fromJson(json.decode(response.body));
}

Future<CarListModel> getCarListData([String id = _noValueGiven]) async {
  await Future.delayed(const Duration(seconds: 2), () {});
  http.Response response;
  if (identical(id, _noValueGiven)) {
    response = await http.get(
      Uri.parse(carGet),
    );
  } else {
    response = await http.get(
      Uri.parse(carGet).replace(queryParameters: {'id': id}),
    );
  }
  return CarListModel.fromJson(json.decode(response.body));
}

Future<http.Response> createPost(CarModel car, String url) async {
  print("asdf ${jsonEncode(car)}");
  final response = await http.post(Uri.parse(carPost),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: jsonEncode(car));
  print("321 ${jsonEncode(car)}");
  return response;
}

CarListModel postFromJson(String str) {
  final jsonData = json.decode(str);
  return CarListModel.fromJson(jsonData);
}

Future<CarListModel> callAPI(CarModel car) async {
  print(car.toJson());
  createPost(car, carPost).then((response) {
    print(response.body);
    if (response.statusCode == 200) {
      print("1 ${response.body}");
      return CarListModel.fromJson(json.decode(response.body));
    } else {
      print("2 ${response.statusCode}");
      return response.statusCode.toString();
    }
  }).catchError((error) {
    print('errors : $error');
    return error.toString();
  });
  throw "Erro";
}

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
