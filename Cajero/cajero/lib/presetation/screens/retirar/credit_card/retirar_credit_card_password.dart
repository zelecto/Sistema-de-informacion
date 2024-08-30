import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Future<String?> showRetirarCreditCardPasswordDialog(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return const RetirarCreditCardPasswordDialog();
    },
  );
}

class RetirarCreditCardPasswordDialog extends HookWidget {
  const RetirarCreditCardPasswordDialog({super.key});

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

      // Limpiar el listener cuando el widget se destruya
      return () {
        focusNode.dispose();
      };
    }, [focusNode]);

    return AlertDialog(
      title: const Text('Por favor digite su código CCV'),
      content: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: controllerCcv,
            maxLength: 3,
            decoration: InputDecoration(
                labelText: 'CCV',
                hintText: 'Ingrese su código CCV',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            focusNode: focusNode,
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cierra el diálogo sin devolver valor
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pop(controllerCcv.text); // Devuelve el valor del CCV
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
