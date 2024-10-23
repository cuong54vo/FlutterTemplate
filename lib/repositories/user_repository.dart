import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:childcaresoftware/constants/api.dart';
import 'package:childcaresoftware/constants/pref_key.dart';
import 'package:childcaresoftware/models/models.dart';
import 'package:childcaresoftware/service_locator.dart';
import 'package:childcaresoftware/services/local/local_pref.dart';
import 'package:childcaresoftware/services/remote/network_service.dart';

import '../commons/variables.dart';

class UserRepository {
  final NetworkService _networkService = NetworkService.instance;

  Future<LoginResponse> logIn(String email, String password) async {
    final response = await _networkService.post(UserAPI.LOGIN_URL, data: {
      'email': email,
      'password': password,
      'platform': Platform.isAndroid ? 'android' : 'ios',
    });
    return LoginResponse.fromJson(response);
  }

  Future<dynamic> register(String firstName, String lastName, String email, String password,
      String confirmPassword, String referralCode, String phone) async {
    final response = await _networkService.post(UserAPI.REGISTER_URL, data: {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
      'referral_code': referralCode,
      'phone': phone,
      'country_iso2': 'US'
    });
    return response;
  }

  Future<String?> getToken() async {
    final token = await LocalPref.getString(PrefKey.TOKEN_KEY);
    print("token $token");
    if (token != null) {
      _networkService.setToken(token);
    }
    return token;
  }

  Future<bool> saveToken(String token) async {
    final result = await LocalPref.saveString(PrefKey.TOKEN_KEY, token);
    _networkService.setToken(token);
    return result;
  }

  Future<String?> getRole() async {
    final role = await LocalPref.getString(PrefKey.ROLE_KEY);
    Variables.isTeacher = role == "true";
    return role;
  }

  Future<bool> saveRole(String role) async {
    return await LocalPref.saveString(PrefKey.ROLE_KEY, role);
  }

  Future<bool> saveUserProfile(String token) async {
    final result = await LocalPref.saveString(PrefKey.TOKEN_KEY, token);
    _networkService.setToken(token);
    return result;
  }

  Future<dynamic> forgotPassword(String email) async {
    final response = await _networkService
        .post(UserAPI.FORGOT_PASSWORD_URL, data: {'email': email});
    return response;
  }

  Future<dynamic> resetPassword(String email, String password, String confirmPassword) async {
    final response = await _networkService.post(UserAPI.RESET_PASSWORD_CODE_URL, data: {
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    });
    return response;
  }

  Future<dynamic> getProfile({
    String? userId,
    String? accountId,
  }) async {
    final filters = {
      'user_id': API.CURRENT_USER_ID,
      'account_id': API.CURRENT_ACCOUNT_ID,
    };
    final response = await _networkService.get(UserAPI.PROFILE_URL,
        queryParameters: filters);
    return UserResponse.fromJson(response);
  }

  Future<String?> getProfileLocal() async {
    return await LocalPref.getString(PrefKey.PROFILE_KEY);
  }

  Future<bool> saveProfileLocal(String profile) async {
    return await LocalPref.saveString(PrefKey.PROFILE_KEY, profile);
  }

  Future<dynamic> uploadImage(String imageBase64) async {
    final response = await _networkService.post(UserAPI.UPLOAD_IMAGE_URL,
        data: {'image_base64': 'data:image/jpeg;base64,$imageBase64'});
    return response;
  }

  Future<dynamic> saveProfile(
    String firstName,
    String lastName,
    String phone,
    String description,
    String yearsExp,
    bool notify,
    String headline,
    String addrFull,
    String addrStreet,
    String addrDistrict,
    String addrState,
    String addrLat,
    String addrLng,
    List<dynamic> types,
    List<dynamic> skills,
  ) async {
    final response = await _networkService.post(UserAPI.SAVE_PROFILE_URL, data: {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'description': description,
      'years_exp': yearsExp,
      'notify': notify ? 1 : 0,
      'headline': headline,
      'addr_full': addrFull,
      'addr_street': addrStreet,
      'addr_district': addrDistrict,
      'addr_state': addrState,
      'addr_lat': addrLat,
      'addr_lng': addrLng,
      'types': types,
      'skills': skills,
    });
    return response;
  }

  Future<dynamic> changePassword(
      String oldPassword, String password, String confirmPassword) async {
    final response = await _networkService.post(UserAPI.CHANGE_PASSWORD_CODE_URL, data: {
      'old_password': oldPassword,
      'password': password,
      'password_confirmation': confirmPassword,
    });
    return response;
  }

  Future<dynamic> logOut() async {
    return await _networkService.get(UserAPI.LOGOUT_URL);
  }
}
