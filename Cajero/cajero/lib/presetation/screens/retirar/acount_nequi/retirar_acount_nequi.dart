import 'package:cajero/config/tools/screen_size.dart';
import 'package:cajero/domain/entity/acunt_nequi.dart';
import 'package:cajero/domain/infrastructure/acount_nequi_data.dart';
import 'package:cajero/presetation/provider/acount_nequi/credit_cart_provaider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RetirarAcountNequiView extends HookConsumerWidget {
  const RetirarAcountNequiView({super.key});
  static const String name = 'retirar-acount-nequi';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerNoAcountNequi = useTextEditingController();
    final focusNode = useFocusNode();
    final isFormValid = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    // Función para validar el formulario
    void validateForm() {
      final formState = formKey.currentState;
      if (formState != null) {
        isFormValid.value = formState.validate();
      }
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(focusNode);
      });

      controllerNoAcountNequi.addListener(() {
        validateForm();
      });

      return () {
        focusNode.dispose();
        controllerNoAcountNequi.dispose();
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'Bancolombia',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/images/Icono_Bancolombia.png',
              width: 30,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/nequi.png',
                height: ScreenSize.getHeight(context) * 0.3,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controllerNoAcountNequi,
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  if (controllerNoAcountNequi.text.length != 10) {
                    return 'El teléfono debe tener exactamente 10 dígitos';
                  }
                  // Lista de prefijos válidos para una cuenta Nequi
                  final validPrefixes = [
                    '301',
                    '304',
                    '310',
                    '311',
                    '312',
                    '315'
                  ];

                  // Verifica si el número ingresado comienza con alguno de los prefijos válidos
                  bool hasValidPrefix =
                      validPrefixes.any((prefix) => value.startsWith(prefix));
                  if (!hasValidPrefix) {
                    return 'El número debe comenzar con 301, 304, 310, etc.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'No cuenta nequi',
                  hintText: 'Digite su numero de cuenta',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                focusNode: focusNode,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: isFormValid.value
                    ? () async {
                        var acountNequi = await validarAcountNequi(
                            '0${controllerNoAcountNequi.text}');
                        if (acountNequi != null) {
                          ref.read(acountNequiProvaider.notifier).state =
                              acountNequi;
                          // ignore: use_build_context_synchronously
                          context.go('/codigo_temporal');
                        } else {
                          // ignore: use_build_context_synchronously
                          _showSnackBar(context, 'Cuenta no encontrada');
                          controllerNoAcountNequi.clear();
                        }
                      }
                    : null,
                style: FilledButton.styleFrom(
                    backgroundColor: Color(Colors.green.value)),
                child: const Text('Continuar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<AcountNequi?> validarAcountNequi(String noAcount) async {
  var listAcountNequi = await getAcuntNequiList();

  for (var element in listAcountNequi) {
    if (element.tlf == noAcount) {
      return element;
    }
  }

  return null;
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
