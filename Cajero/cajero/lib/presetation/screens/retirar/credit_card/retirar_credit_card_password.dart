import 'package:animate_do/animate_do.dart';
import 'package:cajero/config/tools/screen_size.dart';
import 'package:cajero/domain/entity/inactivity_timer.dart';
import 'package:cajero/presetation/provider/credit_cart/credit_cart_provaider.dart';
import 'package:cajero/presetation/screens/retirar/widget/show_dialog.dart';
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

    // Instancia del temporizador de inactividad
    final inactivityTimer = useMemoized(
      () => InactivityTimer(
        duration: const Duration(seconds: 30),
        onInactivity: () {
          showDialogView(context,
              'Tiempo de inactividad alcanzado. Se devolvera al inicio.');
        },
      ),
      [],
    );

    void validarCcv() {
      if (controllerCcv.text.length == 4 &&
          creditCard!.cvv == controllerCcv.text) {
        context.go('/recibo');
      } else if (controllerCcv.text.length == 4) {
        numIntentosDisponibles.value--;
        if (numIntentosDisponibles.value <= 0) {
          showDialogView(
              context, 'Se han agotado los intentos. Se bloqueará la cuenta.');
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
        if (controllerCcv.text.length == 4) {
          validarCcv();
        }
        inactivityTimer.reset(); // Reinicia el temporizador al cambiar el texto
      });

      return () {
        focusNode.dispose();
        controllerCcv.dispose();
        inactivityTimer
            .dispose(); // Cancela el temporizador cuando el widget se desmonta
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
      body: GestureDetector(
        onTap: () => inactivityTimer
            .reset(), // Reinicia el temporizador al tocar la pantalla
        child: Padding(
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
                maxLength: 4,
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
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.showSnackBar(
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
