import 'package:cajero/config/tools/screen_size.dart';
import 'package:cajero/presetation/screens/register/acount_nequi_from.dart';
import 'package:cajero/presetation/screens/register/credt_card_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RegisterView extends HookWidget {
  const RegisterView({super.key});
  static const name = 'register-view';

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
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
                  CreditCardForm(),
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
