import 'package:cajero/presetation/screens/home/cajero_home_view.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: CajeroHomeView.name,
    builder: (context, state) => const CajeroHomeView(),
  )
]);
