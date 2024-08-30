import 'package:cajero/config/tools/screen_size.dart';
import 'package:flutter/material.dart';

class MontoSelecionarView extends StatelessWidget {
  const MontoSelecionarView({super.key});
  static const name = 'monto-selecionar-view';

  @override
  Widget build(BuildContext context) {
    const List<int> listValores = [
      10000,
      20000,
      50000,
      100000,
      200000,
      300000,
      500000,
      1000000
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Seleccione el monto a retirar',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: ScreenSize.getHeight(context) * 0.05,
            ),
            SizedBox(
              height: ScreenSize.getHeight(context) * 0.4,
              child: GridView.count(
                physics:
                    const NeverScrollableScrollPhysics(), // Aquí va la línea correcta
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 2.5,
                children: listValores.map((value) {
                  return FloatingActionButton(
                    onPressed: () {
                      // Acción al presionar el botón
                    },
                    child: Text(
                      value.toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: ScreenSize.getWidth(context) * 0.6,
              height: ScreenSize.getHeight(context) * 0.1,
              child: FloatingActionButton(
                onPressed: () {
                  // Acción al presionar el botón
                },
                child: const Text(
                  "Solicitar un valor diferente",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
