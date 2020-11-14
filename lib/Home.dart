import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textEditingController = TextEditingController();
  String _infos = "";

  _recuperarCep(_cep) async {
    String _apiViaCep = "https://viacep.com.br/ws/$_cep/json/";
    http.Response response;
    response = await http.get(_apiViaCep);
    Map<String, dynamic> retorno = json.decode(response.body);

    String localidade = retorno["localidade"];

    // print(response.statusCode.toString());
    //   print(response.body);
    // print(retorno);
    //print(localidade);

    setState(() {
      _infos = "Logradouro: " +
          retorno["logradouro"].toString() +
          "\nLocalidade: " +
          retorno["localidade"].toString() +
          "\nUf: " +
          retorno["uf"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Cabeçalho
      appBar: AppBar(
        title: Text("Consumo de API"),
        backgroundColor: Color(0xff546e7a),
      ),
      //Corpo
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Exemplo: 01001000"
                ),
                controller: textEditingController,
              ),
            ),

            RaisedButton(
              child: Text("Buscar",style: TextStyle(color: Colors.white),),
              onPressed: () => {_recuperarCep(textEditingController.text)},
              color: Colors.blue,

            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(_infos),
            )
          ]),
        ),
      ),
    );
  }
}
