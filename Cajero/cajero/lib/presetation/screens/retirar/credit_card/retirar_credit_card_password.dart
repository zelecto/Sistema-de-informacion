import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class RetirarCreditCardPassword extends HookWidget {
  const RetirarCreditCardPassword({super.key});
  static const String name = 'retirar-credit-card-password121321';

  @override
  Widget build(BuildContext context) {
    final controllerCcv = useTextEditingController();
    final focusNode = useFocusNode();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(focusNode);
      });

      focusNode.addListener(() {
        if (!focusNode.hasFocus) {
          FocusScope.of(context).requestFocus(focusNode);
        }
      });

      return () {
        focusNode.dispose();
      };
    }, [focusNode]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Digite su código CCV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controllerCcv,
              maxLength: 3,
              decoration: InputDecoration(
                labelText: 'CCV',
                hintText: 'Ingrese su código CCV',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              focusNode: focusNode,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/recibo');
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      ),
    );
  }
}
