import 'package:cajero/domain/entity/acunt_nequi.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Proveedor global de CreditCardEntity
final acountNequiProvaider = StateProvider<AcountNequi?>((ref) => null);
