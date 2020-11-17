import 'package:demo/src/model/user_model.dart';
import 'package:demo/src/repository/user_Api_Service.dart';
import 'package:demo/src/repository/user_repository.dart';
import 'package:demo/src/utils/apiresponse_model.dart';
import 'package:demo/src/utils/errorapiresponse_model.dart';
import 'package:f_logs/model/flog/flog.dart';

class UserBloc {
  UserRepository _repository;

  /* Future<ApiResponse> createUser(User user) async {
    _progressDialog = ProgressDialog(_context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    _progressDialog.style(message: "Se guardó");
    await _progressDialog.show();
    bool resp = await _repository.validateExpirationSession();
    if (resp) {
      ApiResponse apiResponse = await _repository.insertUser(user, accessToken);
      if (apiResponse.statusResponse == 200) {
        apiResponse.message = "Se guardó correctamente";
      } else {
        ErrorApiResponse error = apiResponse.object;
        FLog.logThis(
            className: " * ClassName: UserBloc",
            methodName: " * MethodName: createUser",
            text: " * Message: Status error" +
                error.status.toString() +
                " Message: " +
                error.message,
            type: LogLevel.ERROR,
            dataLogType: DataLogType.DEVICE.toString());
        await FLog.exportLogs();
      }
      await _progressDialog.hide();
    }
  }*/
}
