import 'package:cajero/domain/entity/acunt_nequi.dart';
import 'package:cajero/domain/entity/credit_card.dart';

class Retiro {
  final int montoRetirar;
  final CreditCardEntity? creditCard;
  final AcuntNequi? acuntNequi;

  Retiro({required this.montoRetirar, this.creditCard, this.acuntNequi});
}
