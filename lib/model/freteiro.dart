class Freteiro{

  int _id;
  String _nome;
  String _whatsapp;
  String _placa;
  int _idade;
  String _senha;
  String _foto;

  Freteiro(this._id, this._nome, this._whatsapp, this._placa, this._idade,
      this._senha, this._foto);

  Map<String, dynamic> toMap(){
    return {
      //'id': _id,
      'nome': _nome,
      'whatsapp': _whatsapp,
      'placa': _placa,
      'idade': _idade,
      'senha': _senha,
      'foto': _foto
    };
  }
  set id(int i){
    this._id = i;
  }
  int get id{
    return this._id;
  }

  String get nome{
    return this._nome;
  }


  String get whatsapp => _whatsapp;


  String get placa{
    return this._placa;
  }

  int get idade{
    return this._idade;
  }

  String get senha{
    return this._senha;
  }

  String get foto{
    return this._foto;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Freteiro(id: $id, nome: $nome, whatsapp: $whatsapp)';
  }
}