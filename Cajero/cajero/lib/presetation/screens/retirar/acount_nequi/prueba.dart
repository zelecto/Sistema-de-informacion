import 'dart:async';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cajero/config/tools/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class CodeTemporalAcountNequi extends HookWidget {
  const CodeTemporalAcountNequi({super.key});
  static const String name = 'code-temporala-count-nequi';

  @override
  Widget build(BuildContext context) {
    final time = useState(10);

    int generateRandomNumber() {
      final random = Random();
      return 100000 + random.nextInt(900000);
    }

    final randomNumber = useState(generateRandomNumber());

    // Hook para manejar el temporizador
    useEffect(() {
      final timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (time.value > 0) {
          time.value--;
        } else {
          randomNumber.value = generateRandomNumber();
          time.value = 10;
        }
      });

      return () => timer.cancel();
    }, []);

    // Validaciones de código de seguridad
    final controllerCodeSegurity = useTextEditingController();
    final focusNode = useFocusNode();
    final numIntentosDisponibles = useState(3);

    void validarCodigoSeguridad() {
      if (controllerCodeSegurity.text.length == 6 &&
          randomNumber.value.toString() == controllerCodeSegurity.text) {
        context.go('/monto_selecionar');
      } else if (controllerCodeSegurity.text.length == 6) {
        numIntentosDisponibles.value--;
        if (numIntentosDisponibles.value <= 0) {
          _showDialog(
              context, 'Se han agotado los intentos, Se bloqueara la cuenta');
        } else {
          _showSnackBar(context,
              'Código incorrecto. Intentos restantes: ${numIntentosDisponibles.value}');
          controllerCodeSegurity.clear();
        }
      }
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(focusNode);
      });

      controllerCodeSegurity.addListener(() {
        if (controllerCodeSegurity.text.length == 6) {
          validarCodigoSeguridad();
        }
      });

      return () {
        focusNode.unfocus(); // Quita el foco antes de disponer
        focusNode.dispose();
        controllerCodeSegurity.dispose();
        ScaffoldMessenger.of(context)
            .clearSnackBars(); // Limpia todos los SnackBars
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Transform.rotate(
                  angle: 45 * 3.14159 / 180,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade800,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Transform.rotate(
                        angle: -45 * 3.14159 / 180,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            randomNumber.value.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' ${time.value}s',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        randomNumber.value = generateRandomNumber(),
                    icon: const Icon(
                      Icons.refresh_outlined,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: ScreenSize.getWidth(context) * 0.9,
                child: TextField(
                  controller: controllerCodeSegurity,
                  maxLength: 6,
                  decoration: InputDecoration(
                    labelText: 'Código de seguridad',
                    hintText: 'Ingrese su código',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  focusNode: focusNode,
                ),
              ),
              if (numIntentosDisponibles.value == 1)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: FadeIn(
                    child: const Text(
                      'Solo te queda un intento. Si fallas, tu cuenta será bloqueada.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.red,
                      ),
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
  messenger.clearSnackBars(); // Limpia cualquier SnackBar activo
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
