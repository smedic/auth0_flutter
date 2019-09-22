part of auth0_flutter;

class Credentials {
  final String accessToken;
  final String tokenType;
  final DateTime expiresIn;
  final String refreshToken;
  final String idToken;
  final String scope;

  Credentials(
      {this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.refreshToken,
      this.idToken,
      this.scope});

  Credentials.fromJSON(Map<String, dynamic> json)
      : this.accessToken = json['access_token'],
        this.tokenType = json['token_type'],
        this.expiresIn = Credentials._dateFromValue(json['expires_in']),
        this.refreshToken = json['refresh_token'],
        this.idToken = json['id_token'],
        this.scope = json['scope'];

  static DateTime _dateFromValue(dynamic value) {
    if (value is String) {
      final seconds = int.parse(value);

      return DateTime.now().add(Duration(seconds: seconds));
    } else if (value is double) {
      final seconds = value.toInt();

      return DateTime.now().add(Duration(seconds: seconds));
    } else if (value is int) {
      return DateTime.now().add(Duration(seconds: value));
    } else {
      return null;
    }
  }
}
