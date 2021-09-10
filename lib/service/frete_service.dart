import 'package:papum/model/frete.dart';

class FreteService{


  int calculaOrcamento(Frete frete){
  int precoFinal = 100;
    if(frete.maisUmCarregador){
      precoFinal = precoFinal + 100;
    }
    if(frete.maisDoisCarregadores){
      precoFinal = precoFinal + 200;
    }
    if(frete.embalagensProntas){
      precoFinal = precoFinal;
    }else{
      precoFinal = precoFinal + 300;
    }

    if(frete.isForaEstado){
      precoFinal = precoFinal + 1000;
    }
    if(frete.isOutraCidade){
      precoFinal = precoFinal + 100;
    }

    return precoFinal;
  }

}