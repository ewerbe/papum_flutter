import 'dart:io';

import 'package:papum/database/freteiroDAO.dart';
import 'package:papum/model/freteiro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class FreteiroScreen extends StatefulWidget {

  var index;
  late Freteiro freteiro;
  FreteiroScreen({ Freteiro? freteiro }){

    if(freteiro == null){
      this.index = -1;
    }else{
      this.index = freteiro.id;
      this.freteiro = freteiro;
    }

  }


  @override
  _FreteiroScreenState createState() => _FreteiroScreenState();
}

class _FreteiroScreenState extends State<FreteiroScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  late Freteiro _freteiro;
  bool _isUpdate = false;

  @override
  Widget build(BuildContext context) {

    if(widget.index >= 0 && this._isUpdate == false){
      debugPrint('Editar um freteiro com index = '+widget.index.toString());

      this._freteiro = widget.freteiro;
      this._fotoPerfil = this._freteiro.foto;
      this._nomeController.text = this._freteiro.nome;
      this._whatsappController.text = this._freteiro.whatsapp;
      this._placaController.text = this._freteiro.placa;
      this._idadeController.text = this._freteiro.idade.toString();
      this._senhaController.text = this._freteiro.senha;

      this._isUpdate = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ADD FRETEIRO'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                _fotoAvatar(context),

                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'campo obrigatório';
                    }
                    return null;
                  },
                  controller: this._nomeController,
                  decoration: InputDecoration(
                      labelText: 'Nome'
                  ),
                  style: TextStyle(
                      fontSize: 24
                  ),
                ),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'campo obrigatório';
                    }
                    return null;
                  },
                  controller: this._whatsappController,
                  decoration: InputDecoration(
                      labelText: 'Whatsapp'
                  ),
                  style: TextStyle(
                      fontSize: 24
                  ),
                ),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'campo obrigatório';
                    }
                    return null;
                  },
                  controller: this._placaController,
                  decoration: InputDecoration(
                      labelText: 'Placa'
                  ),
                  style: TextStyle(
                      fontSize: 24
                  ),
                ),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'campo obrigatório';
                    }
                    return null;
                  },
                  controller: this._idadeController,
                  decoration: InputDecoration(
                      labelText: 'Idade'
                  ),
                  style: TextStyle(
                      fontSize: 24
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'campo obrigatório';
                    }
                    return null;
                  },
                  controller: this._senhaController,
                  decoration: InputDecoration(
                      labelText: 'Senha'
                  ),
                  style: TextStyle(
                      fontSize: 24
                  ),
                  obscureText: true,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  height: 100,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                      ),
                      onPressed: (){
                        if(_formkey.currentState!.validate()){
                          debugPrint('nome: '+this._nomeController.text);
                          debugPrint('whatsapp: '+this._whatsappController.text);

                          Freteiro f =
                          new Freteiro(
                              widget.index, this._nomeController.text,
                              this._whatsappController.text,
                              this._placaController.text,
                              int.parse(this._idadeController.text),
                              this._senhaController.text,
                              this._fotoPerfil
                          );

                          if(widget.index >= 0){
                            FreteiroDAO().atualizar(f);
                            Navigator.of(context).pop();
                          }else{
                            FreteiroDAO().adicionar(f);
                            Navigator.of(context).pop();
                          }


                        }else{
                          debugPrint('formulário inválido');
                        }

                      },
                      child: Text('SALVAR', style: TextStyle(
                          color: Colors.white
                      ),)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fotoAvatar(BuildContext context){

    return InkWell(
      onTap: (){
        alertTirarFoto(context);
        debugPrint('tirar foto...');
      },
      child: CircleAvatar(
          backgroundImage: AssetImage('imagens/camera_icon.png'),
          backgroundColor: Colors.white,
          radius: 80,
          child: ClipOval(
              child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.file(File(this._fotoPerfil))
              )
          )
      ),
    );

  }

  alertTirarFoto(BuildContext context){
    AlertDialog alert = AlertDialog(
      title: Text('Tirar foto?', style: TextStyle(
          fontWeight: FontWeight.bold
      ),
      ),
      content: Text('Escolha entre câmera ou galeria para a sua foto de perfil'),
      elevation: 5.0,
      actions: [
        TextButton(
            child: Text('Câmera'),
            onPressed: (){
              debugPrint('usuário escolheu Câmera');
              _obterImagem(ImageSource.camera);
            }),
        TextButton(
            child: Text('Galeria'),
            onPressed: (){
              debugPrint('usuário escolheu galeria');
              _obterImagem(ImageSource.gallery);
            })
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context){
          return alert;
        }
    );
  }

  String _fotoPerfil = '';

  _obterImagem(ImageSource source) async{

    final imagem = await ImagePicker().pickImage(source: source);
    if(imagem != null){
      File? cropped = await ImageCropper.cropImage(
          sourcePath: imagem.path,
          aspectRatio: CropAspectRatio(ratioY: 1, ratioX: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.white,
              toolbarTitle: 'CORTAR IMAGEM',
              statusBarColor: Colors.blue,
              backgroundColor: Colors.white
          )
      );

      setState(() {
        this._fotoPerfil = cropped!.path;
      });
    }

    debugPrint('Imagem -> '+imagem!.path);

  }
}
