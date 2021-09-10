import 'freteiro.dart';

class Frete {

  int _id;
  Freteiro _freteiro;
  bool _isOutraCidade;
  bool _isForaEstado;
  bool _maisDoisCarregadores;
  bool _maisUmCarregador;
  bool _embalagensProntas;
  DateTime _dataOrcamento;
  late int _precoFinal;


  Frete(
      this._id,
      this._freteiro,
      this._isOutraCidade,
      this._isForaEstado,
      this._maisDoisCarregadores,
      this._maisUmCarregador,
      this._embalagensProntas,
      this._dataOrcamento);


  Map<String, dynamic> toMap(){
    return {
      //serial id
      'idfreteiro': _freteiro.id,
      'outracidade': _isOutraCidade == true? 1 : 0,
      'foraestado': _isForaEstado == true? 1 : 0,
      'doiscarregadores': _maisDoisCarregadores == true? 1 : 0,
      'dorgarganta': _maisUmCarregador == true? 1 : 0,
      'narizentupido': _embalagensProntas == true? 1 : 0,
      'dataorcamento': _dataOrcamento.toIso8601String(),
      '_precoFinal': _precoFinal
    };
  }


  int get precoFinal => _precoFinal;

  set precoFinal(int value) {
    _precoFinal = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  DateTime get dataOrcamento => _dataOrcamento;


  bool get isOutraCidade => _isOutraCidade;

  Freteiro get freteiro => _freteiro;

  bool get isForaEstado => _isForaEstado;

  bool get maisDoisCarregadores => _maisDoisCarregadores;

  bool get maisUmCarregador => _maisUmCarregador;

  bool get embalagensProntas => _embalagensProntas;
}