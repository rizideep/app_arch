import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart';

import '../server_api/server_constant.dart';
import '../server_api/server_url.dart';
import '../utils/getx_storage.dart';
import '../utils/preferences_constant.dart';
import '../utils/util.dart';
import 'app_events.dart';

class AppRepository {
  postApiCall(String apiEndPoint, Map<String, dynamic> queryParameters) async {
    http.Response response;
    var box = GetStorageUtil();
    var isConnected = await MyUtil.checkConnectivityStatus();
    if (isConnected) {
      MyUtil.printWW(" $apiEndPoint {api queryParameters}): $queryParameters");
      var accessToken = box.read(PreferencesConstant.accessToken);
      response = await http
          .post(Uri.parse(ServerUrl.baseUrl + apiEndPoint),
              headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader: 'Bearer $accessToken',
              },
              encoding: Encoding.getByName("utf-8"),
              body: jsonEncode(queryParameters))
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return Response(
              "",
              AppStatusConstant
                  .slowNetworkStatus); // Request Timeout response status code
        },
      );
      MyUtil.printV("Bearer $accessToken");
      MyUtil.printW(
          " $apiEndPoint API response: $jsonDecode(${response.body})");
    } else {
      response = Response("", AppStatusConstant.noNetworkStatus);
    }

    return response;
  }

  postApiCallWithObject(String apiEndPoint, Object queryParameters) async {
    http.Response response;
    var isConnected = await MyUtil.checkConnectivityStatus();
    if (isConnected) {
      var box = GetStorageUtil();
      var accessToken = box.read(PreferencesConstant.accessToken);
      response = await http
          .post(Uri.parse(ServerUrl.baseUrl + apiEndPoint),
              headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader: 'Bearer $accessToken',
              },
              encoding: Encoding.getByName("utf-8"),
              body: jsonEncode(queryParameters))
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return Response(
              "",
              AppStatusConstant
                  .slowNetworkStatus); // Request Timeout response status code
        },
      );
      MyUtil.printV("Bearer $accessToken");
      MyUtil.printW(" $apiEndPoint API response: $jsonEncode${response.body})");
    } else {
      response = Response("", AppStatusConstant.noNetworkStatus);
    }
    return response;
  }

  getApiCall(String apiEndPoint, Map<String, String>? queryParameters) async {
    http.Response response;
    var isConnected = await MyUtil.checkConnectivityStatus();
    if (isConnected) {
      var box = GetStorageUtil();
      MyUtil.printWW(" $apiEndPoint {api queryParameters}: $queryParameters");
      var accessToken = box.read(PreferencesConstant.accessToken);
      response = await http.get(
        Uri.http(ServerUrl.baseUrlGet, apiEndPoint, queryParameters),
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return Response(
              "",
              AppStatusConstant
                  .slowNetworkStatus); // Request Timeout response status code
        },
      );
      MyUtil.printV("Bearer $accessToken");
      MyUtil.printW(
          " $apiEndPoint API response: $jsonDecode(${response.body})");
    } else {
      response = Response("", AppStatusConstant.noNetworkStatus);
    }

    return response;
  }

  //******************************************************************************

  userSignUpApi(RegisterEvent event) async {
    final queryParameters = {
      'name': event.name,
      'email': event.email,
      'phone': event.phone,
      'password': event.pass,
    };
    return await postApiCall(ServerUrl.createUser, queryParameters);
  }

  userLoginApi(LoginEvent event) async {
    final queryParameters = {
      'email': event.email,
      'password': event.pass,
    };
    return await postApiCall(ServerUrl.login, queryParameters);
  }

  userVerifyApi(VerifyOtpEvent event) async {
    final queryParameters = {
      'user_id': event.id,
      'otp': event.otp,
    };
    return await postApiCall(ServerUrl.verifyOtp, queryParameters);
  }

  createProperties(CreatePropertiesEvent event) async {
    var box = GetStorageUtil();
    String? accessToken = box.read(PreferencesConstant.accessToken);
    var headerMap = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Bearer $accessToken"
    };
    var postUri = Uri.parse('${ServerUrl.baseUrl}properties');
    http.MultipartRequest request = http.MultipartRequest("POST", postUri);

    if (event.proName != null) {
      request.fields['property_name'] = event.proName!;
    }
    if (event.proCatId != null) {
      request.fields['category_id'] = event.proCatId!;
    }
    if (event.proStateId != null) {
      request.fields['state_id'] = event.proStateId!;
    }
    if (event.proCityId != null) {
      request.fields['city_id'] = event.proCityId!;
    }
    if (event.proAddress != null) {
      request.fields['address'] = event.proAddress!;
    }
    if (event.proBudget != null) {
      request.fields['budget'] = event.proBudget!;
    }
    if (event.proContNo != null) {
      request.fields['contact_details'] = event.proContNo!;
    }
    if (event.userId != null) {
      request.fields['user_id'] = event.userId!;
    }

    request.headers.addAll(headerMap);

    for (String? image in event.photos) {
      File profilePic = File(image!);
      if (await profilePic.exists()) {
        request.files.add(await http.MultipartFile.fromPath(
          'photos[]', // Field name for each photo
          profilePic.path,
          filename: basename(profilePic.path), // File name
        ));
      }
    }

    var response = await request.send();
    MyUtil.printV("Bearer $accessToken");
    var responseData = await response.stream.bytesToString();
    MyUtil.printW("API response: $responseData");
    if (response.statusCode == 200) {
      if (kDebugMode) {
        MyUtil.showToast("Upload successful");
      }
    } else {
      if (kDebugMode) {
        MyUtil.showToast("Failed to upload data: ${response.statusCode}");
      }
    }

    return response;
  }

  getPropertiesById(GetAllPropertiesEvent event) async {
    final queryParameters = {
      'user_id': event.userId,
    };
    return await getApiCall(ServerUrl.getPropertiesById, queryParameters);
  }

 
}
