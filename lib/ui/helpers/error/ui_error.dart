enum UiError {
  none,
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  notConnected,
}

extension UiErrorDescription on UiError {
  String description() {
    switch (this) {
      case UiError.requiredField:
        return 'Campo obrigatório';
      case UiError.invalidField:
        return 'Campo inválido';
      case UiError.invalidCredentials:
        return 'Credentiais inválidas';
      case UiError.notConnected:
        return 'Sem conexão, tente novamente';
      default:
        return 'Erro inesperado, tente novamente';
    }
  }
}
