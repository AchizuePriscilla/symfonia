
class ServerErrorModel{
  final int statusCode;
  final dynamic errorMessage;
  final dynamic data;
  final bool useDialog;

  const ServerErrorModel(
      {required this.statusCode,
      required this.errorMessage,
      this.data,
      this.useDialog = false});
}
