part of auth0_flutter;

class UserInfo {
  static List<String> publicClaims = [
    "sub",
    "name",
    "given_name",
    "family_name",
    "middle_name",
    "nickname",
    "preferred_username",
    "profile",
    "picture",
    "website",
    "email",
    "email_verified",
    "gender",
    "birthdate",
    "zoneinfo",
    "locale",
    "phone_number",
    "phone_number_verified",
    "address",
    "updated_at"
  ];

  final String sub;
  final String name;
  final String givenName;
  final String familyName;
  final String middleName;
  final String nickname;
  final String preferredUsername;

  final Uri profile;
  final Uri picture;
  final Uri website;

  final String email;
  final bool emailVerified;

  final String gender;
  final String birthdate;

  final String zoneinfo;
  final String locale;

  final String phoneNumber;
  final bool phoneNumberVerified;

  final Map<String, String> address;
  final DateTime updatedAt;

  final Map<String, dynamic> customClaims;

  UserInfo(
      {this.sub,
      this.name,
      this.givenName,
      this.familyName,
      this.middleName,
      this.nickname,
      this.preferredUsername,
      this.profile,
      this.picture,
      this.website,
      this.email,
      this.emailVerified,
      this.gender,
      this.birthdate,
      this.zoneinfo,
      this.locale,
      this.phoneNumber,
      this.phoneNumberVerified,
      this.address,
      this.updatedAt,
      this.customClaims});

  factory UserInfo.fromJSON(Map<String, dynamic> json) {
    final sub = json['sub'];

    if (sub == null) {
      return null;
    }

    final name = json['name'];
    final givenName = json['given_name'];
    final familyName = json['family_name'];
    final middleName = json['middle_name'];
    final nickname = json['nickname'];
    final preferredUsername = json['preferred_username'];
    final profile = Uri.tryParse(json['profile']);
    final picture = Uri.tryParse(json['picture']);
    final website = Uri.tryParse(json['website']);
    final email = json['email'];
    final emailVerified = json['email_verified'];
    final gender = json['gender'];
    final birthdate = json['birthdate'];
    final zoneinfo = json['zoneinfo'];
    final locale = json['locale'];
    final phoneNumber = json['phone_number'];
    final phoneNumberVerified = json['phone_number_verified'];
    final address = json['address'];
    final updatedAt = dateFromString(json['updated_at']);

    final customClaims = Map.fromEntries(json.entries);
    UserInfo.publicClaims.forEach((v) => customClaims.remove(v));

    return UserInfo(
        sub: sub,
        name: name,
        givenName: givenName,
        familyName: familyName,
        middleName: middleName,
        nickname: nickname,
        preferredUsername: preferredUsername,
        profile: profile,
        picture: picture,
        website: website,
        email: email,
        emailVerified: emailVerified,
        gender: gender,
        birthdate: birthdate,
        zoneinfo: zoneinfo,
        locale: locale,
        phoneNumber: phoneNumber,
        phoneNumberVerified: phoneNumberVerified,
        address: address,
        updatedAt: updatedAt,
        customClaims: customClaims);
  }
}
