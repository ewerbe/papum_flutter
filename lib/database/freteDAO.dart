import 'package:papum/database/openDatabaseDB.dart';
import 'package:papum/model/frete.dart';
import 'package:papum/model/freteiro.dart';
import 'package:papum/screens/android/frete/frete_orcamento.dart';
import 'package:papum/service/frete_service.dart';
import 'package:sqflite/sqflite.dart';


class CheckSintomasDAO{

  static const String _nomeTabela = 'checksintomas';
  static const String _col_id = 'id_cs';
  static const String _col_idpaciente = 'idpaciente';
  static const String _col_temperatura = 'temperatura';
  static const String _col_qtdDias = 'qtdiassintomas';
  static const String _col_isTosse = 'tosse';
  static const String _col_isCatarro = 'catarro';
  static const String _col_isRouquidao = 'rouquidao';
  static const String _col_isDorGarganta = 'dorgarganta';
  static const String _col_isNarizEntupido = 'narizentupido';
  static const String _col_dataAvaliavao = 'dataavaliacao';
  static const String _col_isCasoSuspeito = 'casosuspeito';


  static const String sqlTabela = 'CREATE TABLE $_nomeTabela ('
      '$_col_id INTEGER PRIMARY KEY, '
      '$_col_idpaciente INTEGER, '
      '$_col_temperatura INTEGER, '
      '$_col_qtdDias INTEGER, '
      '$_col_isTosse INTEGER, '
      '_$_col_isCatarro INTEGER, '
      '$_col_isRouquidao INTEGER, '
      '$_col_isDorGarganta INTEGER, '
      '$_col_isNarizEntupido INTEGER, '
      '$_col_dataAvaliavao TEXT, '
      '$_col_isCasoSuspeito INTEGER, '
      'FOREIGN KEY ($_col_idpaciente) REFERENCES paciente(id))';

  //static final List<CheckSintomasModel> _checkSintomasPaciente = [];

  static adicionar(CheckSintomasModel cs) async{

    cs.isCasoSuspeito = DefinicaoCasoSuspeito().casoSuspeito(cs);

    final Database db = await getDatabase();
    db.insert(_nomeTabela, cs.toMap());

    //_checkSintomasPaciente.add(cs);
  }


  static const String _nomeTabelaPaciente = 'paciente';
  static const String _col_idP = 'id';
  static const String _col_nome = 'nome';
  static const String _col_email = 'email';
  static const String _col_idade = 'idade';
  static const String _col_cartao = 'cartao';
  static const String _col_senha = 'senha';
  static const String _col_foto = 'foto';


  Future<List<CheckSintomasModel>> getPacienteCheckSintomas(Paciente p) async {

    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps =
    await db.rawQuery('SELECT * FROM $_nomeTabela cs, $_nomeTabelaPaciente p '
        'WHERE cs.idpaciente = p.id AND p.id = '+p.id.toString());

    return List.generate(maps.length, (i) {

      Paciente paciente = Paciente(
        maps[i][_col_idP],
        maps[i][_col_nome],
        maps[i][_col_email],
        maps[i][_col_cartao],
        maps[i][_col_idade],
        maps[i][_col_senha],
        maps[i][_col_foto],
      );


      CheckSintomasModel cs = CheckSintomasModel(
          maps[i][_col_idP],
          paciente,
          maps[i][_col_temperatura],
          maps[i][_col_qtdDias],
          maps[i][_col_isNarizEntupido] == 1? true : false,
          maps[i][_col_isDorGarganta] == 1? true : false,
          maps[i][_col_isRouquidao] == 1? true : false,
          maps[i][_col_isCatarro] == 1? true : false,
          maps[i][_col_isTosse] == 1? true : false,
          DateTime.parse(maps[i][_col_dataAvaliavao])
      );
      cs.isCasoSuspeito = maps[i][_col_isCasoSuspeito] == 1? true : false;
      return cs;
    });
  }

}