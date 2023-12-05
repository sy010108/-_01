import 'package:logger/logger.dart';

import 'package:kkn_/connect/connect.dart';

class HomeDataLoader {
  String location = "/home";

  String userid;

  late String r;

  HomeDataLoader(this.userid);

  dynamic homeDataLoadProcess() async {
    Connect connect = Connect();

    Logger().i(await connect.sendProcess(location, userid));

    r = await connect.sendProcess(location, userid);
  }
}
