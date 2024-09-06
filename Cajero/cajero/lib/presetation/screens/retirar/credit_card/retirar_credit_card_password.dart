import 'package:animate_do/animate_do.dart';
import 'package:cajero/config/tools/screen_size.dart';
import 'package:cajero/presetation/provider/credit_cart/credit_cart_provaider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RetirarCreditCardPassword extends HookConsumerWidget {
  const RetirarCreditCardPassword({super.key});
  static const String name = 'retirar-credit-card-password121321';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerCcv = useTextEditingController();
    final creditCard = ref.read(creditCardProvider);
    final focusNode = useFocusNode();
    final numIntentosDisponibles = useState(3);

    void validarCcv() {
      if (controllerCcv.text.length == 3 &&
          creditCard!.cvv == controllerCcv.text) {
      } else if (controllerCcv.text.length == 3) {
        numIntentosDisponibles.value--;
        if (numIntentosDisponibles.value <= 0) {
          _showDialog(
              context, 'Se han agotado los intentos, Se bloqueara la cuenta');
        } else {
          _showSnackBar(context,
              'Código incorrecto. Intentos restantes: ${numIntentosDisponibles.value}');
          controllerCcv.clear();
        }
      }
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(focusNode);
      });

      controllerCcv.addListener(() {
        if (controllerCcv.text.length == 3) {
          validarCcv();
        }
      });

      return () {
        focusNode.dispose();
        controllerCcv.dispose();
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Icono_Bancolombia.png',
              width: 30,
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              'Bancolombia',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/candado.png',
              height: ScreenSize.getHeight(context) * 0.3,
            ),
            const SizedBox(
              height: 20,
            ),
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
            // ignore: unrelated_type_equality_checks
            if (numIntentosDisponibles.value == 1)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: FadeIn(
                  child: const Text(
                    'Solo te queda un intento. Si fallas, tu cuenta será bloqueada.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.red),
                  ),
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void _showDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: ScreenSize.getHeight(context) * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/error.png',
                height: ScreenSize.getHeight(context) * 0.1,
                width: ScreenSize.getWidth(context) * 0.5,
                fit: BoxFit.cover,
              ),
              Text(message,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.go('/');
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Color(Colors.red.value),
      content: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
