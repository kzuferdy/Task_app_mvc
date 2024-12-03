import 'package:get/get.dart';
import 'package:manajemen_proyek/common/enums.dart';
import 'package:manajemen_proyek/data/datasource/agenda_remote_data_source.dart';
import 'package:manajemen_proyek/data/models/agenda_model.dart';


class AgendaTodayController extends GetxController {
  final _state = AgendaTodayState(
    message: '',
    statusRequest: StatusRequest.init,
    list: [],
  ).obs;
  AgendaTodayState get state => _state.value;
  set state(AgendaTodayState n) => _state.value = n;

  Future fetchData(int userId) async {
    state = state.copyWith(
      statusRequest: StatusRequest.loading,
    );

    final (
      success,
      message,
      agendas,
    ) = await AgendaRemoteDataSource.today(userId);

    state = state.copyWith(
      statusRequest: success ? StatusRequest.success : StatusRequest.failed,
      message: message,
      list: agendas ?? [],
    );
  }

  static delete() => Get.delete<AgendaTodayController>(force: true);
}

class AgendaTodayState {
  final StatusRequest statusRequest;
  final String message;
  final List<AgendaModel> list;

  AgendaTodayState({
    required this.statusRequest,
    required this.message,
    required this.list,
  });

  AgendaTodayState copyWith({
    StatusRequest? statusRequest,
    String? message,
    List<AgendaModel>? list,
  }) {
    return AgendaTodayState(
      statusRequest: statusRequest ?? this.statusRequest,
      message: message ?? this.message,
      list: list ?? this.list,
    );
  }
}