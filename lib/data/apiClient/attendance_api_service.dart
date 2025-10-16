// import 'package:http/http.dart' as http;
// import 'package:schulup/core/utils/storage.dart';
// import 'dart:convert';

// import 'package:schulup/data/models/attendance_log_response_model.dart';

// class AttendanceApiService {
//   final String baseUrl =
//       "https://api.schulup.com/api"; // Replace with your actual staging URL

//   Future<AttendanceLogResponseModel> getAttendanceLogs({
//     required String schoolCode,
//     int attendanceAssociatedPersonType = 1,
//     String? startDate,
//     String? endDate,
//     String? name,
//     int page = 1,
//     int pageSize = 30,
//   }) async {
//     try {
//       // Build query parameters
//       Map<String, String> queryParams = {
//         'schoolCode': schoolCode,
//         'attendanceAssociatedPersonType':
//             attendanceAssociatedPersonType.toString(),
//         'page': page.toString(),
//         'pageSize': pageSize.toString(),
//       };

//       if (startDate != null && startDate.isNotEmpty) {
//         queryParams['startDate'] = startDate;
//       }
//       if (endDate != null && endDate.isNotEmpty) {
//         queryParams['endDate'] = endDate;
//       }
//       if (name != null && name.isNotEmpty) {
//         queryParams['name'] = name;
//       }

//       // Build URI
//       final uri = Uri.parse(
//         '$baseUrl/attendance/logs',
//       ).replace(queryParameters: queryParams);
//       var token = await dataBase.getToken();
//       // Make API call
//       final response = await http.get(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//           // Add authorization header if needed
//           'Authorization': 'Bearer $token',
//         },
//       );
//       print(json.decode(response.body));
//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         return AttendanceLogResponseModel.fromJson(jsonResponse);
//       } else {
//         throw Exception(
//           'Failed to load attendance logs: ${response.statusCode} \nbody: ${response.body}',
//         );
//       }
//     } catch (e) {
//       throw Exception('Error fetching attendance logs: $e');
//     }
//   }
// }


import 'package:http/http.dart' as http;
import 'package:schulup/core/utils/storage.dart';
import 'dart:convert';
import '../models/attendance_log_response_model.dart';

class AttendanceApiService {
  final String baseUrl = "https://api.schulup.com/api"; // Replace with actual URL

  Future<AttendanceLogResponseModel> getAttendanceLogs({
    required String schoolCode,
    int attendanceAssociatedPersonType = 1,
    String? startDate,
    String? endDate,
    String? name,
    int page = 1,
    int pageSize = 30,
  }) async {
    try {
      Map<String, String> queryParams = {
        'schoolCode': schoolCode,
        'attendanceAssociatedPersonType': attendanceAssociatedPersonType.toString(),
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      };

      if (startDate != null && startDate.isNotEmpty) {
        queryParams['startDate'] = startDate;
      }
      if (endDate != null && endDate.isNotEmpty) {
        queryParams['endDate'] = endDate;
      }
      if (name != null && name.isNotEmpty) {
        queryParams['name'] = name;
      }

      final uri = Uri.parse('$baseUrl/attendance/logs').replace(
        queryParameters: queryParams,
      );

      print('Fetching: $uri'); // Debug log
      var token = await dataBase.getToken();

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          // Add authorization if needed
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return AttendanceLogResponseModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error: $e'); // Debug log
      throw Exception('Error: $e');
    }
  }
}