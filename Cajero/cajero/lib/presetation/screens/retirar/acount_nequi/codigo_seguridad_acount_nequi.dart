import 'dart:async';
import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:cajero/config/tools/screen_size.dart';
import 'package:cajero/presetation/screens/retirar/widget/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../domain/entity/inactivity_timer.dart'; // Asegúrate de importar la clase

class CodeTemporalAcountNequi extends StatefulWidget {
  const CodeTemporalAcountNequi({super.key});
  static const String name = 'code-temporala-count-nequi';

  @override
  // ignore: library_private_types_in_public_api
  _CodeTemporalAcountNequiState createState() =>
      _CodeTemporalAcountNequiState();
}

class _CodeTemporalAcountNequiState extends State<CodeTemporalAcountNequi> {
  late Timer _timer;
  final ValueNotifier<int> _time = ValueNotifier<int>(10);
  final ValueNotifier<int> _randomNumber = ValueNotifier<int>(0);
  late final InactivityTimer _inactivityTimer;
  final TextEditingController _controllerCodeSegurity = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<int> _numIntentosDisponibles = ValueNotifier<int>(3);

  @override
  void initState() {
    super.initState();
    _generateNewRandomNumber();
    _startTimer();
    _inactivityTimer = InactivityTimer(
      duration: const Duration(seconds: 30),
      onInactivity: () {
        if (mounted) {
          showDialogView(
            context,
            'La sesión ha expirado debido a inactividad.',
          );
        }
      },
    );
    _controllerCodeSegurity.addListener(_onCodeSegurityChange);
  }

  void _generateNewRandomNumber() {
    final random = Random();
    _randomNumber.value = 100000 + random.nextInt(900000);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_time.value > 0) {
        _time.value--;
      } else {
        _generateNewRandomNumber();
        _time.value = 10;
      }
    });
  }

  void _onCodeSegurityChange() {
    if (_controllerCodeSegurity.text.length == 6) {
      _validarCodigoSeguridad();
    }
    _inactivityTimer
        .reset(); // Reinicia el temporizador de inactividad cuando cambia el texto
  }

  void _validarCodigoSeguridad() {
    if (_controllerCodeSegurity.text.length == 6 &&
        _randomNumber.value.toString() == _controllerCodeSegurity.text) {
      context.go('/recibo');
    } else if (_controllerCodeSegurity.text.length == 6) {
      _numIntentosDisponibles.value--;
      if (_numIntentosDisponibles.value <= 0) {
        if (mounted) {
          showDialogView(
            context,
            'Se han agotado los intentos, Se bloqueara la cuenta',
          );
        }
      } else {
        _showSnackBar(
          context,
          'Código incorrecto. Intentos restantes: ${_numIntentosDisponibles.value}',
        );
        _controllerCodeSegurity.clear();
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancelar el temporizador
    _inactivityTimer.dispose(); // Cancelar el temporizador de inactividad
    _controllerCodeSegurity.dispose();
    _focusNode.dispose();
    _time.dispose(); // Limpiar el ValueNotifier
    _randomNumber.dispose(); // Limpiar el ValueNotifier
    _numIntentosDisponibles.dispose(); // Limpiar el ValueNotifier
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          child: ValueListenableBuilder<int>(
                            valueListenable: _randomNumber,
                            builder: (context, value, child) {
                              return Text(
                                value.toString(),
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
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
                  ValueListenableBuilder<int>(
                    valueListenable: _time,
                    builder: (context, value, child) {
                      return Text(
                        ' $value s',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      _generateNewRandomNumber();
                    },
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
                  controller: _controllerCodeSegurity,
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
                  focusNode: _focusNode,
                ),
              ),
              if (_numIntentosDisponibles.value == 1)
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
}
