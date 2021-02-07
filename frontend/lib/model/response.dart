class Response<T>{
  final T modal;
  final String error;

  Response(this.modal, [this.error = ""]);

  Response.withError(String val) : modal = null, error = val;
}
