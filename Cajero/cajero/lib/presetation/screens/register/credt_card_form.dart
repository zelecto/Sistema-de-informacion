import 'package:cajero/presetation/screens/register/widget/text_field_from.dart';
import 'package:cajero/presetation/screens/register/widget/update_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CreditCardForm extends HookWidget {
  const CreditCardForm({
    super.key,
    required this.numberCard,
    required this.selectedColor,
    required this.holderName,
    required this.expirationDate,
    required this.securityCode,
    required this.showBackSide,
  });

  final ValueNotifier<String> numberCard;
  final ValueNotifier<String> holderName;
  final ValueNotifier<String> expirationDate;
  final ValueNotifier<String> securityCode;
  final ValueNotifier<Color> selectedColor;
  final ValueNotifier<bool> showBackSide;

  @override
  Widget build(BuildContext context) {
    final controllerNumberCard = useTextEditingController();
    final controllerHolderName = useTextEditingController();
    final controllerExpirationDate = useTextEditingController();
    final controllerCcv = useTextEditingController();
    final isFormValid = useState(false);

    final formKey = useMemoized(() => GlobalKey<FormState>());

    // Función para formatear el número de tarjeta
    void formatCardNumber(String value) {
      final rawText = value.replaceAll(RegExp(r'\s+'), '');
      // Limita a 16 dígitos (sin espacios)
      final limitedText =
          rawText.length > 16 ? rawText.substring(0, 16) : rawText;
      final formattedText = limitedText
          .replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ')
          .trim();
      controllerNumberCard.value = controllerNumberCard.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }

    // Función para formatear la fecha de vencimiento
    void formatExpirationDate(String value) {
      final rawText = value.replaceAll(RegExp(r'[^0-9]'), '');
      final formattedText = rawText.length > 2
          ? '${rawText.substring(0, 2)}/${rawText.substring(2)}'
          : rawText;
      controllerExpirationDate.value = controllerExpirationDate.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }

    void validateForm() {
      final formState = formKey.currentState;
      if (formState != null) {
        isFormValid.value = formState.validate();
      }
    }

    // Listener para todos los campos
    useEffect(() {
      void listener() {
        formatCardNumber(controllerNumberCard.text);
        formatExpirationDate(controllerExpirationDate.text);

        numberCard.value = controllerNumberCard.text;
        holderName.value = controllerHolderName.text;
        expirationDate.value = controllerExpirationDate.text;
        securityCode.value = controllerCcv.text;
        validateForm();
      }

      controllerNumberCard.addListener(listener);
      controllerHolderName.addListener(listener);
      controllerExpirationDate.addListener(listener);
      controllerCcv.addListener(listener);

      return () {
        controllerNumberCard.removeListener(listener);
        controllerHolderName.removeListener(listener);
        controllerExpirationDate.removeListener(listener);
        controllerCcv.removeListener(listener);
      };
    }, [
      controllerNumberCard,
      controllerHolderName,
      controllerExpirationDate,
      controllerCcv,
    ]);

    return Form(
      key: formKey,
      child: Column(
        children: [
          UpdateColors(selectedColor: selectedColor),
          TextFieldFrom(
            controller: controllerNumberCard,
            hintText: '0000 0000 0000 0000',
            labelText: 'Número de la tarjeta',
            maxLength: 19,
            type: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio';
              }
              if (value.replaceAll(RegExp(r'\s+'), '').length != 16) {
                return 'El número de tarjeta debe tener 16 dígitos';
              }
              return null;
            },
          ),
          TextFieldFrom(
            controller: controllerHolderName,
            labelText: 'Titular de la tarjeta',
            maxLength: 20,
            hintText: 'Nombre',
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
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
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextFieldFrom(
                  controller: controllerExpirationDate,
                  maxLength: 5,
                  labelText: 'Vencimiento',
                  hintText: 'MM/AA',
                  type: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4)
                  ], // Limita a 4 caracteres],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    if (value.length > 5) {
                      return 'El CCV no puede tener más de 4 dígitos';
                    }
                    return null;
                  },
                ),
              ),
              const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextFieldFrom(
                  controller: controllerCcv,
                  maxLength: 4,
                  labelText: 'CCV',
                  hintText: '000',
                  type: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    if (value.length < 3) {
                      return 'El CCV debe tener al menos 3 dígitos';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: FilledButton(
                onPressed: isFormValid.value
                    ? () {
                        if (formKey.currentState?.validate() ?? false) {
                          print('Formulario guardado');
                        }
                      }
                    : null,
                style: FilledButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Guardar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
