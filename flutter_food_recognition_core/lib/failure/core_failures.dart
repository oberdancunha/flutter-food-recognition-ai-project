sealed class CoreFailure {
  const CoreFailure();
}

class ConnectionFailure extends CoreFailure {
  const ConnectionFailure();
}

class AuthenticationCredentialsFailure extends CoreFailure {
  const AuthenticationCredentialsFailure();
}

class UnexpectedHttpFailure extends CoreFailure {
  const UnexpectedHttpFailure();
}

class ResponseHttpFailure extends CoreFailure {
  const ResponseHttpFailure();
}
