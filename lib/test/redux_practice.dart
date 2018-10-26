import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ReduxWidget extends StatelessWidget {
  final store = new Store<PracticeState>(practiceReducer,
      initialState: PracticeState(userInfo: User()));

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: MaterialApp(
        home: Center(
          child: Text('redux'),
        ),
      ),
    );
  }
}

class ReduxAnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<PracticeState, User>(
      converter: (store) => store.state.userInfo,
      builder: (context, userInfo) {
        //获取值
        var userInfo2 = StoreProvider.of(context).state.userInfo;
        StoreProvider.of(context).dispatch(User());

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text(
            userInfo.name,
          ),
        );
      },
    );
  }
}

class PracticeState {
  User userInfo;

  PracticeState({this.userInfo});
}

PracticeState practiceReducer(PracticeState state, action) {
  return PracticeState(
    userInfo: UserReducer(state.userInfo, action),
  );
}

final UserReducer = combineReducers<User>([
  TypedReducer<User, UpdateUserAction>(_updateLoaded),

]);

User _updateLoaded(User user, action) {
  user = action.userInfo;
  return user;
}

class User {
  String name;
}

class UpdateUserAction {
  final User userInfo;

  UpdateUserAction(this.userInfo);
}
