enum UiMessage {
  none,
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  notConnected,
  created,
  noRegister,
}

extension UiMessageDescription on UiMessage {
  String description() {
    switch (this) {
      case UiMessage.requiredField:
        return 'Campo obrigatório';
      case UiMessage.invalidField:
        return 'Campo inválido';
      case UiMessage.invalidCredentials:
        return 'Credentiais inválidas';
      case UiMessage.notConnected:
        return 'Sem conexão, tente novamente';
      case UiMessage.created:
        return 'Criado com sucesso!';
      case UiMessage.noRegister:
        return 'Registro não localizado, tente novamente!';
      default:
        return 'Erro inesperado, tente novamente';
    }
  }
}
