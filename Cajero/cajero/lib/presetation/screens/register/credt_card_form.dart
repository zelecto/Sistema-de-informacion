import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/extra/card_type.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:cajero/config/tools/color_util.dart';
import 'package:cajero/domain/entity/credit_card.dart';
import 'package:cajero/domain/infrastructure/credit_card_data.dart';
import 'package:cajero/presetation/screens/register/widget/text_field_from.dart';
import 'package:cajero/presetation/screens/register/widget/update_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CreditCardForm extends HookWidget {
  const CreditCardForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Textos y mensajes de validación
    const String cardNumberHint = '0000 0000 0000 0000';
    const String holderNameHint = 'Nombre';
    const String expirationHint = 'MM/AA';
    const String ccvHint = '000';
    const String saveButtonLabel = 'Guardar';
    const String cardBankName = "Bancolombia";
    const String textExpDate = 'Exp. Date';
    const String textExpiry = 'MM/YY';

    // Variables de UI Card Credit
    final numberCard = useState<String>('');
    final holderName = useState<String>('');
    final expirationDate = useState<String>('');
    final securityCode = useState<String>('');
    final showBackSide = useState(false);
    final selectedColor = useState<Color>(Colors.amber);

    // Controladores de inputs
    final controllerNumberCard = useTextEditingController();
    final controllerHolderName = useTextEditingController();
    final controllerExpirationDate = useTextEditingController();
    final controllerCcv = useTextEditingController();
    final isFormValid = useState(false);

    final formKey = useMemoized(() => GlobalKey<FormState>());

    // FocusNode para el CCV
    final focusNodeCcv = useFocusNode();

    // Función para formatear el número de tarjeta
    void formatCardNumber(String value) {
      final rawText = value.replaceAll(RegExp(r'\s+'), '');
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

      // Listener para el FocusNode del CCV
      focusNodeCcv.addListener(() {
        showBackSide.value = focusNodeCcv.hasFocus;
      });

      return () {
        controllerNumberCard.removeListener(listener);
        controllerHolderName.removeListener(listener);
        controllerExpirationDate.removeListener(listener);
        controllerCcv.removeListener(listener);
        focusNodeCcv.removeListener(() {
          showBackSide.value = focusNodeCcv.hasFocus;
        });
      };
    }, [
      controllerNumberCard,
      controllerHolderName,
      controllerExpirationDate,
      controllerCcv,
      focusNodeCcv,
    ]);

    return Column(
      children: [
        CreditCard(
          cardNumber: numberCard.value,
          cardExpiry: expirationDate.value,
          cardHolderName: holderName.value,
          cvv: securityCode.value,
          bankName: cardBankName,
          cardType: CardType.masterCard,
          showBackSide: showBackSide.value,
          frontBackground: CardBackgrounds.custom(selectedColor.value.value),
          backBackground: CardBackgrounds.custom(selectedColor.value.value),
          frontTextColor: ColorUtil.isColorLight(selectedColor.value)
              ? Colors.black
              : Colors.white,
          textExpDate: textExpDate,
          textExpiry: textExpiry,
        ),
        Form(
          key: formKey,
          child: Column(
            children: [
              UpdateColors(selectedColor: selectedColor),
              TextFieldFrom(
                controller: controllerNumberCard,
                hintText: cardNumberHint,
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
                hintText: holderNameHint,
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
                      hintText: expirationHint,
                      type: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                        if (value.length > 5) {
                          return 'La fecha de vencimiento no puede tener más de 5 caracteres';
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
                      hintText: ccvHint,
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
                      focusNode: focusNodeCcv, // Asignar el FocusNode aquí
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
                              var credit_card = CreditCardEntity(
                                  cardNumber: controllerNumberCard.text,
                                  cardExpiry: controllerHolderName.text,
                                  cardHolderName: controllerExpirationDate.text,
                                  cvv: controllerCcv.text,
                                  color: selectedColor.value);

                              addCreditCard(credit_card);

                              controllerNumberCard.clear();
                              controllerHolderName.clear();
                              controllerExpirationDate.clear();
                              controllerCcv.clear();
                            }
                          }
                        : null,
                    style:
                        FilledButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text(saveButtonLabel),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
