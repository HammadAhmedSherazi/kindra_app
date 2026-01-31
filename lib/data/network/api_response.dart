import 'package:flutter/material.dart';

import '../enums/api_status.dart';

class ApiResponse<T> {
  ApiResponse();

  Status status = Status.undertermined;
  ConnectionState connectionStatus = ConnectionState.none;
  T? data;
  String message = '';
  List<dynamic> errors = [];

  ApiResponse.undertermined() : status = Status.undertermined;
  ApiResponse.loading() : status = Status.loading;
  ApiResponse.completed(this.data) : status = Status.completed;
  ApiResponse.error() : status = Status.error;
  ApiResponse.loadingMore() : status = Status.loadingMore;
  ApiResponse.loadingProcess() : status = Status.loadingProcess;
}
