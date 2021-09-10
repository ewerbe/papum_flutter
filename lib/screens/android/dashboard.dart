import 'package:papum/screens/android/login.dart';
import 'package:flutter/material.dart';

import 'freteiro/freteiro_list.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DASHBOARD'),
          actions: <Widget> [
            InkWell(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Login()
                ));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0, left: 25),
                child: Icon(Icons.exit_to_app),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                _msgSuperiorTXT(),
                _imgCentral(),
                Container(
                  //color: Colors.green,
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      _ItemElemento('FRETEIROS', Icons.accessibility_new,
                        onClick:  (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FreteiroList()
                          ));

                        },
                      ),
                      _ItemElemento('ORÇAMENTOS', Icons.check_circle_outline, onClick: (){
                        debugPrint('ORÇAMENTOS ....');
                      },
                      ),
                    ],
                  ),
                )
              ]
          ),
        )
    );
  }

  Widget _msgSuperiorTXT(){
    return Container(
      alignment: Alignment.topRight,
      padding: const EdgeInsets.all(10.0),
      child: Text('PAPUM Mudanças'),
    );
  }

  Widget _imgCentral(){
    return Image.asset('imagens/logo-PAPUM.png');
  }
}


class _ItemElemento extends StatelessWidget {

  final String titulo;
  final IconData icone;
  final VoidCallback onClick;       //para aceitar parametro nulo, se for preciso

  _ItemElemento(this.titulo, this.icone, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        elevation: 10.0,
        child: InkWell(
          onTap: this.onClick,
          child: Container(
            // color: Colors.green,
            width: 150,
            height: 80,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(this.icone,
                  color: Colors.white,
                ),
                Text(this.titulo, style: TextStyle(
                    color: Colors.white, fontSize: 16
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}