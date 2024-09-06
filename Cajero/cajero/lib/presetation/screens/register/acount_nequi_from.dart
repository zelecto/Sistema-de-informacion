import 'package:cajero/config/tools/screen_size.dart';
import 'package:cajero/domain/entity/acunt_nequi.dart';
import 'package:cajero/domain/infrastructure/acount_nequi_data.dart';
import 'package:cajero/presetation/screens/register/widget/text_field_from.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AcountNequiFrom extends HookWidget {
  const AcountNequiFrom({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerName = useTextEditingController();
    final controllerPhone = useTextEditingController();
    final isFormValid = useState(false);

    final formKey = useMemoized(() => GlobalKey<FormState>());

    // Función para validar el formulario
    void validateForm() {
      final formState = formKey.currentState;
      if (formState != null) {
        isFormValid.value = formState.validate();
      }
    }

    // Listener para todos los campos
    useEffect(() {
      void listener() {
        validateForm();
      }

      controllerName.addListener(listener);
      controllerPhone.addListener(listener);

      return () {
        controllerName.removeListener(listener);
        controllerPhone.removeListener(listener);
      };
    }, [
      controllerName,
      controllerPhone,
    ]);

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFieldFrom(
            controller: controllerName,
            labelText: 'Nombre',
            hintText: 'Carlos',
            maxLength: 30,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio';
              }
              if (value.length < 3) {
                return 'El nombre debe tener al menos 3 caracteres';
              }
              return null;
            },
          ),
          TextFieldFrom(
            controller: controllerPhone,
            labelText: 'Teléfono',
            hintText: '0000000000',
            maxLength: 10,
            type: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio';
              }
              if (controllerPhone.text.length != 10) {
                return 'El teléfono debe tener exactamente 10 dígitos';
              }
              // Lista de prefijos válidos para una cuenta Nequi
              final validPrefixes = ['301', '304', '310', '311', '312', '315'];

              // Verifica si el número ingresado comienza con alguno de los prefijos válidos
              bool hasValidPrefix =
                  validPrefixes.any((prefix) => value.startsWith(prefix));
              if (!hasValidPrefix) {
                return 'El número debe comenzar con 301, 304, 310, etc.';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: FilledButton(
                onPressed: isFormValid.value
                    ? () {
                        if (formKey.currentState?.validate() ?? false) {
                          final AcountNequi acountNequiFrom = AcountNequi(
                              name: controllerName.text,
                              tlf: '0${controllerPhone.text}');
                          addAcuntNequi(acountNequiFrom);
                          controllerPhone.clear();
                          controllerName.clear();
                        }
                      }
                    : null,
                style: FilledButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Guardar'),
              ),
            ),
          ),
          SizedBox(
            height: ScreenSize.getHeight(context) * 0.04,
          )
        ],
      ),
    );
  }
}
