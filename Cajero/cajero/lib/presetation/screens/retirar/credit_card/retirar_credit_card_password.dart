import 'package:cajero/config/tools/screen_size.dart';
import 'package:cajero/presetation/screens/register/widget/text_field_from.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RetirarCreditCardPassword extends HookWidget {
  const RetirarCreditCardPassword({super.key});
  static const String name = 'retirar-credit-card-password';

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

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: ScreenSize.getHeight(context) * 0.1,
            ),
            const Text(
              'Por favor digite su codigo CCV',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFieldFrom(
                controller: controllerCcv,
                maxLength: 3,
                labelText: 'CCV',
                hintText: '',
                type: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                focusNode: focusNode,
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
