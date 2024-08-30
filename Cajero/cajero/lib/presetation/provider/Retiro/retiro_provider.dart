import 'package:cajero/domain/entity/retiro.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'retiro_provider.g.dart';

@riverpod
Retiro retiroProvider(RetiroProviderRef ref, Retiro retiro) {
  return retiro;
}
