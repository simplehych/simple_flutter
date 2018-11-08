import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:simple_flutter/http/address.dart';
import 'package:simple_flutter/http/base_result.dart';
import 'package:simple_flutter/http/http_manager.dart';
import 'package:simple_flutter/redux/global_state.dart';
import 'package:simple_flutter/style/string/strings.dart';
import 'package:simple_flutter/utils/log.dart';
import 'package:simple_flutter/utils/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  static const String _TAG = "_LoginPageState";
  String name, password;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFiledKey =
      GlobalKey<FormFieldState<String>>();

  /// 自动校验会一直校验，应该影响性能，最后提交的时候校验即可
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GlobalState>(
      builder: (context, store) {
        return Scaffold(
          key: _scaffoldKey,
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
                      key: _passwordFiledKey,
                      helperText: "不能超过八个字符",
                      labelText: "密码",
                      decorationIcon: Icon(Icons.keyboard),
                      onSaved: (value) {
                        password = value;
                      },
                    ),
                    const SizedBox(height: 24.0),
                    TextFormField(
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
                        child: Text("登录"),
                        onPressed: _handleSubmit,
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
        Toast.showShort("登录成功 ${result.data["username"]}");
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

    final RegExp nameExp = RegExp(r'^[A-Za-z ]+@');
    if (!nameExp.hasMatch(value)) {
      return "请输入合法用户名";
    }
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

class PasswordField extends StatefulWidget {
  PasswordField(
      {this.key,
      this.hintText,
      this.labelText,
      this.helperText,
      this.decorationIcon,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted});

  final Key key;
  final String hintText;
  final String labelText;
  final String helperText;
  final Icon decorationIcon;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  State<StatefulWidget> createState() {
    return _PasswordFieldState();
  }
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.hintText,
        icon: widget.decorationIcon,
        suffixIcon: GestureDetector(
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
