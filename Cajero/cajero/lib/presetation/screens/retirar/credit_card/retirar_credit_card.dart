import 'package:flutter/material.dart';

class RetirarCreditCard extends StatelessWidget {
  const RetirarCreditCard({super.key});
  static const String name = 'retirar-credit-card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bancolombia'),
      ),
    );
  }
}
