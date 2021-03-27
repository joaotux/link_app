import 'package:link_app/modules/store/pageable.dart';
import 'package:mobx/mobx.dart';

part 'pageable_controller.g.dart';

class PageableController = _PageableControllerBase with _$PageableController;

abstract class _PageableControllerBase with Store {
  @observable
  Pageable? _pageable;

  @observable
  int _currentPage = 0;

  Pageable? get pageable => _pageable;

  @action
  setPageable(Pageable value) => _pageable = value;

  int get currentPage => _currentPage;

  @action
  increment() => _currentPage++;

  @action
  decrement() => _currentPage--;

  @action
  setCurrentPage(int value) => _currentPage = value;
}
