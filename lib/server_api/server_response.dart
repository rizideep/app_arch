

class ServerResponse<T> {
  final bool? status;
  late final int? serverStatusCode;
  final String? message;
  final T? data;

  ServerResponse({
    required this.status,
    required this.serverStatusCode,
    required this.message,
    required this.data,
  });

  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    return ServerResponse(
      status: json['status'],
      serverStatusCode: json['status_code'],
      message: json['message'],
      data: json['data'],
    );
  }
}
