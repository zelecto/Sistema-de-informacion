import 'package:animate_do/animate_do.dart';
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
  static const String name = 'retirar-credit-card-password';
  final textStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

  Future<List<CreditCardEntity>> fetchCreditCards() async {
    return await getCreditCardList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var showBackSide = useState(false);
    var draggedCard = useState<CreditCardEntity?>(null);
    var enableButton = useState(false);
    final PageController pageController = PageController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/Icono_Bancolombia.png',
              width: 40,
            ),
            const Text(
              'Bancolombia',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          DragTarget<CreditCardEntity>(
            // ignore: deprecated_member_use
            onAccept: (data) {
              draggedCard.value = data;
              enableButton.value = true;
            },
            builder: (context, candidateData, rejectedData) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  width: ScreenSize.getWidth(context),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: draggedCard.value == null
                      ? const Column(
                          children: [
                            Text(
                              'Coloca tu tarjeta aquí arrastrándola',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: _SkeletonCreditCard(),
                            ),
                          ],
                        )
                      : FadeIn(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              CreditCard(
                                cardNumber: draggedCard.value!.cardNumber,
                                cardExpiry: draggedCard.value!.cardExpiry,
                                cardHolderName:
                                    draggedCard.value!.cardHolderName,
                                cvv: draggedCard.value!.cvv,
                                bankName: 'Bancolombia',
                                cardType: CardType.masterCard,
                                showBackSide: showBackSide.value,
                                frontBackground: CardBackgrounds.custom(
                                    draggedCard.value!.color.value),
                                backBackground: CardBackgrounds.custom(
                                    draggedCard.value!.color.value),
                                frontTextColor: ColorUtil.isColorLight(
                                        draggedCard.value!.color)
                                    ? Colors.black
                                    : Colors.white,
                                textExpDate: 'Exp. Date',
                                textExpiry: 'MM/YY',
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      draggedCard.value = null;
                                    },
                                    icon: const Icon(Icons.delete_outline),
                                    color: Color(Colors.red.value),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showBackSide.value = !showBackSide.value;
                                    },
                                    icon: const Icon(Icons.replay_rounded),
                                    color: Color(Colors.blue.value),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                    color: Color(Colors.green.value),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                ),
              );
            },
          ),
          const Spacer(),
          SizedBox(
            width: ScreenSize.getWidth(context),
            height: ScreenSize.getHeight(context) * 0.25,
            child: FutureBuilder<List<CreditCardEntity>>(
              future: fetchCreditCards(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error al cargar tarjetas'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No hay tarjetas disponibles'));
                } else {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PageView.builder(
                          controller: pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final creditCard = snapshot.data![index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                                    showBackSide: false,
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
                                    showBackSide: false,
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
                                  height: ScreenSize.getHeight(context) * 0.3,
                                  cardNumber: creditCard.cardNumber,
                                  cardExpiry: creditCard.cardExpiry,
                                  cardHolderName: creditCard.cardHolderName,
                                  cvv: creditCard.cvv,
                                  bankName: 'Bancolombia',
                                  cardType: CardType.masterCard,
                                  showBackSide: false,
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
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new),
                          onPressed: () {
                            if (pageController.hasClients) {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            if (pageController.hasClients) {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
          ),
        ],
      ),
    );
  }
}

class _SkeletonCreditCard extends StatelessWidget {
  const _SkeletonCreditCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.getHeight(context) * 0.23,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[400], // Fondo sólido
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 25,

            width: 150, // Ancho de la fecha de expiración
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
          Container(
            height: 25,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
          Container(
            height: 25,

            width: 150, // Ancho de la fecha de expiración
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
          Container(
            height: 25,
            width: 200, // Ancho del nombre del titular
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
