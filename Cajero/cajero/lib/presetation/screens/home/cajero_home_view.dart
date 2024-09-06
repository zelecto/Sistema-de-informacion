import 'package:cajero/config/tools/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CajeroHomeView extends StatelessWidget {
  const CajeroHomeView({super.key});
  static const name = "cajero-home-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: ScreenSize.getWidth(context),
                height: ScreenSize.getHeight(context) * 0.2,
                fit: BoxFit.cover,
              ),
              const Text(
                "Bienvenido(a)! Por favor, elige una de las siguientes opciones",
                softWrap: true,
                maxLines: null,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              _CustomButton(
                img: 'assets/images/logo_nequi.png',
                onPressed: () {
                  context.push('/retiro_nequi');
                },
                textButton: 'retiros nequi',
              ),
              _CustomButton(
                onPressed: () {
                  context.push('/retirar_credit_card');
                },
                img: 'assets/images/credit_card.png',
                textButton: 'retiros tarjeta',
              ),
              _CustomButton(
                onPressed: () {
                  context.push('/register');
                },
                img: 'assets/images/registrarse.jpeg',
                textButton: 'registrarse',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  final String textButton;
  final String img;
  final onPressed;
  const _CustomButton({
    required this.textButton,
    required this.img,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        width: ScreenSize.getHeight(context) * 0.2,
        height: ScreenSize.getHeight(context) * 0.15,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(Colors.white.value),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                img,
                width: ScreenSize.getWidth(context) * 0.25,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                textButton,
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
