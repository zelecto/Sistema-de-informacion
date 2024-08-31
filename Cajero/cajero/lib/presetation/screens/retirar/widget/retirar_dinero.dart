import 'package:cajero/config/tools/screen_size.dart';
import 'package:cajero/domain/entity/acunt_nequi.dart';
import 'package:cajero/domain/entity/credit_card.dart';
import 'package:cajero/presetation/provider/Retiro/retiro_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const List<int> billetes = [10000, 20000, 50000, 100000];

class ReciboView extends ConsumerWidget {
  const ReciboView({super.key});
  static const String name = 'retirar-dinero';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var retiro = ref.read(retiroProvider);
    CreditCardEntity? creditCardEntity = retiro?.creditCard;
    AcuntNequi? acuntNequi = retiro?.acuntNequi;

    return Scaffold(
        body: SizedBox(
      width: ScreenSize.getWidth(context),
      child: Column(
        children: [
          _CuentaInfoCard(
              acountNumber: creditCardEntity != null
                  ? creditCardEntity.cardNumber
                  : acuntNequi!.tlf,
              montoRetirar: retiro!.montoRetirar),
          FilledButton(
              onPressed: () => context.go('/'), child: Text('Regresar al menu'))
        ],
      ),
    ));
  }
}

class _CuentaInfoCard extends StatelessWidget {
  final String acountNumber;
  final int montoRetirar;

  const _CuentaInfoCard({
    required this.acountNumber,
    required this.montoRetirar,
  });

  @override
  Widget build(BuildContext context) {
    List<List<int>> valores = [];
    int solicitud = montoRetirar;
    int monto = 0;

    while (monto < solicitud) {
      monto += retirar(solicitar: solicitud - monto, array: valores);
    }

    var billetesFormateado = formateo(valores);
    const textStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 18);

    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: ScreenSize.getWidth(context),
          height: ScreenSize.getHeight(context) * 0.5,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Registro de operación \n Cajero automático',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    'Número de cuenta: $acountNumber',
                    style: textStyle,
                  ),
                  Text(
                    'Monto retirado: $montoRetirar',
                    style: textStyle,
                  ),
                  Wrap(
                    spacing: 8.0,
                    alignment: WrapAlignment.center,
                    children: billetesFormateado.entries.map((entry) {
                      return Text(
                        '${entry.key} : ${entry.value}',
                        style: textStyle,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

int retirar({required int solicitar, required List<List<int>> array}) {
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

List<List<int>> despacho(int solicitado) {
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

Map<String, int> formateo(List<List<int>> listaValores) {
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
