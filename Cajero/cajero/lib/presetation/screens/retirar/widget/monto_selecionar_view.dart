import 'package:cajero/config/tools/screen_size.dart';
import 'package:cajero/domain/entity/credit_card.dart';
import 'package:cajero/domain/entity/retiro.dart';
import 'package:cajero/presetation/provider/Retiro/retiro_provider.dart';
import 'package:cajero/presetation/provider/credit_cart/credit_cart_provaider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class MontoSelecionarView extends HookConsumerWidget {
  const MontoSelecionarView({super.key});
  static const name = 'monto-selecionar-view';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CreditCardEntity? creditCardEntity = ref.watch(creditCardProvider);
    final numberFormat = NumberFormat('#,##0.00', 'es_CO');
    const List<int> listValores = [
      10000,
      20000,
      50000,
      100000,
      200000,
      300000,
      500000,
      1000000
    ];
    final controllerValue = useTextEditingController();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Selecione el monto a retirar',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Image.asset(
                  'assets/images/dinero.png',
                  fit: BoxFit.cover,
                  height: ScreenSize.getHeight(context) * 0.3,
                  width: ScreenSize.getWidth(context),
                ),
                SizedBox(
                  height: ScreenSize.getHeight(context) * 0.45,
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 2.5,
                    children: listValores.map((value) {
                      return FloatingActionButton(
                        heroTag: value,
                        onPressed: () {
                          // ignore: unused_local_variable
                          late Retiro retiro;
                          if (creditCardEntity != null) {
                            retiro = Retiro(
                              montoRetirar: value,
                              creditCard: creditCardEntity,
                            );
                            context.go('/codigo-CCV');
                          } else {
                            retiro = Retiro(montoRetirar: 1000);
                          }
                        },
                        backgroundColor: Color(Colors.green.shade300.value),
                        child: Text(
                          numberFormat.format(value),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: ScreenSize.getWidth(context) * 0.6,
                  height: ScreenSize.getHeight(context) * 0.1,
                  child: FloatingActionButton(
                    heroTag: 'Solicitar un valor diferente',
                    backgroundColor: Color(Colors.green.shade300.value),
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Digite el monto a retirar'),
                          content: SizedBox(
                            height: ScreenSize.getHeight(context) * 0.16,
                            child: _AmountField(
                              controller: controllerValue,
                              hintText: '10.000,00',
                              labelText: 'Monto',
                              onSubmit: () {
                                late Retiro retiro;
                                if (creditCardEntity != null) {
                                  retiro = Retiro(
                                    montoRetirar: int.parse(
                                      controllerValue.text
                                          .replaceAll(RegExp(r'\D'), ''),
                                    ),
                                    creditCard: creditCardEntity,
                                  );
                                  context.go('/codigo-CCV');
                                } else {
                                  retiro = Retiro(montoRetirar: 1000);
                                }
                                ref.watch(retiroProvider.notifier).state =
                                    retiro;
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Solicitar un valor diferente",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class _AmountField extends HookWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final VoidCallback onSubmit;

  const _AmountField({
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###', 'es_ES');
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isValid = useState(false);

    const validValues = [10000, 20000, 50000, 100000];

    void formatAmount(String value) {
      final rawText = value.replaceAll(RegExp(r'\D'), '');
      final intValue = int.tryParse(rawText) ?? 0;

      final formattedText = intValue > 2700000
          ? formatter.format(2700000)
          : formatter.format(intValue);

      if (value.isNotEmpty) {
        controller.value = TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      }
    }

    void validateForm() {
      final formIsValid = formKey.currentState?.validate() ?? false;
      isValid.value = formIsValid;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(7),
            ],
            decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onChanged: (value) {
              formatAmount(value);
              validateForm();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio';
              }

              final rawText = value.replaceAll(RegExp(r'\D'), '');
              final intValue = int.tryParse(rawText) ?? 0;

              if (intValue < 10000) {
                return 'El monto debe ser al menos 10,000';
              }
              if (intValue > 2700000) {
                return 'El monto no puede ser mayor de 2,700,000';
              }
              if (!validValues.contains(intValue) && intValue % 10000 != 0) {
                return 'El monto debe ser un múltiplo de 10,000, 20,000, 50,000, o 100,000';
              }

              return null;
            },
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: isValid.value ? onSubmit : null,
          child: const Text('Enviar'),
        ),
      ],
    );
  }
}
