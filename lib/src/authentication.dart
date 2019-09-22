part of auth0_flutter;

// String types code, link, link_ios, link_android
enum PasswordlessType { code, link, iosLink, androidLink }

String _passwordlessTypeToString(PasswordlessType type) {
  switch (type) {
    case PasswordlessType.code:
      return 'code';
    case PasswordlessType.link:
      return 'link';
    case PasswordlessType.iosLink:
      return 'link_ios';
    case PasswordlessType.androidLink:
      return 'link_android';
  }

  return '';
}

class Authentication {
  final String clientId;
  final String domain;
  final MethodChannel _channel;

  Authentication._(
      {@required this.clientId, @required this.domain, MethodChannel channel})
      : _channel = channel;

  void _processJSONForErrors(Map<String, dynamic> result) {
    final Map<String, dynamic> error = result['error'];
    if (error != null) {
      throw AuthenticationError.fromJSON(error, result['error_code']);
    }
    return null;
  }

  Future<Credentials> login(
      {@required String usernameOrEmail,
      @required String password,
      @required String realm,
      String audience,
      String scope,
      Map<String, dynamic> parameters}) async {
    final args = <String, dynamic>{
      'usernameOrEmail': usernameOrEmail,
      'password': password,
      'realm': realm,
      'audience': audience,
      'scope': scope,
      'parameters': parameters
    };

    final Map<String, dynamic> result =
        await _channel.invokeMapMethod('authentication_login', args);

    _processJSONForErrors(result);

    return Credentials.fromJSON(result);
  }

  Future<Credentials> loginWithOTP(String otp,
      {@required String mfaToken}) async {
    assert(otp != null);

    final args = <String, dynamic>{'otp': otp, 'mfaToken': mfaToken};

    final Map<String, dynamic> result =
        await _channel.invokeMapMethod('authentication_login_with_otp', args);

    _processJSONForErrors(result);

    return Credentials.fromJSON(result);
  }

  Future<Credentials> loginDefaultDirectory(
      {@required String username,
      @required String password,
      String audience,
      String scope,
      Map<String, dynamic> parameters}) async {
    final args = <String, dynamic>{
      'username': username,
      'password': password,
      'audience': audience,
      'scope': scope,
      'parameters': parameters
    };

    final Map<String, dynamic> result = await _channel.invokeMapMethod(
        'authentication_login_default_directory', args);

    _processJSONForErrors(result);

    return Credentials.fromJSON(result);
  }

  Future<DatabaseUser> createUser(
      {@required String email,
      String username,
      @required String password,
      @required String connection,
      Map<String, dynamic> userMetadata,
      Map<String, dynamic> rootAttributes}) async {
    final args = <String, dynamic>{
      'email': email,
      'username': username,
      'password': password,
      'connection': connection,
      'userMetadata': userMetadata,
      'rootAttributes': rootAttributes
    };

    final Map<String, dynamic> result =
        await _channel.invokeMapMethod('authentication_create_user', args);

    _processJSONForErrors(result);

    return DatabaseUser.fromJSON(result);
  }

  Future<void> resetPassword(
      {@required String email, @required String connection}) async {
    final args = <String, dynamic>{'email': email, 'connection': connection};

    final Map<String, dynamic> result =
        await _channel.invokeMapMethod('authentication_reset_password', args);

    _processJSONForErrors(result);
  }

  Future<void> startEmailPasswordless(
      {@required String email,
      PasswordlessType type = PasswordlessType.code,
      String connection = 'email',
      Map<String, dynamic> parameters}) async {
    final args = <String, dynamic>{
      'email': email,
      'type': _passwordlessTypeToString(type),
      'connection': connection,
      'parameters': parameters
    };

    final Map<String, dynamic> result = await _channel.invokeMapMethod(
        'authentication_start_email_passwordless', args);

    _processJSONForErrors(result);
  }

  Future<void> startPhoneNumberPasswordless(
      {@required String phoneNumber,
      PasswordlessType type = PasswordlessType.code,
      String connection = 'sms'}) async {
    final args = <String, dynamic>{
      'phoneNumber': phoneNumber,
      'type': _passwordlessTypeToString(type),
      'connection': connection
    };

    final Map<String, dynamic> result = await _channel.invokeMapMethod(
        'authentication_start_phone_number_passwordless', args);

    _processJSONForErrors(result);
  }

  /// Returns user information by performing a request to /userinfo endpoint.
  /// - warning: for OIDC-conformant clients please use `userInfo(withAccessToken accessToken:)`
  Future<Profile> userInfoWithToken(String token) async {
    final Map<String, dynamic> result = await _channel.invokeMapMethod(
      'authentication_user_info_with_token',
      <String, dynamic>{'token': token},
    );

    _processJSONForErrors(result);

    return Profile.fromJSON(result);
  }

  /// Returns OIDC standard claims information by performing a request
  ///  to /userinfo endpoint.
  /// - important: This method should be used for OIDC Conformant clients.
  Future<UserInfo> userInfoWithAccessToken(String accessToken) async {
    final Map<String, dynamic> result = await _channel.invokeMapMethod(
      'authentication_user_info_with_access_token',
      <String, dynamic>{'accessToken': accessToken},
    );

    _processJSONForErrors(result);

    return UserInfo.fromJSON(result);
  }

  Future<Credentials> loginSocial(
      {@required String token,
      @required String connection,
      String scope = 'openid',
      Map<String, dynamic> parameters}) async {
    final args = <String, dynamic>{
      'token': token,
      'connection': connection,
      'scope': scope,
      'parameters': parameters
    };

    final Map<String, dynamic> result =
        await _channel.invokeMapMethod('authentication_login_social', args);

    _processJSONForErrors(result);

    return Credentials.fromJSON(result);
  }

  Future<Credentials> tokenExchangeWithParameters(
      Map<String, dynamic> parameters) async {
    final args = <String, dynamic>{'parameters': parameters};

    final Map<String, dynamic> result = await _channel.invokeMapMethod(
        'authentication_token_exchange_with_params', args);

    _processJSONForErrors(result);

    return Credentials.fromJSON(result);
  }

  Future<Credentials> tokenExchangeWithCode(String code,
      {String codeVerifier, String redirectURI}) async {
    final args = <String, dynamic>{
      'code': code,
      'codeVerifier': codeVerifier,
      'redirectURI': redirectURI
    };

    final Map<String, dynamic> result = await _channel.invokeMapMethod(
        'authentication_token_exchange_with_code', args);

    _processJSONForErrors(result);

    return Credentials.fromJSON(result);
  }

  void appleTokenExchange(
      {@required String authCode, String scope, String audience}) {}

  Future<Credentials> renew(
      {@required String refreshToken, String scope}) async {
    final args = <String, dynamic>{
      'refreshToken': refreshToken,
      'scope': scope
    };

    final Map<String, dynamic> result =
        await _channel.invokeMapMethod('authentication_renew', args);

    _processJSONForErrors(result);

    return Credentials.fromJSON(result);
  }

  Future<void> revoke(String refreshToken) async {
    final args = <String, dynamic>{'refreshToken': refreshToken};

    final Map<String, dynamic> result =
        await _channel.invokeMapMethod('authentication_revoke', args);

    _processJSONForErrors(result);
  }

  Future<Map<String, dynamic>> delegation(
      Map<String, dynamic> parameters) async {
    final args = <String, dynamic>{'parameters': parameters};

    final Map<String, dynamic> result =
        await _channel.invokeMapMethod('authentication_delegation', args);

    _processJSONForErrors(result);

    return result;
  }

  WebAuth webAuthWithConnection(String connection) {
    return WebAuth._(clientId: clientId, domain: domain, channel: _channel)
      ..connection = connection;
  }
}