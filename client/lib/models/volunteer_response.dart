class VolunteerQueryResponse {
  final int respCode;
  final String respMessage;
  final String? data; // Use String? because data can be null

  VolunteerQueryResponse({
    required this.respCode,
    required this.respMessage,
    this.data,
  });

  factory VolunteerQueryResponse.fromJson(Map<String, dynamic> json) {
    return VolunteerQueryResponse(
      respCode: json['RespCode'],
      respMessage: json['RespMessage'],
      data: json['Data'],
    );
  }
}
