
import 'package:papum/model/frete.dart';
import 'package:papum/model/freteiro.dart';
import 'package:papum/service/frete_service.dart';
import 'package:sqflite/sqflite.dart';

import 'openDatabaseDB.dart';


class FreteDAO{

  static const String _nomeTabela = 'frete';
  static const String _col_id = 'id_frete';
  static const String _col_idfreteiro = 'idfreteiro';
  static const String _col_isOutraCidade = 'outracidade';
  static const String _col_isForaEstado = 'foraestado';
  static const String _col_maisDoisCarregadores = 'maisdoiscarregadores';
  static const String _col_maisUmCarregador = 'maisumcarregador';
  static const String _col_embalagensProntas= 'embalagensprontas';
  static const String _col_dataOrcamento = 'dataorcamento';
  static const String _col_precoFinal = 'precofinal';

  static const String sqlTabela = 'CREATE TABLE $_nomeTabela ('
      '$_col_id INTEGER PRIMARY KEY, '
      '$_col_idfreteiro INTEGER, '
      '$_col_isOutraCidade INTEGER, '
      '$_col_isForaEstado INTEGER, '
      '$_col_maisDoisCarregadores INTEGER, '
      '_$_col_maisUmCarregador INTEGER, '
      '$_col_embalagensProntas INTEGER, '
      '$_col_dataOrcamento TEXT, '
      '$_col_precoFinal INTEGER, '
      'FOREIGN KEY ($_col_idfreteiro) REFERENCES freteiro(id))';



  static adicionar(Frete frete) async{

    frete.precoFinal = FreteService().calculaOrcamento(frete);

    final Database db = await getDatabase();
    db.insert(_nomeTabela, frete.toMap());

    //_checkSintomasPaciente.add(cs);
  }


  static const String _nomeTabelaFreteiro = 'freteiro';
  static const String _col_idF = 'id';
  static const String _col_nome = 'nome';
  static const String _col_whatsapp = 'whatsapp';
  static const String _col_idade = 'idade';
  static const String _col_placa = 'placa';
  static const String _col_senha = 'senha';
  static const String _col_foto = 'foto';


  Future<List<Frete>> getFreteiroFrete(Freteiro f) async {

    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps =
    await db.rawQuery('SELECT * FROM $_nomeTabela cs, $_nomeTabelaFreteiro f '
        'WHERE cs.idfreteiro = f.id AND f.id = '+f.id.toString());

    return List.generate(maps.length, (i) {

      Freteiro freteiro = Freteiro(
        maps[i][_col_idF],
        maps[i][_col_nome],
        maps[i][_col_whatsapp],
        maps[i][_col_placa],
        maps[i][_col_idade],
        maps[i][_col_senha],
        maps[i][_col_foto],
      );


      Frete frete = Frete(
          maps[i][_col_idF],
          freteiro,
          maps[i][_col_isOutraCidade] == 1? true : false,
          maps[i][_col_isForaEstado] == 1? true : false,
          maps[i][_col_maisDoisCarregadores] == 1? true : false,
          maps[i][_col_maisUmCarregador] == 1? true : false,
          maps[i][_col_embalagensProntas] == 1? true : false,
          DateTime.parse(maps[i][_col_dataOrcamento])
      );
      frete.precoFinal = maps[i][_col_precoFinal];
      return frete;
    });
  }

}