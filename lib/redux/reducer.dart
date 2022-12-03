
import 'package:it_valey_hackathon_2022/redux/actions/SetUserState.dart';

import 'AppState.dart';
import 'actions/SetAppState.dart';

AppState reducer(AppState state, dynamic action){
  switch (action.runtimeType){
    case SetAppState:
      return _setAppStateFunction(state, action);
    case SetUserState:
      return _addExpenseToAppStateFunction(state, action);
    default:
      return state;
  }
}

AppState _setAppStateFunction(AppState state, dynamic action){
  return AppState(
      user: action.user
  );
}

AppState _addExpenseToAppStateFunction(AppState state, dynamic action){
  return AppState(
      user: action.user
  );
}