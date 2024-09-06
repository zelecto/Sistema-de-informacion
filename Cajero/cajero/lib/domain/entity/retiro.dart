import 'package:cajero/domain/entity/acunt_nequi.dart';
import 'package:cajero/domain/entity/credit_card.dart';

class Retiro {
  final int montoRetirar;
  final CreditCardEntity? creditCard;
  final AcountNequi? acuntNequi;

  Retiro({required this.montoRetirar, this.creditCard, this.acuntNequi});
}
