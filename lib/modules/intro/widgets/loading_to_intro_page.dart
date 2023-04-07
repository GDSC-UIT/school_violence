import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

void loadingToIntroPage() async {
  await 2.seconds.delay();
  Get.toNamed(AppRoutes.intro);
}
