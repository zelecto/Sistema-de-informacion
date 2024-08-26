import 'package:cajero/config/tools/color_util.dart';
import 'package:cajero/config/tools/screen_size.dart';
import 'package:cajero/presetation/screens/register/widget/text_field_from.dart';
import 'package:cajero/presetation/screens/register/widget/update_colors.dart';
import 'package:flutter/material.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RegisterView extends HookWidget {
  const RegisterView({super.key});
  static const name = 'register-view';

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    //varibles de la tarjeta
    final numberCard = useState<String>('');
    final holderName = useState<String>('');
    final expirationDate = useState<String>('');
    final securityCode = useState<String>('');
    final showBackSide = useState(false);
    final selectedColor = useState<Color>(Colors.amber);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          children: [
            const Spacer(),
            Text(
              'Bancolombia',
              style: textStyle,
            ),
            Image.asset(
              'assets/images/Icono_Bancolombia.png',
              height: ScreenSize.getHeight(context) * 0.04,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Reguistrar Tarjeta de credito',
                      style: textStyle,
                    ),
                  ),
                  CreditCard(
                    cardNumber: numberCard.value,
                    cardExpiry: expirationDate.value,
                    cardHolderName: holderName.value,
                    cvv: securityCode.value,
                    bankName: "Bancolombia",
                    cardType: CardType.masterCard,
                    showBackSide: showBackSide.value,
                    frontBackground:
                        CardBackgrounds.custom(selectedColor.value.value),
                    backBackground:
                        CardBackgrounds.custom(selectedColor.value.value),
                    frontTextColor: ColorUtil.isColorLight(selectedColor.value)
                        ? Colors.black
                        : Colors.white,
                    textExpDate: 'Exp. Date',
                    textExpiry: 'MM/YY',
                  ),
                  _CreditCardForm(
                    numberCard: numberCard,
                    selectedColor: selectedColor,
                    securityCode: securityCode,
                    expirationDate: expirationDate,
                    holderName: holderName,
                    showBackSide: showBackSide,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Expanded(child: Divider()),
                        Text('OR'),
                        Expanded(child: Divider())
                      ],
                    ),
                  ),
                  Text(
                    'Reguistrar Cuenta Nequi',
                    style: textStyle,
                  ),
                  Image.network(
                      'https://i.pinimg.com/564x/c9/9d/14/c99d1437635da2d96561a8e37f0d4d4e.jpg'),
                  const _AcountNequiFrom()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreditCardForm extends HookWidget {
  const _CreditCardForm(
      {required this.numberCard,
      required this.selectedColor,
      required this.holderName,
      required this.expirationDate,
      required this.securityCode,
      required this.showBackSide});

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

    // Listener para el número de la tarjeta
    useEffect(() {
      void listener() {
        showBackSide.value ? showBackSide.value = false : null;
        final rawText =
            controllerNumberCard.text.replaceAll(RegExp(r'\s+'), '');
        final formattedText = rawText
            .replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ')
            .trim();

        if (numberCard.value != formattedText) {
          numberCard.value = formattedText;
        }
      }

      controllerNumberCard.addListener(listener);
      return () => controllerNumberCard.removeListener(listener);
    }, [controllerNumberCard]);

    // Sincronizar el controlador con el ValueNotifier
    useEffect(() {
      controllerNumberCard.text = numberCard.value;
      controllerNumberCard.selection = TextSelection.fromPosition(
        TextPosition(offset: controllerNumberCard.text.length),
      );
      return null;
    }, [numberCard.value]);

    // Listener para el nombre del titular
    useEffect(() {
      void listener() {
        showBackSide.value ? showBackSide.value = false : null;
        if (holderName.value != controllerHolderName.text) {
          holderName.value = controllerHolderName.text;
        }
      }

      controllerHolderName.addListener(listener);
      return () => controllerHolderName.removeListener(listener);
    }, [controllerHolderName]);

    // Listener para la fecha de vencimiento
    useEffect(() {
      void listener() {
        showBackSide.value ? showBackSide.value = false : null;
        if (expirationDate.value != controllerExpirationDate.text) {
          expirationDate.value = controllerExpirationDate.text;
        }
      }

      controllerExpirationDate.addListener(listener);
      return () => controllerExpirationDate.removeListener(listener);
    }, [controllerExpirationDate]);

    // Listener para el código de seguridad
    useEffect(() {
      void listener() {
        showBackSide.value = true;
        if (securityCode.value != controllerCcv.text) {
          securityCode.value = controllerCcv.text;
          controllerCcv.text.length == 4
              ? Future.delayed(const Duration(seconds: 2), () {
                  showBackSide.value = false;
                })
              : null;
        }
      }

      controllerCcv.addListener(listener);
      return () => controllerCcv.removeListener(listener);
    }, [controllerCcv]);

    return Column(
      children: [
        UpdateColors(selectedColor: selectedColor),
        TextFieldFrom(
          controller: controllerNumberCard,
          hintText: '0000 0000 0000 0000',
          labelText: 'Número de la tarjeta',
          maxLength: 19,
          type: TextInputType.number,
        ),
        TextFieldFrom(
          controller: controllerHolderName,
          labelText: 'Titular de la tarjeta',
          maxLength: 20,
          hintText: 'Nombre',
        ),
        Row(
          children: [
            SizedBox(
              width: ScreenSize.getWidth(context) * 0.4,
              child: TextFieldFrom(
                controller: controllerExpirationDate,
                maxLength: 5, // Para formato 'MM/YY'
                labelText: 'Vencimiento',
                hintText: '00/00',
                type: TextInputType.number,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: ScreenSize.getWidth(context) * 0.4,
              child: TextFieldFrom(
                controller: controllerCcv,
                maxLength: 4,
                labelText: 'CCV',
                hintText: '000',
                type: TextInputType.number,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: ScreenSize.getWidth(context) * 0.4,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Guardar'),
            ),
          ),
        ),
      ],
    );
  }
}

class _AcountNequiFrom extends HookWidget {
  const _AcountNequiFrom();

  @override
  Widget build(BuildContext context) {
    final controllerName = useTextEditingController();
    return Column(
      children: [
        TextFieldFrom(
            controller: controllerName,
            labelText: 'Nombre',
            hintText: 'Carlos'),
        TextFieldFrom(
            controller: controllerName,
            labelText: 'Telefono',
            hintText: '0000000000'),
        TextFieldFrom(
            controller: controllerName,
            labelText: 'cedula',
            hintText: 'Carlos'),
        SizedBox(
          height: ScreenSize.getHeight(context) * 0.15,
        )
      ],
    );
  }
}
