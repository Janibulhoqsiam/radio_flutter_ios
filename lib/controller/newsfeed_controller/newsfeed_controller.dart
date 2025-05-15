import 'package:adradio/utils/basic_screen_imports.dart';

import '../../backend/model/dashboard/dashboard_model.dart';
import '../../backend/services/dashboard_services/dashboard_service.dart';

class NewsfeedController extends GetxController with DashboardService{
  RxInt selectedIndex = 0.obs;
  RxInt carouselSliderItemCount = 3.obs;

  @override
  void onInit() {
    newsfeedProcess();
    super.onInit();
  }

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  //
  // late NewsfeedModel _dashboardModel;
  // NewsfeedModel get dashboardModel => _dashboardModel;

  late NewsfeedModel _dashboardModel;
  NewsfeedModel get dashboardModel => _dashboardModel;

  ///* Get Dashboard in process
  Future<NewsfeedModel?> newsfeedProcess() async {
    _isLoading.value = true;
    update();
    await newsfeedProcessApi().then((value) {
      _dashboardModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _dashboardModel;
  }









}