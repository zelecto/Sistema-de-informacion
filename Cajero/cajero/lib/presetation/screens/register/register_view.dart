import 'package:cajero/config/tools/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RegisterView extends HookWidget {
  const RegisterView({super.key});
  static const name = 'register-view';

  @override
  Widget build(BuildContext context) {
    final numberCard = useState<String>('');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Registrarse'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CreditCard(
              cardNumber: numberCard.value,
              cardExpiry: "10/25",
              cardHolderName: "Card Holder",
              cvv: "456",
              bankName: "Bancolombia",
              cardType: CardType.other,
              showBackSide: false,
              frontBackground: CardBackgrounds.custom(Colors.amber.value),
              backBackground: CardBackgrounds.custom(Colors.amber.value),
              textExpDate: 'Exp. Date',
              textExpiry: 'MM/YY',
            ),
            const SizedBox(
              height: 20,
            ),
            _CreditCardForm(numberCard),
          ],
        ),
      ),
    );
  }
}

class _CreditCardForm extends HookWidget {
  const _CreditCardForm(this.numberCard);
  final ValueNotifier<String> numberCard;

  @override
  Widget build(BuildContext context) {
    final controllerNumberCard = useTextEditingController();
    final controllerHolderName = useTextEditingController();
    final controllerExpirationDate = useTextEditingController();
    final controllerCcv = useTextEditingController();

    useEffect(() {
      void listener() {
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

    useEffect(() {
      controllerNumberCard.text = numberCard.value;
      controllerNumberCard.selection = TextSelection.fromPosition(
        TextPosition(offset: controllerNumberCard.text.length),
      );
      return null;
    }, [numberCard.value]);

    return Column(
      children: [
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
            maxLength: 50,
            hintText: 'Nombre'),
        Row(
          children: [
            SizedBox(
              width: ScreenSize.getWidth(context) * 0.4,
              child: TextFieldFrom(
                controller: controllerExpirationDate,
                maxLength: 4,
                labelText: 'vencimiento',
                hintText: '00/00',
              ),
            ),
            const Spacer(),
            SizedBox(
              width: ScreenSize.getWidth(context) * 0.4,
              child: TextFieldFrom(
                controller: controllerCcv,
                maxLength: 4,
                labelText: 'CCV',
                hintText: '0000',
                type: TextInputType.number,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class TextFieldFrom extends StatelessWidget {
  const TextFieldFrom({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.maxLength,
    this.type,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final int? maxLength;
  final TextInputType? type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        keyboardType: type,
        controller: controller,
        maxLength: maxLength,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          labelText: labelText,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
