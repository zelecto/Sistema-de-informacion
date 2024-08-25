import 'package:cajero/config/tools/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RegisterView extends HookWidget {
  const RegisterView({super.key});
  static const name = 'register-view';

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    final numberCard = useState<String>('');
    final selectedColor = useState<Color>(Colors.amber);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          children: [
            Spacer(),
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
                    cardExpiry: "10/25",
                    cardHolderName: "Card Holder",
                    cvv: "456",
                    bankName: "Bancolombia",
                    cardType: CardType.other,
                    showBackSide: false,
                    frontBackground:
                        CardBackgrounds.custom(selectedColor.value.value),
                    backBackground:
                        CardBackgrounds.custom(selectedColor.value.value),
                    textExpDate: 'Exp. Date',
                    textExpiry: 'MM/YY',
                  ),
                  _CreditCardForm(numberCard, selectedColor),
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
  const _CreditCardForm(this.numberCard, this.selectedColor);
  final ValueNotifier<String> numberCard;
  final ValueNotifier<Color> selectedColor;
  @override
  Widget build(BuildContext context) {
    final controllerNumberCard = useTextEditingController();
    final controllerHolderName = useTextEditingController();
    final controllerExpirationDate = useTextEditingController();
    final controllerCcv = useTextEditingController();

    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.amber,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
    ];

    void onColorSelected(Color color) {
      selectedColor.value = color;
    }

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
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: colors.map((colorItem) {
                final isSelected = colorItem == selectedColor.value;
                return GestureDetector(
                  onTap: () => onColorSelected(colorItem),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    width: ScreenSize.getWidth(context) * 0.08,
                    decoration: BoxDecoration(
                      color: colorItem,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(
                              color: Colors.black54,
                              width: 2,
                            )
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
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
                labelText: 'Vencimiento',
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
        ),
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
      padding: const EdgeInsets.all(5),
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
