import 'package:adradio/backend/local_storage/local_storage.dart';
import 'package:adradio/backend/model/common/common_success_model.dart';
import 'package:adradio/views/contact_screen/contactscreen.dart';
import 'package:adradio/views/livetvweb_screen/livetvweb_screen_mobile.dart';

import '../../backend/services/auth_service/auth_service.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../views/live_streaming_screen/live_streaming_screen.dart';
import '../../views/newsfeed_screen/newsfeed_screen.dart';
import '../../views/show_schedule_screen/show_schedule_screen.dart';

class NavigationController extends GetxController with AuthService{


  RxInt selectedIndex = 2.obs;
  final RxBool isRoutesIndex = false.obs;

  final List body = [
    NewsfeedScreen(),
    livetvweb_screen(),
    LiveStreamingScreen(),
    ShowScheduleScreen(),
    contactscreen(),

  ];

  final List appTitleList = [Strings.newsfeed,Strings.LiveTv, "",Strings.showSchedule, Strings.Contacts];
  RxString appTitle = ''.obs;
  get onTapNotification => Get.toNamed(Routes.notificationScreen);
  /// ------------------------------------- >>
  final _isLogOutLoading = false.obs;
  bool get isLogOutLoading => _isLogOutLoading.value;

  late CommonSuccessModel _logOutModel;
  CommonSuccessModel get logOutModel => _logOutModel;

  ///* LogOut in process
  Future<CommonSuccessModel> logOutProcess() async {
    _isLogOutLoading.value = true;
    update();

    await logOutProcessApi(body: {}).then((value) {
      _logOutModel = value!;
      LocalStorage.logout();
      Get.offAllNamed(Routes.loginScreen);
      _isLogOutLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLogOutLoading.value = false;
    update();
    return _logOutModel;
  }

}