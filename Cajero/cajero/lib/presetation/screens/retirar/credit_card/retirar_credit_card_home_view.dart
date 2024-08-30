import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/extra/card_type.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:cajero/config/tools/color_util.dart';
import 'package:cajero/config/tools/screen_size.dart';
import 'package:cajero/domain/entity/credit_card.dart';
import 'package:cajero/domain/infrastructure/credit_card_data.dart';
import 'package:cajero/presetation/provider/credit_cart/credit_cart_provaider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RetirarCreditCard extends HookConsumerWidget {
  const RetirarCreditCard({super.key});
  static const String name = 'retirar-credit-card';
  final textStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

  Future<List<CreditCardEntity>> fetchCreditCards() async {
    return await getCreditCardList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var showBackSide = useState(false);
    var draggedCard = useState<CreditCardEntity?>(null);
    var enableButton = useState(false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bancolombia'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: ScreenSize.getWidth(context),
        height: ScreenSize.getHeight(context),
        child: Column(
          children: [
            const SizedBox(height: 10),
            DragTarget<CreditCardEntity>(
              onAccept: (data) {
                draggedCard.value = data;
                enableButton.value = true;
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: ScreenSize.getWidth(context),
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: draggedCard.value == null
                        ? const Text('Arrastre la tarjeta hasta aquí',
                            style: TextStyle(fontSize: 18))
                        : CreditCard(
                            cardNumber: draggedCard.value!.cardNumber,
                            cardExpiry: draggedCard.value!.cardExpiry,
                            cardHolderName: draggedCard.value!.cardHolderName,
                            cvv: draggedCard.value!.cvv,
                            bankName: 'Bancolombia',
                            cardType: CardType.masterCard,
                            showBackSide: showBackSide.value,
                            frontBackground: CardBackgrounds.custom(
                                draggedCard.value!.color.value),
                            backBackground: CardBackgrounds.custom(
                                draggedCard.value!.color.value),
                            frontTextColor:
                                ColorUtil.isColorLight(draggedCard.value!.color)
                                    ? Colors.black
                                    : Colors.white,
                            textExpDate: 'Exp. Date',
                            textExpiry: 'MM/YY',
                          ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: ScreenSize.getWidth(context),
              height: ScreenSize.getHeight(context) * 0.4,
              child: FutureBuilder<List<CreditCardEntity>>(
                future: fetchCreditCards(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Error al cargar tarjetas'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No hay tarjetas disponibles'));
                  } else {
                    return PageView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final creditCard = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Draggable<CreditCardEntity>(
                            data: creditCard,
                            feedback: Opacity(
                              opacity: 0.7,
                              child: CreditCard(
                                cardNumber: creditCard.cardNumber,
                                cardExpiry: creditCard.cardExpiry,
                                cardHolderName: creditCard.cardHolderName,
                                cvv: creditCard.cvv,
                                bankName: 'Bancolombia',
                                cardType: CardType.masterCard,
                                showBackSide: showBackSide.value,
                                frontBackground: CardBackgrounds.custom(
                                    creditCard.color.value),
                                backBackground: CardBackgrounds.custom(
                                    creditCard.color.value),
                                frontTextColor:
                                    ColorUtil.isColorLight(creditCard.color)
                                        ? Colors.black
                                        : Colors.white,
                                textExpDate: 'Exp. Date',
                                textExpiry: 'MM/YY',
                              ),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.3,
                              child: CreditCard(
                                cardNumber: creditCard.cardNumber,
                                cardExpiry: creditCard.cardExpiry,
                                cardHolderName: creditCard.cardHolderName,
                                cvv: creditCard.cvv,
                                bankName: 'Bancolombia',
                                cardType: CardType.masterCard,
                                showBackSide: showBackSide.value,
                                frontBackground: CardBackgrounds.custom(
                                    creditCard.color.value),
                                backBackground: CardBackgrounds.custom(
                                    creditCard.color.value),
                                frontTextColor:
                                    ColorUtil.isColorLight(creditCard.color)
                                        ? Colors.black
                                        : Colors.white,
                                textExpDate: 'Exp. Date',
                                textExpiry: 'MM/YY',
                              ),
                            ),
                            child: CreditCard(
                              cardNumber: creditCard.cardNumber,
                              cardExpiry: creditCard.cardExpiry,
                              cardHolderName: creditCard.cardHolderName,
                              cvv: creditCard.cvv,
                              bankName: 'Bancolombia',
                              cardType: CardType.masterCard,
                              showBackSide: showBackSide.value,
                              frontBackground: CardBackgrounds.custom(
                                  creditCard.color.value),
                              backBackground: CardBackgrounds.custom(
                                  creditCard.color.value),
                              frontTextColor:
                                  ColorUtil.isColorLight(creditCard.color)
                                      ? Colors.black
                                      : Colors.white,
                              textExpDate: 'Exp. Date',
                              textExpiry: 'MM/YY',
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: FilledButton(
                onPressed: enableButton.value
                    ? () {
                        ref.read(creditCardProvider.notifier).state =
                            draggedCard.value!;
                        context.go('/monto_selecionar');
                      }
                    : null,
                child: const Text("Continuar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
