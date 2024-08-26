import 'package:cajero/config/tools/color_util.dart';
import 'package:cajero/config/tools/screen_size.dart';
import 'package:cajero/presetation/screens/register/acount_nequi_from.dart';
import 'package:cajero/presetation/screens/register/credt_card_form.dart';
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
                  CreditCardForm(
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
                  Image.asset(
                    'assets/images/nequi.png',
                    width: ScreenSize.getWidth(context) * 0.8,
                  ),
                  const AcountNequiFrom()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
