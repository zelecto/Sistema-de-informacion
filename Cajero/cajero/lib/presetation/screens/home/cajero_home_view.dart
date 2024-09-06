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
        height: ScreenSize.getHeight(context),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: ScreenSize.getWidth(context),
                height: ScreenSize.getHeight(context) * 0.2,
                fit: BoxFit.cover,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "¡Bienvenido(a) a nuestro cajero automático!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black87,
                  ),
                ),
              ),
              _CustomButton(
                img: 'assets/images/logo_nequi.png',
                onPressed: () {
                  context.push('/retiro_nequi');
                },
                textButton: 'Retirar de Nequi',
              ),
              _CustomButton(
                onPressed: () {
                  context.push('/retirar_credit_card');
                },
                img: 'assets/images/credit_card.png',
                textButton: 'Retirar con Tarjeta',
              ),
              _CustomButton(
                onPressed: () {
                  context.push('/register');
                },
                img: 'assets/images/registrarse.jpeg',
                textButton: 'Registrarse',
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
  final void Function() onPressed;

  const _CustomButton({
    required this.textButton,
    required this.img,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: ScreenSize.getHeight(context) * 0.3,
        height: ScreenSize.getHeight(context) * 0.18,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Color de fondo del botón
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Borde redondeado
            ),
            elevation: 5, // Elevación del botón
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                img,
                width: ScreenSize.getHeight(context) * 0.1,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              Text(
                textButton,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
