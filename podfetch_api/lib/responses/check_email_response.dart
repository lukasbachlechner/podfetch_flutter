class CheckEmailResponse {
  final bool isTaken;

  const CheckEmailResponse(this.isTaken);

  factory CheckEmailResponse.fromJson(Map<String, dynamic> json) =>
      CheckEmailResponse(json['isTaken'] as bool);
}
