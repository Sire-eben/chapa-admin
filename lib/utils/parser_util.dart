import 'package:chapa_admin/utils/__utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParserUtil<T> {
  static DateTime parseJsonDate(String? dateString) {
    try {
      return DateTime.parse(dateString!);
    } catch (e) {
      return DateTime.now();
    }
  }

  static String parseJsonString(
    Object? json,
    String param, {
    String? defaultValue,
    bool isTitleCase = false,
  }) {
    try {
      json = json as Map;

      Object? result = json[param];

      if (result == null) return defaultValue ?? '';

      String resultString = result.toString();
      final parsedString =
          resultString.isEmpty ? defaultValue ?? resultString : resultString;

      if (isTitleCase) return parsedString.titleCase;
      return parsedString;
    } catch (e) {
      if (isTitleCase) return defaultValue?.titleCase ?? '';
      return defaultValue ?? '';
    }
  }

  static bool parseJsonBoolean(Map? json, String param) {
    try {
      Object? result = json![param];

      if (result == null) return false;
      return result as bool;
    } catch (e) {
      return false;
    }
  }

  static int getJsonListCount(List<dynamic>? json) {
    try {
      return json!.length;
    } catch (e) {
      return 0;
    }
  }

  List<T> parseJsonList({
    required List<dynamic>? json,
    required T Function(DocumentSnapshot json) fromJson,
  }) {
    try {
      final data = List<DocumentSnapshot>.from(json!);

      return List<T>.from(
        data.map(
          (e) => fromJson(e),
        ),
      );
    } catch (e) {
      return [];
    }
  }

  static num parseJsonNum(Map? json, String param) {
    try {
      Object? result = json![param];

      if (result == null) return 0;
      if (result is String) return num.parse(result);
      return result as num;
    } catch (e) {
      return 0;
    }
  }

  static double parseJsonDouble(Map? json, String param) {
    try {
      Object? result = json![param];

      if (result == null) return 0.0;
      var convertedResult = double.parse(result.toString());
      return convertedResult;
    } catch (e) {
      return 0.0;
    }
  }

  static String _appendDateSuffix(int day) {
    switch (day) {
      case 1:
      case 21:
      case 31:
        return '${day}st';
      case 2:
      case 22:
        return '${day}nd';
      case 3:
      case 23:
        return '${day}rd';

      default:
        return '${day}th';
    }
  }

  static int parseJsonInt(Map? json, String param) {
    try {
      json = json as Map;

      Object? result = json[param];

      if (result == null) return 0;
      var convertResultToDouble = double.parse(result.toString());
      var convertResultToInt = convertResultToDouble.toInt();
      return convertResultToInt;
    } catch (e) {
      return 0;
    }
  }
}
