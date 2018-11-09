import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:simple_flutter/http/address.dart';
import 'package:simple_flutter/http/base_result.dart';
import 'package:simple_flutter/http/http_manager.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/style/string/strings.dart';
import 'package:simple_flutter/utils/toast.dart';
import 'package:simple_flutter/widget/password_field.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  static const String _TAG = "_RegisterPageState";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _usernameFiledKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _passwordFiledKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _repasswordFiledKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _moodFiledKey =
  GlobalKey<FormFieldState<String>>();
  bool _autoValidate = false;
  String name, password, repassword;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Strings.of(context).register()),
          ),
          body: SafeArea(
              child: Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 24.0),
                        TextFormField(
//                          key: _usernameFiledKey,
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
                          validator: (value) {
                            if (value.isEmpty) {
                              return "用户名为空";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24.0),
                        PasswordField(
//                          key: _passwordFiledKey,
                          labelText: "密码",
                          decorationIcon: Icon(Icons.keyboard),
                          onSaved: (value) {
                            password = value;
                          },
                        ),
                        const SizedBox(height: 24.0),
                        PasswordField(
//                          key: _repasswordFiledKey,
                          labelText: "确认密码",
                          decorationIcon: Icon(Icons.keyboard),
                          onSaved: (value) {
                            repassword = value;
                          },
                        ),
                        const SizedBox(height: 24.0),
                        TextFormField(
//                          key: _moodFiledKey,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "介绍你自己",
                              helperText: "简单明了",
                              labelText: "个性签名"),
                        ),
                        const SizedBox(height: 24.0),
                        Center(
                          child: RaisedButton(
                            color: store.state.themeData.primaryColor,
                            child: Text("注册"),
                            onPressed: _handleSubmit,
                          ),
                        ),
                      ],
                    ),
                  ))),
        );
      },
    );
  }

  _handleSubmit() async {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      BaseResultData result = await HttpManager.post(Address.register(),
          params: {
            "username": name,
            "password": password,
            "repassword": repassword
          });
      if (result.errorCode == 0) {
        Toast.showShort("注册成功");
        Navigator.pop(context, result.data["username"]);
      } else {
        Toast.showShort(result.errorMsg.toString());
      }
    } else {
      _autoValidate = true;
      Toast.showShort("登录验证失败，请输入自动校验结果");
    }
  }
}
