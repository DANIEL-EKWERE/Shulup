// import 'package:flutter/material.dart';
// import '../../../core/app_export.dart';
// import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
// import '../models/attendance_log_model.dart';

// /// A controller class for the AttendanceLogScreen.
// ///
// /// This class manages the state of the AttendanceLogScreen, including the
// /// current attendanceLogModelObj
// class AttendanceLogController extends GetxController {
//   TextEditingController searchController = TextEditingController();

//   Rx<AttendanceLogModel> attendanceLogModelObj = AttendanceLogModel().obs;

//   SelectionPopupModel? selectedDropDownValue;

//   SelectionPopupModel? selectedDropDownValue1;

//   @override
//   void onClose() {
//     super.onClose();
//     searchController.dispose();
//   }

//   onSelected(dynamic value) {
//     for (var element in attendanceLogModelObj.value.dropdownItemList.value) {
//       element.isSelected = false;
//       if (element.id == value.id) {
//         element.isSelected = true;
//       }
//     }
//     attendanceLogModelObj.value.dropdownItemList.refresh();
//   }

//   onSelected1(dynamic value) {
//     for (var element in attendanceLogModelObj.value.dropdownItemList1.value) {
//       element.isSelected = false;
//       if (element.id == value.id) {
//         element.isSelected = true;
//       }
//     }
//     attendanceLogModelObj.value.dropdownItemList1.refresh();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:schulup/core/utils/storage.dart';
// import '../../../core/app_export.dart';
// import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
// import '../../../data/apiClient/attendance_api_service.dart';
// import '../../../data/models/attendance_log_response_model.dart';
// import '../models/attendance_log_model.dart';
// import '../models/attendanceloglist_item_model.dart';
// import 'package:intl/intl.dart';

// class AttendanceLogController extends GetxController {
//   TextEditingController searchController = TextEditingController();
//   Rx<AttendanceLogModel> attendanceLogModelObj = AttendanceLogModel().obs;

//   SelectionPopupModel? selectedDropDownValue;
//   SelectionPopupModel? selectedDropDownValue1;

//   // API Service
//   final AttendanceApiService _apiService = AttendanceApiService();

//   // Loading state
//   RxBool isLoading = false.obs;
//   RxBool hasError = false.obs;
//   RxString errorMessage = ''.obs;

//   // Pagination
//   RxInt currentPage = 1.obs;
//   RxInt totalPages = 1.obs;
//   RxInt totalCount = 0.obs;

//   // Filters
//   String? startDate;
//   String? endDate;
//   String? searchName;

//   @override
//   void onInit() {
//     super.onInit();
//     // Load attendance logs on screen init
//     fetchAttendanceLogs();

//     // Listen to search input with debounce
//     searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void onClose() {
//     super.onClose();
//     searchController.dispose();
//   }

//   // Fetch attendance logs from API
//   Future<void> fetchAttendanceLogs({bool isRefresh = false}) async {
//     var schoolCode = await dataBase.getBrmCode();
//     try {
//       if (isRefresh) {
//         currentPage.value = 1;
//       }

//       isLoading.value = true;
//       hasError.value = false;
//       errorMessage.value = '';

//       final response = await _apiService.getAttendanceLogs(
//         schoolCode: schoolCode, // Replace with actual school code from storage/auth
//         attendanceAssociatedPersonType: 1,
//         startDate: startDate,
//         endDate: endDate,
//         name: searchName,
//         page: currentPage.value,
//         pageSize: 30,
//       );

//       if (response.success) {
//         // Update pagination info
//         totalPages.value = response.data.totalPages;
//         totalCount.value = response.data.totalCount;
//         currentPage.value = response.data.page;

//         // Convert API data to list items
//         attendanceLogModelObj.value.attendanceloglistItemList.value =
//             response.data.logs.map((log) => _convertToItemModel(log)).toList();

//         attendanceLogModelObj.value.attendanceloglistItemList.refresh();
//       } else {
//         hasError.value = true;
//         errorMessage.value = response.message;
//       }
//     } catch (e) {
//       hasError.value = true;
//       errorMessage.value = 'Failed to load attendance logs: $e';
//       print('Error fetching attendance logs: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Convert API log to item model
//   AttendanceloglistItemModel _convertToItemModel(AttendanceLog log) {
//     // Format date and time
//     DateTime dateTime = DateTime.parse(log.eventDateTime);
//     String formattedDate = DateFormat('dd/MM/yy').format(dateTime);
//     String formattedTime = DateFormat('h:mma').format(dateTime).toLowerCase();

//     return AttendanceloglistItemModel(
//       precious: log.personName.obs,
//       zipcode: log.cardUID.obs,
//       twentythree: formattedDate.obs,
//       time: formattedTime.obs,
//       pickup: log.eventTypeText.obs,
//       id: log.attendanceLogID.toString().obs,
//     );
//   }

//   // Search functionality
//   void _onSearchChanged() {
//     // Implement debounce if needed
//     searchName = searchController.text.trim();
//     if (searchName!.isEmpty) {
//       searchName = null;
//     }
//     fetchAttendanceLogs(isRefresh: true);
//   }

//   // Manual search trigger
//   void onSearchSubmit() {
//     searchName = searchController.text.trim();
//     if (searchName!.isEmpty) {
//       searchName = null;
//     }
//     fetchAttendanceLogs(isRefresh: true);
//   }

//   // Date filter - Start Date
//   void onStartDateSelected(dynamic value) {
//     for (var element in attendanceLogModelObj.value.dropdownItemList.value) {
//       element.isSelected = false;
//       if (element.id == value.id) {
//         element.isSelected = true;
//         // Set start date (you'll need to implement date picker)
//         // For now, this is a placeholder
//         // startDate = 'YYYY-MM-DD';
//       }
//     }
//     attendanceLogModelObj.value.dropdownItemList.refresh();
//     fetchAttendanceLogs(isRefresh: true);
//   }

//   // Date filter - End Date
//   void onEndDateSelected(dynamic value) {
//     for (var element in attendanceLogModelObj.value.dropdownItemList1.value) {
//       element.isSelected = false;
//       if (element.id == value.id) {
//         element.isSelected = true;
//         // Set end date (you'll need to implement date picker)
//         // For now, this is a placeholder
//         // endDate = 'YYYY-MM-DD';
//       }
//     }
//     attendanceLogModelObj.value.dropdownItemList1.refresh();
//     fetchAttendanceLogs(isRefresh: true);
//   }

//   // Load next page
//   void loadNextPage() {
//     if (currentPage.value < totalPages.value && !isLoading.value) {
//       currentPage.value++;
//       fetchAttendanceLogs();
//     }
//   }

//   // Refresh data
//   Future<void> refreshData() async {
//     await fetchAttendanceLogs(isRefresh: true);
//   }

//   // Legacy methods (keep for compatibility)
//   onSelected(dynamic value) => onStartDateSelected(value);
//   onSelected1(dynamic value) => onEndDateSelected(value);
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:schulup/core/utils/storage.dart';
import '../../../core/app_export.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../../data/apiClient/attendance_api_service.dart';
import '../../../data/models/attendance_log_response_model.dart';
import '../models/attendance_log_model.dart';
import '../models/attendanceloglist_item_model.dart';
import 'package:intl/intl.dart';

class AttendanceLogController extends GetxController {
  TextEditingController searchController = TextEditingController();
  Rx<AttendanceLogModel> attendanceLogModelObj = AttendanceLogModel().obs;

  SelectionPopupModel? selectedDropDownValue;
  SelectionPopupModel? selectedDropDownValue1;

  final AttendanceApiService _apiService = AttendanceApiService();

  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;

  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;
  RxInt totalCount = 0.obs;

  String? startDate;
  String? endDate;
  String? searchName;
  String? searchQuery;

  // Debounce timer for search
  Timer? _searchDebounce;

  //   @override
  //   void onInit() {
  //     super.onInit();
  //     // Load attendance logs on init
  //     fetchAttendanceLogs();

  //     // Setup search listener with debounce
  //     searchController.addListener(_onSearchChanged);
  //   }

  //   @override
  //   void onClose() {
  //     super.onClose();
  //     _searchDebounce?.cancel();
  //     searchController.dispose();
  //   }

  @override
  void onInit() {
    super.onInit();
    print('Controller initialized - fetching data...'); // Debug
    fetchAttendanceLogs();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    super.onClose();
    // searchController.dispose();
  }

  void _onSearchChanged() {
    // Cancel previous timer
    _searchDebounce?.cancel();

    // Wait 500ms after user stops typing
    _searchDebounce = Timer(Duration(milliseconds: 500), () {
      String query = searchController.text.trim();

      if (query.isEmpty) {
        searchQuery = null;
      } else {
        searchQuery = query;
      }

      print('🔍 Search query: $searchQuery');
      fetchAttendanceLogs(isRefresh: true);
    });
  }

  // // Manual search trigger (for search button if needed)
  void onSearchSubmit() {
    _searchDebounce?.cancel();
    String query = searchController.text.trim();
    searchQuery = query.isEmpty ? null : query;
    print('🔍 Manual search: $searchQuery');
    fetchAttendanceLogs(isRefresh: true);
  }

  // Clear search
  void clearSearch() {
    searchController.clear();
    searchQuery = null;
    fetchAttendanceLogs(isRefresh: true);
  }

  Future<void> fetchAttendanceLogs({bool isRefresh = false}) async {
    var schoolCode = await dataBase.getBrmCode();
    try {
      if (isRefresh) {
        currentPage.value = 1;
      }

      print('Fetching attendance logs...'); // Debug
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final response = await _apiService.getAttendanceLogs(
        schoolCode: schoolCode,
        attendanceAssociatedPersonType: 1,
        startDate: startDate,
        endDate: endDate,
        name: searchQuery,
        page: currentPage.value,
        pageSize: 30,
      );

      print(
        'API Response received: ${response.data.logs.length} logs',
      ); // Debug

      if (response.success) {
        totalPages.value = response.data.totalPages;
        totalCount.value = response.data.totalCount;
        currentPage.value = response.data.page;

        attendanceLogModelObj.value.attendanceloglistItemList.value =
            response.data.logs.map((log) => _convertToItemModel(log)).toList();

        attendanceLogModelObj.value.attendanceloglistItemList.refresh();
        print('List updated with ${response.data.logs.length} items'); // Debug
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to load: $e';
      print('Error in fetchAttendanceLogs: $e'); // Debug
    } finally {
      isLoading.value = false;
    }
  }

  AttendanceloglistItemModel _convertToItemModel(AttendanceLog log) {
    DateTime dateTime = DateTime.parse(log.eventDateTime);
    String formattedDate = DateFormat('dd/MM/yy').format(dateTime);
    String formattedTime = DateFormat('h:mma').format(dateTime).toLowerCase();

    return AttendanceloglistItemModel(
      precious: log.personName.obs,
      zipcode: log.cardUID.obs,
      twentythree: formattedDate.obs,
      time: formattedTime.obs,
      pickup: log.eventTypeText.obs,
      id: log.attendanceLogID.toString().obs,
    );
  }

  // void onSearchSubmit() {
  //   searchName = searchController.text.trim();
  //   if (searchName!.isEmpty) searchName = null;
  //   fetchAttendanceLogs(isRefresh: true);
  // }

  Future<void> refreshData() async {
    await fetchAttendanceLogs(isRefresh: true);
  }

  // Date pickers
  Rx<DateTime?> selectedStartDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectedEndDate = Rx<DateTime?>(null);

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate.value ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedStartDate.value = picked;
      startDate = DateFormat('yyyy-MM-dd').format(picked);
      print('Start date selected: $startDate'); // Debug
      fetchAttendanceLogs(isRefresh: true);
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate.value ?? DateTime.now(),
      firstDate: selectedStartDate.value ?? DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedEndDate.value = picked;
      endDate = DateFormat('yyyy-MM-dd').format(picked);
      print('End date selected: $endDate'); // Debug
      fetchAttendanceLogs(isRefresh: true);
    }
  }

  void clearStartDate() {
    selectedStartDate.value = null;
    startDate = null;
    fetchAttendanceLogs(isRefresh: true);
  }

  void clearEndDate() {
    selectedEndDate.value = null;
    endDate = null;
    fetchAttendanceLogs(isRefresh: true);
  }

  onSelected(dynamic value) {
    for (var element in attendanceLogModelObj.value.dropdownItemList.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    attendanceLogModelObj.value.dropdownItemList.refresh();
  }

  onSelected1(dynamic value) {
    for (var element in attendanceLogModelObj.value.dropdownItemList1.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    attendanceLogModelObj.value.dropdownItemList1.refresh();
  }

  void nextPage() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      fetchAttendanceLogs();
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      fetchAttendanceLogs();
    }
  }
}

// ============= UPDATED CONTROLLER WITH WORKING SEARCH & PAGINATION =============
// File: controller/attendance_log_controller.dart

// import 'dart:async';

// import 'package:flutter/material.dart';
// import '../../../core/app_export.dart';
// import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
// import '../../../data/apiClient/attendance_api_service.dart';
// import '../../../data/models/attendance_log_response_model.dart';
// import '../models/attendance_log_model.dart';
// import '../models/attendanceloglist_item_model.dart';
// import 'package:intl/intl.dart';

// class AttendanceLogController extends GetxController {
//   TextEditingController searchController = TextEditingController();
//   Rx<AttendanceLogModel> attendanceLogModelObj = AttendanceLogModel().obs;
  
//   SelectionPopupModel? selectedDropDownValue;
//   SelectionPopupModel? selectedDropDownValue1;
  
//   // API Service
//   final AttendanceApiService _apiService = AttendanceApiService();
  
//   // Loading & Error states
//   RxBool isLoading = false.obs;
//   RxBool hasError = false.obs;
//   RxString errorMessage = ''.obs;
  
//   // Pagination
//   RxInt currentPage = 1.obs;
//   RxInt totalPages = 1.obs;
//   RxInt totalCount = 0.obs;
//   RxInt pageSize = 30.obs;
//   RxBool hasMorePages = false.obs;
//   RxBool isLoadingMore = false.obs;
  
//   // Filters
//   String? startDate;
//   String? endDate;
//   String? searchQuery;
  
//   // Date pickers
//   Rx<DateTime?> selectedStartDate = Rx<DateTime?>(null);
//   Rx<DateTime?> selectedEndDate = Rx<DateTime?>(null);
  
//   // Debounce timer for search
//   Timer? _searchDebounce;
  
//   @override
//   void onInit() {
//     super.onInit();
//     // Load attendance logs on init
//     fetchAttendanceLogs();
    
//     // Setup search listener with debounce
//     searchController.addListener(_onSearchChanged);
//   }
  
//   @override
//   void onClose() {
//     super.onClose();
//     _searchDebounce?.cancel();
//     searchController.dispose();
//   }
  
//   // ============= SEARCH WITH DEBOUNCE =============
//   void _onSearchChanged() {
//     // Cancel previous timer
//     _searchDebounce?.cancel();
    
//     // Wait 500ms after user stops typing
//     _searchDebounce = Timer(Duration(milliseconds: 500), () {
//       String query = searchController.text.trim();
      
//       if (query.isEmpty) {
//         searchQuery = null;
//       } else {
//         searchQuery = query;
//       }
      
//       print('🔍 Search query: $searchQuery');
//       fetchAttendanceLogs(isRefresh: true);
//     });
//   }
  
//   // Manual search trigger (for search button if needed)
//   void onSearchSubmit() {
//     _searchDebounce?.cancel();
//     String query = searchController.text.trim();
//     searchQuery = query.isEmpty ? null : query;
//     print('🔍 Manual search: $searchQuery');
//     fetchAttendanceLogs(isRefresh: true);
//   }
  
//   // Clear search
//   void clearSearch() {
//     searchController.clear();
//     searchQuery = null;
//     fetchAttendanceLogs(isRefresh: true);
//   }
  
//   // ============= FETCH ATTENDANCE LOGS =============
//   Future<void> fetchAttendanceLogs({bool isRefresh = false}) async {
//     try {
//       if (isRefresh) {
//         currentPage.value = 1;
//         isLoading.value = true;
//       } else {
//         isLoadingMore.value = true;
//       }
      
//       hasError.value = false;
//       errorMessage.value = '';
      
//       print('📥 Fetching logs - Page: ${currentPage.value}, Search: $searchQuery');
      
//       final response = await _apiService.getAttendanceLogs(
//         schoolCode: 'demo', // Replace with actual school code
//         attendanceAssociatedPersonType: 1,
//         startDate: startDate,
//         endDate: endDate,
//         name: searchQuery,
//         page: currentPage.value,
//         pageSize: pageSize.value,
//       );
      
//       if (response.success) {
//         totalPages.value = response.data.totalPages;
//         totalCount.value = response.data.totalCount;
//         currentPage.value = response.data.page;
//         hasMorePages.value = currentPage.value < totalPages.value;
        
//         // Convert API data to list items
//         List<AttendanceloglistItemModel> newItems = 
//           response.data.logs.map((log) => _convertToItemModel(log)).toList();
        
//         if (isRefresh) {
//           // Replace all items
//           attendanceLogModelObj.value.attendanceloglistItemList.value = newItems;
//         } else {
//           // Append items for pagination
//           attendanceLogModelObj.value.attendanceloglistItemList.value.addAll(newItems);
//         }
        
//         attendanceLogModelObj.value.attendanceloglistItemList.refresh();
        
//         print('✅ Loaded ${newItems.length} items. Total: ${totalCount.value}');
//       } else {
//         hasError.value = true;
//         errorMessage.value = response.message;
//       }
//     } catch (e) {
//       hasError.value = true;
//       errorMessage.value = 'Failed to load attendance logs: $e';
//       print('❌ Error fetching logs: $e');
//     } finally {
//       isLoading.value = false;
//       isLoadingMore.value = false;
//     }
//   }
  
//   // ============= LOAD NEXT PAGE =============
//   Future<void> loadNextPage() async {
//     if (!hasMorePages.value || isLoadingMore.value || isLoading.value) {
//       return;
//     }
    
//     print('📄 Loading page ${currentPage.value + 1}...');
//     currentPage.value++;
//     await fetchAttendanceLogs();
//   }
  
//   // ============= REFRESH DATA =============
//   Future<void> refreshData() async {
//     print('🔄 Refreshing data...');
//     await fetchAttendanceLogs(isRefresh: true);
//   }
  
//   // ============= CONVERT API MODEL =============
//   AttendanceloglistItemModel _convertToItemModel(AttendanceLog log) {
//     DateTime dateTime = DateTime.parse(log.eventDateTime);
//     String formattedDate = DateFormat('dd/MM/yy').format(dateTime);
//     String formattedTime = DateFormat('h:mma').format(dateTime).toLowerCase();
    
//     return AttendanceloglistItemModel(
//       precious: log.personName.obs,
//       zipcode: log.cardUID.obs,
//       twentythree: formattedDate.obs,
//       time: formattedTime.obs,
//       pickup: log.eventTypeText.obs,
//       id: log.attendanceLogID.toString().obs,
//     );
//   }
  
//   // ============= DATE FILTERS =============
//   Future<void> selectStartDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedStartDate.value ?? DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime.now(),
//     );
    
//     if (picked != null) {
//       selectedStartDate.value = picked;
//       startDate = DateFormat('yyyy-MM-dd').format(picked);
//       print('📅 Start date: $startDate');
//       fetchAttendanceLogs(isRefresh: true);
//     }
//   }
  
//   Future<void> selectEndDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedEndDate.value ?? DateTime.now(),
//       firstDate: selectedStartDate.value ?? DateTime(2020),
//       lastDate: DateTime.now(),
//     );
    
//     if (picked != null) {
//       selectedEndDate.value = picked;
//       endDate = DateFormat('yyyy-MM-dd').format(picked);
//       print('📅 End date: $endDate');
//       fetchAttendanceLogs(isRefresh: true);
//     }
//   }
  
//   void clearStartDate() {
//     selectedStartDate.value = null;
//     startDate = null;
//     fetchAttendanceLogs(isRefresh: true);
//   }
  
//   void clearEndDate() {
//     selectedEndDate.value = null;
//     endDate = null;
//     fetchAttendanceLogs(isRefresh: true);
//   }
  
//   void clearAllFilters() {
//     searchController.clear();
//     searchQuery = null;
//     selectedStartDate.value = null;
//     selectedEndDate.value = null;
//     startDate = null;
//     endDate = null;
//     fetchAttendanceLogs(isRefresh: true);
//   }
  
//   // Legacy methods for dropdown compatibility
//   onSelected(dynamic value) {
//     for (var element in attendanceLogModelObj.value.dropdownItemList.value) {
//       element.isSelected = false;
//       if (element.id == value.id) {
//         element.isSelected = true;
//       }
//     }
//     attendanceLogModelObj.value.dropdownItemList.refresh();
//   }
  
//   onSelected1(dynamic value) {
//     for (var element in attendanceLogModelObj.value.dropdownItemList1.value) {
//       element.isSelected = false;
//       if (element.id == value.id) {
//         element.isSelected = true;
//       }
//     }
//     attendanceLogModelObj.value.dropdownItemList1.refresh();
//   }
// }