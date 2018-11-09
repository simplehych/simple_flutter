import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/http/address.dart';
import 'package:simple_flutter/http/base_result.dart';
import 'package:simple_flutter/http/http_manager.dart';
import 'package:simple_flutter/manager/constant.dart';
import 'package:simple_flutter/manager/navigator_manager.dart';
import 'package:simple_flutter/page/register_page.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/storage/db/provider/user_db_provider.dart';
import 'package:simple_flutter/storage/sp/sp_storage.dart';
import 'package:simple_flutter/style/string/strings.dart';
import 'package:simple_flutter/utils/log.dart';
import 'package:simple_flutter/utils/toast.dart';
import 'package:simple_flutter/widget/password_field.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  static const String _TAG = "_LoginPageState";
  String name, password;
  String initialName;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _loginpasswordFiledKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _loginuserFiledKey =
      GlobalKey<FormFieldState<String>>();

  TextEditingController editingController = new TextEditingController();

  /// 自动校验会一直校验，影响性能？？？？，最后提交的时候校验即可
  bool _autoValidate = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Strings.of(context).login()),
          ),
          body: SafeArea(
            child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              onWillPop: _warnUserAboutInvalidData,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 24.0),
                    TextFormField(
                      key: _loginuserFiledKey,
                      controller: editingController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          filled: true,
                          icon: Icon(Icons.person),
                          hintText: "",
                          labelText: "用户名"),
                      onSaved: (value) {
                        name = value;
                      },
                      validator: _validateName,
                    ),
                    const SizedBox(height: 24.0),
                    PasswordField(
//                      key: _loginpasswordFiledKey,
                      labelText: "密码",
                      decorationIcon: Icon(Icons.keyboard),
                      onSaved: (value) {
                        password = value;
                      },
                    ),
                    const SizedBox(height: 24.0),
                    Center(
                      child: RaisedButton(
                        child: Text("登录"),
                        onPressed: _handleSubmit,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        child: Text("立即注册"),
                        onTap: () async {
                          String tmp = await NavigatorManager.goPage(
                              context, RegisterPage());
                          Log.i(_TAG, "tmp: $tmp");
                          editingController.text = tmp;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _handleSubmit() async {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      BaseResultData result = await HttpManager.post(Address.login(),
          params: {"username": name, "password": password});
      if (result.errorCode == 0) {
        Toast.showShort("用户${result.data["username"]}登录成功");
        await SpStorage.save(Constant.KEY_IS_LOGIN, true);
        UserDbProvider userDbProvider = new UserDbProvider();
        await userDbProvider.insert(UserDbProvider.from(result.data));
        Navigator.pop(context, result.data["username"]);
      }
      Log.i(_TAG, result.toString());
    } else {
      _autoValidate = true;
      Toast.showShort("登录验证失败，请输入自动校验结果");
    }
  }

  String _validateName(String value) {
    if (value.isEmpty) {
      return "用户名不允许为空";
    }

//    final RegExp nameExp = RegExp(r'^[A-Za-z ]+@');
//    if (!nameExp.hasMatch(value)) {
//      return "请输入合法用户名";
//    }
    return null;
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState formState = _formKey.currentState;
    if (formState == null || formState.validate()) {
      return true;
    }

    return await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("是否退出"),
                content: Text("根据您的意愿请进行选择:"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("YES"),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                  FlatButton(
                    child: Text("No"),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              );
            }) ??
        false;
  }
}
