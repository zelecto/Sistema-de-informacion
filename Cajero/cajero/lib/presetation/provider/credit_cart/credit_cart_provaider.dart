import 'package:cajero/domain/entity/credit_card.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'credit_cart_provaider.g.dart';

@Riverpod(keepAlive: true)
CreditCardEntity creditCartProvaider(
    CreditCartProvaiderRef ref, CreditCardEntity creditCardEntity) {
  return creditCardEntity;
}
