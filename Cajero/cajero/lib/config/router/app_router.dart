import 'package:animate_do/animate_do.dart';
import 'package:cajero/presetation/screens/home/cajero_home_view.dart';
import 'package:cajero/presetation/screens/register/register_view.dart';
import 'package:cajero/presetation/screens/retirar/acount_nequi/codigo_seguridad_acount_nequi.dart';
import 'package:cajero/presetation/screens/retirar/acount_nequi/retirar_acount_nequi.dart';
import 'package:cajero/presetation/screens/retirar/credit_card/retirar_credit_card_home_view.dart';
import 'package:cajero/presetation/screens/retirar/credit_card/retirar_credit_card_password.dart';
import 'package:cajero/presetation/screens/retirar/widget/monto_selecionar_view.dart';
import 'package:cajero/presetation/screens/retirar/widget/retirar_dinero.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: CajeroHomeView.name,
    builder: (context, state) => FadeIn(child: const CajeroHomeView()),
  ),
  GoRoute(
    path: '/register',
    name: RegisterView.name,
    builder: (context, state) => FadeIn(child: const RegisterView()),
  ),
  GoRoute(
    path: '/retirar_credit_card',
    name: RetirarCreditCard.name,
    builder: (context, state) => FadeIn(child: const RetirarCreditCard()),
  ),
  GoRoute(
    path: '/monto_selecionar',
    name: MontoSelecionarView.name,
    builder: (context, state) => FadeIn(child: const MontoSelecionarView()),
  ),
  GoRoute(
    path: '/recibo',
    name: ReciboView.name,
    builder: (context, state) => FadeIn(child: const ReciboView()),
  ),
  GoRoute(
    path: '/codigo-CCV',
    name: RetirarCreditCardPassword.name,
    builder: (context, state) =>
        FadeIn(child: const RetirarCreditCardPassword()),
  ),
  GoRoute(
    path: '/retiro_nequi',
    name: RetirarAcountNequiView.name,
    builder: (context, state) => FadeIn(child: const RetirarAcountNequiView()),
  ),
  GoRoute(
    path: '/codigo_temporal',
    name: CodeTemporalAcountNequi.name,
    builder: (context, state) => FadeIn(child: const CodeTemporalAcountNequi()),
  ),
]);
