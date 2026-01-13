import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../server_api/server_constant.dart';
import '../server_api/server_response.dart';
import '../utils/app_constant.dart';
import 'app_events.dart';
import 'app_repository.dart';
import 'app_states.dart';
import 'app_error.dart';



class AppBloc extends Bloc<AppEvent, AppStates> {
  final _appRepository = AppRepository();

  AppBloc() : super(NeutralState()) {
    on<AppEvent>((event, emit) async {
      if (event is InitialEvent) {
        emit(NeutralState());
        return;
      }
      emit(LoadingState(event));
      Response response = await tigerEventsByTypes(event);
      if (response.statusCode == 200) {
        emitStateByServerResponseStatusCode(response, emit, event);
      } else if (response.statusCode == AppStatusConstant.noNetworkStatus) {
        AppError noInterNetError = AppError(
            ErrorTypes.show, AppConstant.noInternet, response.statusCode);
        emit(NetworkErrorState(noInterNetError, event));
      } else if (response.statusCode == AppStatusConstant.slowNetworkStatus) {
        AppError errorState = AppError(
            ErrorTypes.error, AppConstant.slowInternet, response.statusCode);
        emit(ErrorState(errorState, event));
      } else {
      ServerResponse  serverResponse = ServerResponse.fromJson(jsonDecode(response.body));
        AppError errorState = AppError(ErrorTypes.error,
            serverResponse.message!, serverResponse.serverStatusCode!);
        emit(ErrorState(errorState, event));
      }
    });
  }

  tigerEventsByTypes(AppEvent event) async {
    if (event is LoginEvent) {
      return await _appRepository.userLoginApi(event);
    }
    if (event is VerifyOtpEvent) {
       return await _appRepository.userVerifyApi(event);
    }
    if (event is RegisterEvent) {
       return await _appRepository.userSignUpApi(event);
    }
    if (event is CreatePropertiesEvent) {
       return await _appRepository.createProperties(event);
    }
    if (event is GetAllPropertiesEvent) {
       return await _appRepository.getPropertiesById(event);
    }
  }



  void emitStateByServerResponseStatusCode(
      Response response, Emitter<AppStates> emit, AppEvent appEvent) {
    ServerResponse? serverResponse;
    try {
      serverResponse = ServerResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      AppError error = AppError(
          ErrorTypes.error, "Parsing Error$e", AppStatusConstant.errorStatus);
      emit(ErrorState(error, appEvent));
      return;
    }
    if (serverResponse.serverStatusCode == AppStatusConstant.successStatus) {
      emit(SuccessState(serverResponse, appEvent));
    } else if (serverResponse.serverStatusCode ==
        AppStatusConstant.tokenExpiredStatus) {
      AppError tokenError = AppError(ErrorTypes.error,
          AppConstant.yourTokenHaseExpired, serverResponse.serverStatusCode!);
      emit(ErrorState(tokenError, appEvent));
    } else if (serverResponse.serverStatusCode ==
        AppStatusConstant.tokenBlockedStatus) {
      AppError tokenError = AppError(ErrorTypes.error, serverResponse.message!,
          serverResponse.serverStatusCode!);
      emit(ErrorState(tokenError, appEvent));
    } else if (serverResponse.serverStatusCode == AppStatusConstant.errorStatus) {
      AppError error = AppError(ErrorTypes.show, serverResponse.message!,
          serverResponse.serverStatusCode!);
      emit(ErrorState(error, appEvent));
    } else {
      AppError error = AppError(ErrorTypes.error, serverResponse.message!,
          serverResponse.serverStatusCode!);
      emit(ErrorState(error, appEvent));
    }
  }


}
