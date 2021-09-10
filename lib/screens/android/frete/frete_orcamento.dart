import 'dart:io';
import 'package:papum/database/freteDAO.dart';
import 'package:papum/database/freteiroDAO.dart';
import 'package:papum/model/frete.dart';
import 'package:papum/model/frete.dart';
import 'package:papum/model/freteiro.dart';
import 'package:papum/screens/android/frete/frete_orcado.dart';
import 'package:flutter/material.dart';

class FreteOrcamento extends StatelessWidget {


  late Freteiro _freteiro;

  final _formKeys = GlobalKey<FormState>();


  Frete({Freteiro? freteiro}){
    this._freteiro = freteiro!;
     _isOutraCidade = false;
     _isForaEstado = false;
     _maisDoisCarregadores = false;
     _maisUmCarregador = false;
     _embalagensProntas = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ORÇAR FRETE '+this._freteiro.nome),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: this._formKeys,
              child: Column(
                children: [
                  _freteiroAvatar(),
                  Frete(),
                  _registrarBtn(context)
                ],
              ),
            ),
          ),
        )
    );
  }


  Widget _registrarBtn(BuildContext context){
    return Container(
      padding: EdgeInsets.all(10),
      height: 100,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30)),
                elevation: 10
            ),
            onPressed: (){
              if(this._formKeys.currentState!.validate()){
                debugPrint('registrar...');
                debugPrint('freteiro '+this._freteiro.nome);


                Frete frete = Frete(0, this._freteiro,
                    _isOutraCidade, _isForaEstado, _maisDoisCarregadores, _maisUmCarregador,
                    _embalagensProntas, DateTime.now());

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => frete_orcado(frete)
                ));


              }else{
                debugPrint('formulário Inválido');
              }
            },
            child: Text('REGISTRAR', style: TextStyle(
                fontSize: 26
            ),)),
      ),
    );
  }




  Widget _freteiroAvatar(){
    return Column(
      children: [
        ListTile(
          leading: _avatarFotoPerfil(),
          title: Text(this._freteiro.nome.toUpperCase(),
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          subtitle: Text(this._freteiro.whatsapp, style: TextStyle(
              fontSize: 20
          ),),
        ),
        Divider(
          endIndent: 20,
          indent: 70,
          thickness: 1,
          height: 0,
        )
      ],
    );
  }

  Widget _avatarFotoPerfil(){

    var inicialNome = this._freteiro.nome[0].toUpperCase();
    if(this._freteiro.foto.length>0){
      inicialNome = '';
    }

    return CircleAvatar(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
      backgroundImage: FileImage(File(this._freteiro.foto)),
      radius: 22,
      child: Text(inicialNome,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0
        ),
      ),
    );
  }

}


class CheckItensFrete extends StatefulWidget {
  const CheckItensFrete({Key? key}) : super(key: key);

  @override
  CheckItensFreteState createState() => CheckItensFreteState();
}


bool _isOutraCidade = false;
bool _isForaEstado = false;
bool _maisDoisCarregadores = false;
bool _maisUmCarregador = false;
bool _embalagensProntas = false;

class CheckItensFreteState extends State<CheckItensFrete> {
  bool valor = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _CheckItem(label: 'Outra cidade', valor: _isOutraCidade, onChanged: (){
            setState(() {
              _isOutraCidade = !_isOutraCidade;
            });
          }),
          _CheckItem(label: 'Fora do estado', valor: _isForaEstado, onChanged: (){
            setState(() {
              _isForaEstado = !_isForaEstado;
            });
          }),
          _CheckItem(label: 'Mais 2 carregadores', valor: _maisDoisCarregadores, onChanged: (){
            setState(() {
              _maisDoisCarregadores = !_maisDoisCarregadores;
            });
          }),
          _CheckItem(label: 'Mais 1 carregador', valor: _maisUmCarregador, onChanged: (){
            setState(() {
              _maisUmCarregador = !_maisUmCarregador;
            });
          }),
          _CheckItem(label: 'Embalagens prontas', valor: _embalagensProntas, onChanged: (){
            setState(() {
              _embalagensProntas = !_embalagensProntas;
            });
          })
        ],
      ),
    );
  }


  Widget _CheckItem({required String label, required bool valor, required Function onChanged}){
    return InkWell(
      onTap: (){
        onChanged();
      },
      child: Row(
        children: [
          Checkbox(
            onChanged: (bool? novoValor) {},
            value: valor,
            checkColor: Colors.green,
            activeColor: Colors.white,
          ),
          Text(label, style: TextStyle(fontSize: 23))
        ],
      ),
    );
  }
}

