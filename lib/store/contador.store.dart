import 'package:mobx/mobx.dart';

part 'contador.store.g.dart';

abstract class _ContadorStore with Store {
  @observable
  int contador = 0;

  @action
  void incrementar() {
    contador++;
  }
}

class ContadorStore = _ContadorStore with _$ContadorStore;
