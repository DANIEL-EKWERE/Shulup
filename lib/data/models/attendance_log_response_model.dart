// class AttendanceLogResponseModel {
//   final bool success;
//   final String message;
//   final AttendanceLogData data;

//   AttendanceLogResponseModel({
//     required this.success,
//     required this.message,
//     required this.data,
//   });

//   factory AttendanceLogResponseModel.fromJson(Map<String, dynamic> json) {
//     return AttendanceLogResponseModel(
//       success: json['success'] ?? false,
//       message: json['message'] ?? '',
//       data: AttendanceLogData.fromJson(json['data'] ?? {}),
//     );
//   }
// }

// class AttendanceLogData {
//   final int totalCount;
//   final int page;
//   final int pageSize;
//   final int totalPages;
//   final List<AttendanceLog> logs;

//   AttendanceLogData({
//     required this.totalCount,
//     required this.page,
//     required this.pageSize,
//     required this.totalPages,
//     required this.logs,
//   });

//   factory AttendanceLogData.fromJson(Map<String, dynamic> json) {
//     return AttendanceLogData(
//       totalCount: json['totalCount'] ?? 0,
//       page: json['page'] ?? 1,
//       pageSize: json['pageSize'] ?? 30,
//       totalPages: json['totalPages'] ?? 1,
//       logs: (json['logs'] as List<dynamic>?)
//               ?.map((log) => AttendanceLog.fromJson(log))
//               .toList() ??
//           [],
//     );
//   }
// }

// class AttendanceLog {
//   final int attendanceLogID;
//   final String cardUID;
//   final String personName;
//   final String personType;
//   final String eventTypeText;
//   final String eventDateTime;

//   AttendanceLog({
//     required this.attendanceLogID,
//     required this.cardUID,
//     required this.personName,
//     required this.personType,
//     required this.eventTypeText,
//     required this.eventDateTime,
//   });

//   factory AttendanceLog.fromJson(Map<String, dynamic> json) {
//     return AttendanceLog(
//       attendanceLogID: json['attendanceLogID'] ?? 0,
//       cardUID: json['cardUID'] ?? '',
//       personName: json['personName'] ?? '',
//       personType: json['personType'] ?? '',
//       eventTypeText: json['eventTypeText'] ?? '',
//       eventDateTime: json['eventDateTime'] ?? '',
//     );
//   }
// }


class AttendanceLogResponseModel {
  final bool success;
  final String message;
  final AttendanceLogData data;

  AttendanceLogResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AttendanceLogResponseModel.fromJson(Map<String, dynamic> json) {
    return AttendanceLogResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: AttendanceLogData.fromJson(json['data'] ?? {}),
    );
  }
}

class AttendanceLogData {
  final int totalCount;
  final int page;
  final int pageSize;
  final int totalPages;
  final List<AttendanceLog> logs;

  AttendanceLogData({
    required this.totalCount,
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.logs,
  });

  factory AttendanceLogData.fromJson(Map<String, dynamic> json) {
    return AttendanceLogData(
      totalCount: json['totalCount'] ?? 0,
      page: json['page'] ?? 1,
      pageSize: json['pageSize'] ?? 30,
      totalPages: json['totalPages'] ?? 1,
      logs: (json['logs'] as List<dynamic>?)
              ?.map((log) => AttendanceLog.fromJson(log))
              .toList() ??
          [],
    );
  }
}

class AttendanceLog {
  final int attendanceLogID;
  final String cardUID;
  final String personName;
  final String personType;
  final String eventTypeText;
  final String eventDateTime;

  AttendanceLog({
    required this.attendanceLogID,
    required this.cardUID,
    required this.personName,
    required this.personType,
    required this.eventTypeText,
    required this.eventDateTime,
  });

  factory AttendanceLog.fromJson(Map<String, dynamic> json) {
    return AttendanceLog(
      attendanceLogID: json['attendanceLogID'] ?? 0,
      cardUID: json['cardUID'] ?? '',
      personName: json['personName'] ?? '',
      personType: json['personType'] ?? '',
      eventTypeText: json['eventTypeText'] ?? '',
      eventDateTime: json['eventDateTime'] ?? '',
    );
  }
}
