import 'package:flutter_signin_button/button_list.dart';

const currentSessionId = "current";

class OAuth2Provider {
  final String id;
  final Buttons buttons;
  final String label;

  OAuth2Provider({
    required this.id,
    required this.buttons,
    required this.label,
  });

  static List<OAuth2Provider> values = [google, apple, facebook, email];
  static OAuth2Provider google =
      OAuth2Provider(id: "google", buttons: Buttons.Google, label: "Sign In with Google");
  static OAuth2Provider apple =
      OAuth2Provider(id: "apple", buttons: Buttons.Apple, label: "Sign In with Apple");
  static OAuth2Provider facebook =
      OAuth2Provider(id: "facebook", buttons: Buttons.Facebook, label: "Sign In with Facebook");
  static OAuth2Provider email =
      OAuth2Provider(id: "email", buttons: Buttons.Email, label: "Sign In with E-mail");
}
