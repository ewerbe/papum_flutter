import 'package:papum/database/openDatabaseDB.dart';
import 'package:papum/model/freteiro.dart';
import 'package:sqflite/sqflite.dart';

class FreteiroDAO{

  static const String _nomeTabela = 'freteiro';
  static const String _col_id = 'id';
  static const String _col_nome = 'nome';
  static const String _col_whatsapp = 'whatsapp';
  static const String _col_idade = 'idade';
  static const String _col_placa = 'placa';
  static const String _col_senha = 'senha';
  static const String _col_foto = 'foto';

static const String sqlTabelaPaciente = 'CREATE TABLE $_nomeTabela('
'$_col_id INTEGER PRIMARY KEY, '
'$_col_nome TEXT, '
'$_col_whatsapp TEXT, '
'$_col_idade INTEGER, '
'$_col_placa TEXT, '
'$_col_senha TEXT, '
'$_col_foto TEXT)';


adicionar(Freteiro f) async{
final Database db = await getDatabase();
await db.insert(_nomeTabela, f.toMap());
}


static Freteiro? getFreteiro(int index){
return null;
}


atualizar(Freteiro f) async {
final Database db = await getDatabase();
db.update(_nomeTabela, f.toMap(), where: 'id=?', whereArgs: [f.id]);
}


Future<List<Freteiro>> getFreteiros() async{

final Database db = await getDatabase();

final List<Map<String, dynamic>> maps = await db.query(_nomeTabela);



  return List.generate(maps.length, (i) {
    return Freteiro(
      maps[i][_col_id],
      maps[i][_col_nome],
      maps[i][_col_whatsapp],
      maps[i][_col_placa],
      maps[i][_col_idade],
      maps[i][_col_senha],
      maps[i][_col_foto],
      );
    });

  }
}
