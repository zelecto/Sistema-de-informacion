import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cajero/domain/entity/credit_card.dart';

// Proveedor global de CreditCardEntity
final creditCardProvider = StateProvider<CreditCardEntity?>((ref) => null);
