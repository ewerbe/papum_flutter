import 'package:papum/database/freteDAO.dart';
import 'package:papum/model/frete.dart';
import 'package:papum/screens/android/freteiro/freteiro_list.dart';
import 'package:papum/service/frete_service.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FreteOrcado extends StatelessWidget {
  //const ChecklistSintomasResultados({Key? key}) : super(key: key);

  late Frete _frete;
  late int _precoFinal;

  frete_orcado(this._frete){
    this._precoFinal = FreteService().calculaOrcamento(this._frete);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RESULTADO'),
        ),
        body: Column(
          children: [
            Text(this._precoFinal.toString()+' reais', style: TextStyle(
              fontSize: 20,
            ),),
            _registrarBtn(context)
          ],
        )
    );
  }

  Widget _registrarBtn(BuildContext context){

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              child: Text('REGISTRAR'),
              onPressed: (){
                FreteDAO.adicionar(this._frete);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => FreteiroList())
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 10
              )
          ),
          ElevatedButton(
              child: Text('DESCARTAR'),
              onPressed: (){
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  elevation: 10,
                  primary: Colors.orange
              )
          )
        ],
      ),
    );
  }

}
