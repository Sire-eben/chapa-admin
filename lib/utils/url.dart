import 'package:url_launcher/url_launcher.dart';

void launchPhoneUrl(String phoneNumber) => launchUrl(
  Uri(
    scheme: "tel",
    path: phoneNumber,
  ),
);

void launchEmailUrl(String email, {Map<String, dynamic>? query}) => launchUrl(
  Uri(
    scheme: "maito",
    path: email,
    queryParameters: query,
  ),
);

void launchWhatsAppUrl(String phoneNumber, {Map<String, dynamic>? query}) =>
    launchUrl(
      Uri(
        scheme: "https",
        host: "wa.me",
        path: phoneNumber,
        queryParameters: query,
      ),
    );