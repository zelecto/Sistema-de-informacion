import 'package:cajero/presetation/screens/home/cajero_home_view.dart';
import 'package:cajero/presetation/screens/register/register_view.dart';
import 'package:cajero/presetation/screens/retirar/credit_card/retirar_credit_card.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: CajeroHomeView.name,
    builder: (context, state) => const CajeroHomeView(),
  ),
  GoRoute(
    path: '/register',
    name: RegisterView.name,
    builder: (context, state) => const RegisterView(),
  ),
  GoRoute(
    path: '/retirar_credit_card',
    name: RetirarCreditCard.name,
    builder: (context, state) => const RetirarCreditCard(),
  ),
]);
