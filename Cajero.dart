import 'dart:io';

const List<int> billetes = [10000, 20000, 50000, 100000];

void main(List<String> args) {
  List<List<int>> valores = [];
  // stdout.write('Introduce un valor: ');
  // String? read = stdin.readLineSync();
  // int solicitud = int.parse(read!);
  int solicitud = 50000;
  int monto = 0;
  while (monto < solicitud) {
    monto += Retirar(solicitar: solicitud - monto, array: valores);
  }
  print(valores);
  print(Formateo(valores));
}

int Retirar({required int solicitar, required List<List<int>> array}) {
  int monto = 0;
  List<List<int>> listaValores = array;
  for (var i = 0; i < 4; i++) {
    if (billetes[i] + monto <= solicitar) {
      array.length >= i + 1 ? null : array.add([]);
      for (var j = i; j < 4; j++) {
        if (monto + billetes[j] <= solicitar) {
          monto += billetes[j];
          listaValores[i].add(billetes[j]);
        }
      }
    } else {
      return monto;
    }
  }
  return monto;
}

List<List<int>> Despacho(int solicitado) {
  int monto = 0;
  int filas = 0;
  List<List<int>> resultado = [];
  List<int> acarreo = [];
  while (monto < solicitado) {
    resultado.add([]);
    for (var i = 0; i < 4; i++) {
      if (i + 1 <= acarreo.length && acarreo[i] == 1) {
        resultado[filas].add(0);
      } else if (monto + billetes[i] <= solicitado) {
        resultado[filas].add(billetes[i]);
        monto += billetes[i];
      }
    }
    acarreo.add(1);
    filas++;
  }

  return resultado;
}

Map<String, int> Formateo(List<List<int>> listaValores) {
  Map<String, int> numeroBilletes = {
    "10k": 0,
    "20k": 0,
    "50k": 0,
    "100k": 0,
  };
  for (var i = 0; i < listaValores.length; i++) {
    for (var j = 0; j < listaValores[i].length; j++) {
      switch (listaValores[i][j]) {
        case 10000:
          numeroBilletes["10k"] = 1 + (numeroBilletes["10k"] ?? 0);
          break;
        case 20000:
          numeroBilletes["20k"] = 1 + (numeroBilletes["20k"] ?? 0);
          break;
        case 50000:
          numeroBilletes["50k"] = 1 + (numeroBilletes["50k"] ?? 0);
          break;
        case 100000:
          numeroBilletes["100k"] = 1 + (numeroBilletes["100k"] ?? 0);
          break;

        default:
      }
    }
  }

  return numeroBilletes;
}

Map<String, int> ComodinDespacho(int solicitado) {
  int monto = 0;
  Map<String, int> resultados = {
    "10k": 0,
    "20k": 0,
    "50k": 0,
    "100k": 0,
  };
  while (monto < solicitado) {
    for (var i = 3; i >= 0; i--) {
      if (monto + billetes[i] <= solicitado) {
        var numeroBilletes = descomponer(solicitado - monto, billetes[i]);
        resultados[billetes[i].toString() + 'k'] =
            numeroBilletes + (resultados[billetes[i].toString() + 'k'] ?? 0);
        monto += numeroBilletes * billetes[i];
      }
    }
  }

  return resultados;
}

int descomponer(int valor, int valorDeBillete) {
  return valor ~/ valorDeBillete;
}
