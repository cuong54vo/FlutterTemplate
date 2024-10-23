import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:childcaresoftware/commons/utils.dart';
import 'package:childcaresoftware/constants/api.dart';
import 'package:childcaresoftware/repositories/repositories.dart';
import 'package:childcaresoftware/service_locator.dart';
import 'package:childcaresoftware/services/local/local_pref.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(Uninitialized()) {
    on<AppStarted>(_mapAppStartedToState);
    on<LoggedIn>(_mapLoggedInToState);
    on<LoggedOut>(_mapLoggedOutToState);
  }

  Future<void> _mapAppStartedToState(
    AppStarted event, Emitter<AuthenticationState> emit) async {
  try {
    final token = await locator<UserRepository>().getToken();
    
    if (token == null) {
      // Nếu token là null, xử lý tại đây
      final isFirstTime = await locator<SettingsRepository>().getFirstTime();
      emit(Unauthenticated(isFirstTime: isFirstTime));
      return; // Kết thúc hàm mà không cần giá trị trả về
    }

    API.TOKEN = token; // Sử dụng token mà không cần dùng toán tử !
    final role = await locator<UserRepository>().getRole();
    final userProfile = await locator<UserRepository>().getProfileLocal();
    
    final isFirstTime = await locator<SettingsRepository>().getFirstTime();
    await Future.delayed(const Duration(milliseconds: 3000));
    emit(Authenticated());
    
  } catch (error) {
    emit(Uninitialized()); // Uninitialized
  }
}


  Future<FutureOr<void>> _mapLoggedInToState(
      LoggedIn event, Emitter<AuthenticationState> emit) async {
    emit(Authenticated());
  }

  Future<FutureOr<void>> _mapLoggedOutToState(
      LoggedOut event, Emitter<AuthenticationState> emit) async {
    try {
      await locator<UserRepository>().logOut();
      emit(Unauthenticated(isFirstTime: false));
    } catch (e) {
      print(e);
    } finally {
      await LocalPref.clearAll();
      await Utils.deleteCacheDir();
      await Utils.deleteAppDir();
      // FirebaseMessaging.instance.deleteToken();
      await locator<SettingsRepository>().saveFirstTime(false);
      emit(Unauthenticated());
    }
  }
}
