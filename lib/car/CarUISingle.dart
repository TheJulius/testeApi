import 'package:flutter/material.dart';
import 'package:apirequest/car/CarModel.dart';
import 'package:apirequest/car/CarListModel.dart';
import 'package:apirequest/conexao/EndPoints.dart';

class CarUISingle extends StatefulWidget {
  const CarUISingle({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CarUISingle createState() => _CarUISingle();
}

class _CarUISingle extends State {
  Future<CarListModel>? carListFuture;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<CarListModel>(
          future: carListFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // Com switch conseguimos identificar em que ponto da conexão estamos
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                {
                  return loadingView();
                }
              case ConnectionState.active:
                {
                  break;
                }
              case ConnectionState.done:
                {
                  // Se o estado é de finalizado, será trabalhado os dados do snapshot recebido
                  // snapshot representa um instantâneo (foto) dos dados recebidos
                  // Se o snapshot tem informações, apresenta
                  if (snapshot.hasData) {
                    if (snapshot.data!.carList != null) {
                      if (snapshot.data!.carList!.length > 0) {
                        // preenche a lista
                        return ListView.builder(
                            itemCount: snapshot.data!.carList!.length,
                            itemBuilder: (context, index) {
                              return generateColum(
                                  snapshot.data!.carList![index]);
                            });
                      } else {
                        // Em caso de retorno de lista vazia
                        return noDataView("1 No data found");
                      }
                    } else {
                      // Apresenta erro se a lista ou os dados são nulos
                      return noDataView("2 No data found");
                    }
                  } else if (snapshot.hasError) {
                    // Apresenta mensagem se teve algum erro
                    return noDataView(
                        "1 cars Something went wrong: ${snapshot.error}");
                  } else {
                    return noDataView("2 Something went wrong");
                  }
                }
              case ConnectionState.none:
                {
                  break;
                }
            }
            throw "Error";
          }),
    );
  }

  @override
  void initState() {
    // Verificamos a conexão com a internet
    isConnected().then((internet) {
      if (internet) {
        // define o estado enquanto carrega as informações da API
        setState(() {
          // chama a API para apresentar os dados
          // Aqui estamos no initState (ao iniciar a aplicação/tela), mas pode ser iniciado com um click de botão.
          carListFuture = getCarListData(5.toString());
        });
      }
    });
    super.initState();
  }

  Widget generateColum(CarModel item) => Card(
        child: ListTile(
          title: Text(
            item.model!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(item.id.toString(),
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      );
}
