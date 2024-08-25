import 'package:cajero/config/tools/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CajeroHomeView extends StatelessWidget {
  const CajeroHomeView({super.key});
  static const name = "cajero-home-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FilledButton(
                    onPressed: () {
                      context.push('/register');
                    },
                    child: const Text("Reguistrarse")))
          ],
          title: Row(
            children: [
              Image.asset(
                'assets/images/Icono_Bancolombia.png',
                width: ScreenSize.getWidth(context) * 0.1,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Bancolombia",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/home.png',
                    width: ScreenSize.getWidth(context) * 0.4,
                    height: ScreenSize.getHeight(context) * 0.3,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: ScreenSize.getWidth(context) * 0.5,
                    child: const Text(
                      "Bienvenido(a)! Por favor, elige una de las siguientes opciones",
                      softWrap: true,
                      maxLines: null,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenSize.getHeight(context) * 0.15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: ScreenSize.getWidth(context) * 0.4,
                    height: ScreenSize.getHeight(context) * 0.05,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      child: const Row(
                        children: [
                          Icon(Icons.arrow_back_ios_new_rounded),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Retiros Nequi")
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: ScreenSize.getWidth(context) * 0.4,
                    height: ScreenSize.getHeight(context) * 0.05,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      child: const Row(
                        children: [
                          Spacer(),
                          Text("Retiro Tarjeta"),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
