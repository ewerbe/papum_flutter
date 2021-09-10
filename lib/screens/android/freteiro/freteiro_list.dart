import 'dart:io';
import 'package:papum/database/freteDAO.dart';
import 'package:papum/database/freteiroDAO.dart';
import 'package:papum/model/frete.dart';
import 'package:papum/model/freteiro.dart';
import 'package:papum/screens/android/frete/frete_orcamento.dart';
import 'package:papum/screens/android/freteiro/freteiro_add.dart';
import 'package:flutter/material.dart';

class FreteiroList extends StatefulWidget {
  @override
  _FreteiroListState createState() => _FreteiroListState();
}

class _FreteiroListState extends State<FreteiroList> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('FRETEIROS'),
      ),
      body: Column(
        children: <Widget> [
          Container(
            child: TextField(
              style: TextStyle(fontSize: 25),
              decoration: InputDecoration(
                labelText: 'pesquisar',
                hintText: 'pesquisar freteiro',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Container(
                child: _futureBuilderPaciente()
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FreteiroScreen()
          )).then((value) {
            setState(() {
              debugPrint('retornou do add paciente...');
            });
          });

        },
        child: Icon(Icons.add),
      ),
    );
  }


  Widget _futureBuilderPaciente(){
    return FutureBuilder<List<Freteiro>>(
        initialData: [],
        future: FreteiroDAO().getFreteiros(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text('Carregando')
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Freteiro>? freteiros = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index){
                  final Freteiro f = freteiros![index];
                  return ItemFreteiro(f, onClick: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=> FreteiroScreen(freteiro: f, onClic))
                    ).then((value) {
                      setState((){
                        debugPrint('...voltou do editar');
                      });
                    });
                  },);
                },
                itemCount: freteiros!.length,
              );
          }
          return Text('Problemas em gerar a lista de freteiros');
        }
    );
  }

}



class ItemFreteiro extends StatelessWidget {

  late final Freteiro _freteiro;
  late final Function onClick;

  ItemFreteiro(this._freteiro, this.onClick);

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => this.onClick(),
          leading: _avatarFotoPerfil(),
          title: Text(this._freteiro.nome,
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          subtitle: Text(this._freteiro.whatsapp, style: TextStyle(
            fontSize: 20,
          ),
          ),
          trailing: _menu(context),
        ),
        Divider(
          color: Colors.blueGrey,
          indent: 70.0,
          endIndent: 20.0,
        )
      ],
    );
  }

  Widget _menu(BuildContext context){
    return PopupMenuButton(
        onSelected: (ItensMenuListFreteiro selecionado){

          debugPrint('secionado: $selecionado');
          if(selecionado == ItensMenuListFreteiro.novo_orcamento){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FreteOrcamento()
            ));
          }else{

            FreteDAO().getFreteiroFrete(this._freteiro)
                .then((itensOrcamento){

              if(itensOrcamento.length > 0){

                for(Frete fr in itensOrcamento){
                  print(fr);
                }

              }else{
                print('NENHUM REGISTRO ENCONTRADO');
              }

            });
          }

        },
        itemBuilder: (BuildContext context) => <PopupMenuItem<ItensMenuListFreteiro>>[
          const PopupMenuItem(
            value: ItensMenuListFreteiro.fretes_orcados,
            child: Text('Fretes orçados'),
          ),
          const PopupMenuItem(
            value: ItensMenuListFreteiro.novo_orcamento,
            child: Text('Novo Orçamento'),
          ),
        ]

    );
  }

}

enum ItensMenuListFreteiro{ fretes_orcados, novo_orcamento }