import 'dart:io';
import 'dart:typed_data';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:developer' as myLog;
import 'package:nfc_manager/src/nfc_manager_android/pigeon.g.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:schulup/presentation/drop_off_scan_screen/models/card_model.dart';
import 'package:schulup/presentation/drop_off_scan_success_modal_dialog/controller/drop_off_scan_success_modal_controller.dart';
import 'package:schulup/presentation/drop_off_scan_success_modal_dialog/drop_off_scan_success_modal_dialog.dart';
import '../../../core/app_export.dart';
import '../models/drop_off_scan_model.dart';

import 'package:overlay_kit/overlay_kit.dart';
import 'package:schulup/core/utils/database_helper.dart';
import 'package:schulup/core/utils/storage.dart';
import 'package:schulup/data/apiClient/api_client.dart';

import 'dart:developer' as myLog;

/// A controller class for the DropOffScanScreen.
///
/// This class manages the state of the DropOffScanScreen, including the
/// current dropOffScanModelObj
class DropOffScanController extends GetxController {
  Rx<DropOffScanModel> dropOffScanModelObj = DropOffScanModel().obs;

  RxString dropOffId = ''.obs;
  RxString pickUpId = ''.obs;
  RxString checkInId = ''.obs;
  RxString checkOutId = ''.obs;

  RxBool isDropOffScanning = false.obs;
  RxBool isPickUpScanning = false.obs;
  RxBool isCheckInScanning = false.obs;
  RxBool isCheckOutScanning = false.obs;
  RxBool isRegisterCardScanning = false.obs;
  RxBool availabilityx = false.obs;
  ApiClient _apiService = ApiClient(Duration(seconds: 60 * 5));

  StreamSubscription? _connectivitySubscription;
  final FocusNode focusNode = FocusNode();
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  final TextEditingController textController3 = TextEditingController();
  final TextEditingController textController4 = TextEditingController();
  final TextEditingController textController5 = TextEditingController();

  RxString _status = "Ready".obs;
  RxString _cardBuffer = "".obs;
  RxList<CardScan> _scannedCards = RxList<CardScan>();

  Timer? _bufferTimer;

  @override
  void onInit() {
    super.onInit();
    // Listen for connectivity changes
    final networkInfo = NetworkInfo();
    _connectivitySubscription = networkInfo.onConnectivityChanged.listen((_) {
      syncQueuedRequests();
    });
    checkNFC();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });

    textController1.addListener(_onTextChanged1);
    textController2.addListener(_onTextChanged2);
    textController3.addListener(_onTextChanged3);
    textController4.addListener(_onTextChanged4);
    textController5.addListener(_onTextChanged5);
  }

  //TODO FOR DROP OFF

  void _onTextChanged1() {
    //isDropOffScanning.value = true;

    String text = textController1.text;

    print(text);

    if (text.isEmpty) return;

    // Cancel previous timer
    _bufferTimer?.cancel();

    // Check if text contains newline (Enter key pressed)
    if (text.contains('\n')) {
      String cardId = text.replaceAll('\n', '').trim();
      if (cardId.isNotEmpty) {
        _processCardId1(cardId);
      }
      textController1.clear();
      _cardBuffer.value = "";
    } else {
      // Set timer to process if no more input comes
      _cardBuffer.value = text;
      _bufferTimer = Timer(Duration(milliseconds: 500), () {
        if (_cardBuffer.isNotEmpty) {
          _processCardId1(_cardBuffer.trim());
          textController1.clear();
          _cardBuffer.value = "";
        }
      });
    }
  }

  void _processCardId1(String cardId) {
    // Filter out non-alphanumeric characters if needed
    cardId = cardId.replaceAll(RegExp(r'[^\w\s]'), '');

    if (cardId.isEmpty || cardId.length < 4) return;

    // Avoid duplicate scans within 2 seconds
    final now = DateTime.now();
    if (_scannedCards.isNotEmpty) {
      final lastScan = _scannedCards.first;
      if (lastScan.cardId == cardId &&
          now.difference(lastScan.timestamp).inSeconds < 2) {
        return;
      }
    }

    _scannedCards.insert(0, CardScan(cardId: cardId, timestamp: now));
    _status.value = "Card Scanned!";

    //dropOff(cardId);
    //_showCardDialog(cardId);
    isDropOffScanning.value = false;
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        content: DropOffScanSuccessModalDialog(
          Get.put(DropOffScanSuccessModalController()),
          cardId.toString(),
          () => dropOff(cardId.toString()),
        ),
      ),
    );

    // Reset status after 2 seconds
    Timer(Duration(seconds: 2), () {});
  }

  //TODO: FOR PICKUP

  void _onTextChanged2() {
    String text = textController2.text;
    print(text);
    if (text.isEmpty) return;

    // Cancel previous timer
    _bufferTimer?.cancel();

    // Check if text contains newline (Enter key pressed)
    if (text.contains('\n')) {
      String cardId = text.replaceAll('\n', '').trim();
      if (cardId.isNotEmpty) {
        _processCardId2(cardId);
      }
      textController2.clear();
      _cardBuffer.value = "";
    } else {
      // Set timer to process if no more input comes
      _cardBuffer.value = text;
      _bufferTimer = Timer(Duration(milliseconds: 500), () {
        if (_cardBuffer.isNotEmpty) {
          _processCardId2(_cardBuffer.trim());
          textController2.clear();
          _cardBuffer.value = "";
        }
      });
    }
  }

  void _processCardId2(String cardId) {
    // Filter out non-alphanumeric characters if needed
    cardId = cardId.replaceAll(RegExp(r'[^\w\s]'), '');

    if (cardId.isEmpty || cardId.length < 4) return;

    // Avoid duplicate scans within 2 seconds
    final now = DateTime.now();
    if (_scannedCards.isNotEmpty) {
      final lastScan = _scannedCards.first;
      if (lastScan.cardId == cardId &&
          now.difference(lastScan.timestamp).inSeconds < 2) {
        return;
      }
    }

    _scannedCards.insert(0, CardScan(cardId: cardId, timestamp: now));
    _status.value = "Card Scanned!";

    //pickUp(cardId);
    //_showCardDialog(cardId);
    isPickUpScanning.value = false;
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        content: DropOffScanSuccessModalDialog(
          Get.put(DropOffScanSuccessModalController()),
          cardId.toString(),
          () => pickUp(cardId.toString()),
        ),
      ),
    );

    // Reset status after 2 seconds
    Timer(Duration(seconds: 2), () {});
  }

  //TODO: FOR CHECK IN

  void _onTextChanged3() {
    String text = textController3.text;
    print(text);
    if (text.isEmpty) return;

    // Cancel previous timer
    _bufferTimer?.cancel();

    // Check if text contains newline (Enter key pressed)
    if (text.contains('\n')) {
      String cardId = text.replaceAll('\n', '').trim();
      if (cardId.isNotEmpty) {
        _processCardId3(cardId);
      }
      textController3.clear();
      _cardBuffer.value = "";
    } else {
      // Set timer to process if no more input comes
      _cardBuffer.value = text;
      _bufferTimer = Timer(Duration(milliseconds: 500), () {
        if (_cardBuffer.isNotEmpty) {
          _processCardId3(_cardBuffer.trim());
          textController3.clear();
          _cardBuffer.value = "";
        }
      });
    }
  }

  void _processCardId3(String cardId) {
    // Filter out non-alphanumeric characters if needed
    cardId = cardId.replaceAll(RegExp(r'[^\w\s]'), '');

    if (cardId.isEmpty || cardId.length < 4) return;

    // Avoid duplicate scans within 2 seconds
    final now = DateTime.now();
    if (_scannedCards.isNotEmpty) {
      final lastScan = _scannedCards.first;
      if (lastScan.cardId == cardId &&
          now.difference(lastScan.timestamp).inSeconds < 2) {
        return;
      }
    }

    _scannedCards.insert(0, CardScan(cardId: cardId, timestamp: now));
    _status.value = "Card Scanned!";

    //pickUp(cardId);
    //_showCardDialog(cardId);
    isCheckInScanning.value = false;
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        content: DropOffScanSuccessModalDialog(
          Get.put(DropOffScanSuccessModalController()),
          cardId.toString(),
          () => checkIn(cardId.toString()),
        ),
      ),
    );

    // Reset status after 2 seconds
    Timer(Duration(seconds: 2), () {});
  }

  //TODO: FOR CheckOut

  void _onTextChanged4() {
    String text = textController4.text;
    print(text);
    if (text.isEmpty) return;

    // Cancel previous timer
    _bufferTimer?.cancel();

    // Check if text contains newline (Enter key pressed)
    if (text.contains('\n')) {
      String cardId = text.replaceAll('\n', '').trim();
      if (cardId.isNotEmpty) {
        _processCardId4(cardId);
      }
      textController4.clear();
      _cardBuffer.value = "";
    } else {
      // Set timer to process if no more input comes
      _cardBuffer.value = text;
      _bufferTimer = Timer(Duration(milliseconds: 500), () {
        if (_cardBuffer.isNotEmpty) {
          _processCardId4(_cardBuffer.trim());
          textController4.clear();
          _cardBuffer.value = "";
        }
      });
    }
  }

  void _processCardId4(String cardId) {
    // Filter out non-alphanumeric characters if needed
    cardId = cardId.replaceAll(RegExp(r'[^\w\s]'), '');

    if (cardId.isEmpty || cardId.length < 4) return;

    // Avoid duplicate scans within 2 seconds
    final now = DateTime.now();
    if (_scannedCards.isNotEmpty) {
      final lastScan = _scannedCards.first;
      if (lastScan.cardId == cardId &&
          now.difference(lastScan.timestamp).inSeconds < 2) {
        return;
      }
    }

    _scannedCards.insert(0, CardScan(cardId: cardId, timestamp: now));
    _status.value = "Card Scanned!";

    //pickUp(cardId);
    //_showCardDialog(cardId);
    isCheckOutScanning.value = false;
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        content: DropOffScanSuccessModalDialog(
          Get.put(DropOffScanSuccessModalController()),
          cardId.toString(),
          () => checkOut(cardId.toString()),
        ),
      ),
    );

    // Reset status after 2 seconds
    Timer(Duration(seconds: 2), () {});
  }

  //TODO FOR REGISTER CARD

  void _onTextChanged5() {
    //isDropOffScanning.value = true;

    String text = textController5.text;

    if (text.isEmpty) return;

    // Cancel previous timer
    _bufferTimer?.cancel();

    // Check if text contains newline (Enter key pressed)
    if (text.contains('\n')) {
      String cardId = text.replaceAll('\n', '').trim();
      if (cardId.isNotEmpty) {
        _processCardId5(cardId);
      }
      textController5.clear();
      _cardBuffer.value = "";
    } else {
      // Set timer to process if no more input comes
      _cardBuffer.value = text;
      _bufferTimer = Timer(Duration(milliseconds: 500), () {
        if (_cardBuffer.isNotEmpty) {
          _processCardId5(_cardBuffer.trim());
          textController5.clear();
          _cardBuffer.value = "";
        }
      });
    }
  }

  void _processCardId5(String cardId) {
    // Filter out non-alphanumeric characters if needed
    cardId = cardId.replaceAll(RegExp(r'[^\w\s]'), '');

    if (cardId.isEmpty || cardId.length < 4) return;

    // Avoid duplicate scans within 2 seconds
    final now = DateTime.now();
    if (_scannedCards.isNotEmpty) {
      final lastScan = _scannedCards.first;
      if (lastScan.cardId == cardId &&
          now.difference(lastScan.timestamp).inSeconds < 2) {
        return;
      }
    }

    _scannedCards.insert(0, CardScan(cardId: cardId, timestamp: now));
    _status.value = "Card Scanned!";

    //dropOff(cardId);
    //_showCardDialog(cardId);
    isRegisterCardScanning.value = false;
    Get.toNamed(AppRoutes.scannedCardScreen, arguments: cardId);

    // Reset status after 2 seconds
    Timer(Duration(seconds: 2), () {});
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    super.onClose();
    isDropOffScanning = false.obs;
    isPickUpScanning = false.obs;
    isCheckInScanning = false.obs;
    isCheckOutScanning = false.obs;
    availabilityx = false.obs;
    //focusNode.dispose();
    // textController1.dispose();
    // textController2.dispose();
    // textController3.dispose();
    // textController4.dispose();
    
    stopScan();
  }

  void stopScan() async {
    await NfcManager.instance.stopSession();
  }

  void checkNFC() async {
    bool availability = await NfcManager.instance.isAvailable();
    availabilityx.value = availability;
    update();
    if (!availability) {
      print("NFC may not be supported or may be temporarily disabled");
    } else {
      print("NFC is supported");
    }
  }

  void scanCardCheckout() async {
    if (isCheckOutScanning.value) {
      print("⚠️ Scan already in progress, skipping new session.");
      return;
    }

    isCheckOutScanning.value = true;
    print('📡 Starting NFC scan...');
    isCheckInScanning.value = true;

    bool available = await NfcManager.instance.isAvailable();
    if (!available) {
      print("❌ NFC not available on this device or temporarily disabled.");
      // isDropOffScanning.value = false;
      isCheckOutScanning.value = false;
      return;
    }

    try {
      // Ensure previous session is closed
      await NfcManager.instance.stopSession();

      // Start fresh
      await NfcManager.instance.startSession(
        pollingOptions: {NfcPollingOption.iso14443},
        onDiscovered: (NfcTag tag) async {
          try {
            final TagPigeon data = tag.data as TagPigeon;
            Uint8List idBytes = Uint8List.fromList(data.id.cast<int>());
            final reversedBytes = idBytes.reversed.toList();

            final hex =
                reversedBytes
                    .map((b) => b.toRadixString(16).padLeft(2, '0'))
                    .join('')
                    .toUpperCase();
            final decimal = int.tryParse(hex, radix: 16);

            print('✅ Card UID (bytes): $idBytes');
            print('✅ Card UID (HEX Reversed): $hex');
            print('✅ Card UID (DEC Reversed): $decimal');

            await NfcManager.instance
                .stopSession(); // stop cleanly before showing dialog

            // Show dialog after stopping NFC
            Get.dialog(
              AlertDialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.zero,
                content: DropOffScanSuccessModalDialog(
                  Get.put(DropOffScanSuccessModalController()),
                  decimal.toString(),
                  () => checkOut(decimal.toString()),
                ),
              ),
            );
          } catch (e) {
            print('❌ Error processing NFC tag: $e');
            await NfcManager.instance.stopSession(
              errorMessageIos: 'Error reading tag',
            );
          } finally {
            //isDropOffScanning.value = false;
            isCheckOutScanning.value = false;
          }
        },
      );
    } catch (e) {
      print('❌ Error starting NFC session: $e');
      isCheckOutScanning.value = false;
      //isDropOffScanning.value = false;
    }
  }

  // void scanCardCheckout() {
  //   print('📡 Startng NFC scan...');
  //   isCheckOutScanning.value = true;
  //   if (availabilityx.value) {
  //     NfcManager.instance.startSession(
  //       pollingOptions: {NfcPollingOption.iso14443},
  //       onDiscovered: (NfcTag tag) async {
  //         try {
  //           final TagPigeon data = tag.data as TagPigeon;

  //           // The card UID bytes (the unique ID of the tag)
  //           Uint8List idBytes = Uint8List.fromList(data.id.cast<int>());

  //           final reversedBytes = idBytes.reversed.toList();

  //           // Convert to HEX and DEC
  //           final hex =
  //               reversedBytes
  //                   .map((b) => b.toRadixString(16).padLeft(2, '0'))
  //                   .join('')
  //                   .toUpperCase();
  //           final decimal = int.tryParse(hex, radix: 16);

  //           print('✅ Card UID (bytes): $idBytes');
  //           print(
  //             '✅ Card UID (HEX NFC order): ${idBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join('').toUpperCase()}',
  //           );
  //           print('✅ Card UID (HEX Reversed): $hex');
  //           print('✅ Card UID (DEC Reversed): $decimal');
  //           //Get.toNamed(AppRoutes.successModalScreen, arguments: decimal);
  //           //Get.toNamed(AppRoutes.scannedCardScreen, arguments: decimal);
  //           //checkOutId.value = decimal.toString();
  //          // await NfcManager.instance.stopSession();
  //           Get.dialog(
  //             AlertDialog(
  //               backgroundColor: Colors.transparent,
  //               insetPadding: EdgeInsets.zero,
  //               content: DropOffScanSuccessModalDialog(
  //                 Get.put(DropOffScanSuccessModalController()),
  //                 decimal.toString(),
  //                 () => checkOut(decimal.toString()),
  //               ),
  //             ),
  //           );
  //           final nfcA = data.nfcA;
  //           if (nfcA != null) {
  //             print('📘 NFC-A tag detected: ${nfcA.toString()}');
  //           }
  //         } catch (e) {
  //           print('❌ Error reading tag: $e');
  //         } finally {
  //           isCheckOutScanning.value = false;
  //           await NfcManager.instance.stopSession();
  //           // Future.delayed(
  //           //   const Duration(seconds: 1),
  //           //   scanCard,
  //           // ); // re-scan automatically
  //         }
  //       },
  //     );
  //   }
  // }

  void scanCardCheckin() async {
    if (isCheckInScanning.value) {
      print("⚠️ Scan already in progress, skipping new session.");
      return;
    }

    isCheckInScanning.value = true;
    print('📡 Starting NFC scan...');
    isCheckInScanning.value = true;

    bool available = await NfcManager.instance.isAvailable();
    if (!available) {
      print("❌ NFC not available on this device or temporarily disabled.");
      // isDropOffScanning.value = false;
      isCheckInScanning.value = false;
      return;
    }

    try {
      // Ensure previous session is closed
      await NfcManager.instance.stopSession();

      // Start fresh
      await NfcManager.instance.startSession(
        pollingOptions: {NfcPollingOption.iso14443},
        onDiscovered: (NfcTag tag) async {
          try {
            final TagPigeon data = tag.data as TagPigeon;
            Uint8List idBytes = Uint8List.fromList(data.id.cast<int>());
            final reversedBytes = idBytes.reversed.toList();

            final hex =
                reversedBytes
                    .map((b) => b.toRadixString(16).padLeft(2, '0'))
                    .join('')
                    .toUpperCase();
            final decimal = int.tryParse(hex, radix: 16);

            print('✅ Card UID (bytes): $idBytes');
            print('✅ Card UID (HEX Reversed): $hex');
            print('✅ Card UID (DEC Reversed): $decimal');

            await NfcManager.instance
                .stopSession(); // stop cleanly before showing dialog

            // Show dialog after stopping NFC
            Get.dialog(
              AlertDialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.zero,
                content: DropOffScanSuccessModalDialog(
                  Get.put(DropOffScanSuccessModalController()),
                  decimal.toString(),
                  () => checkIn(decimal.toString()),
                ),
              ),
            );
          } catch (e) {
            print('❌ Error processing NFC tag: $e');
            await NfcManager.instance.stopSession(
              errorMessageIos: 'Error reading tag',
            );
          } finally {
            //isDropOffScanning.value = false;
            isCheckInScanning.value = false;
          }
        },
      );
    } catch (e) {
      print('❌ Error starting NFC session: $e');
      isPickUpScanning.value = false;
      //isDropOffScanning.value = false;
    }
  }

  // void scanCardCheckin() {
  //   print('📡 Starting NFC scan...');
  //   isCheckInScanning.value = true;
  //   if (availabilityx.value) {
  //     NfcManager.instance.startSession(
  //       pollingOptions: {NfcPollingOption.iso14443},
  //       onDiscovered: (NfcTag tag) async {
  //         try {
  //           final TagPigeon data = tag.data as TagPigeon;

  //           // The card UID bytes (the unique ID of the tag)
  //           Uint8List idBytes = Uint8List.fromList(data.id.cast<int>());

  //           final reversedBytes = idBytes.reversed.toList();

  //           // Convert to HEX and DEC
  //           final hex =
  //               reversedBytes
  //                   .map((b) => b.toRadixString(16).padLeft(2, '0'))
  //                   .join('')
  //                   .toUpperCase();
  //           final decimal = int.tryParse(hex, radix: 16);

  //           print('✅ Card UID (bytes): $idBytes');
  //           print(
  //             '✅ Card UID (HEX NFC order): ${idBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join('').toUpperCase()}',
  //           );
  //           print('✅ Card UID (HEX Reversed): $hex');
  //           print('✅ Card UID (DEC Reversed): $decimal');
  //           //Get.toNamed(AppRoutes.successModalScreen, arguments: decimal);
  //           //Get.toNamed(AppRoutes.scannedCardScreen, arguments: decimal);
  //           //checkInId.value = decimal.toString();
  //          // await NfcManager.instance.stopSession();
  //           Get.dialog(
  //             AlertDialog(
  //               backgroundColor: Colors.transparent,
  //               insetPadding: EdgeInsets.zero,
  //               content: DropOffScanSuccessModalDialog(
  //                 Get.put(DropOffScanSuccessModalController()),
  //                 decimal.toString(),
  //                 () => checkIn(decimal.toString()),
  //               ),
  //             ),
  //           );
  //           final nfcA = data.nfcA;
  //           if (nfcA != null) {
  //             print('📘 NFC-A tag detected: ${nfcA.toString()}');
  //           }
  //         } catch (e) {
  //           print('❌ Error reading tag: $e');
  //         } finally {
  //           isCheckInScanning.value = false;
  //           await NfcManager.instance.stopSession();
  //           // Future.delayed(
  //           //   const Duration(seconds: 1),
  //           //   scanCard,
  //           // ); // re-scan automatically
  //         }
  //       },
  //     );
  //   }
  // }

  void scanCardPickup() async {
    if (isPickUpScanning.value) {
      print("⚠️ Scan already in progress, skipping new session.");
      return;
    }

    isPickUpScanning.value = true;
    print('📡 Starting NFC scan...');
    isDropOffScanning.value = true;

    bool available = await NfcManager.instance.isAvailable();
    if (!available) {
      print("❌ NFC not available on this device or temporarily disabled.");
      // isDropOffScanning.value = false;
      isPickUpScanning.value = false;
      return;
    }

    try {
      // Ensure previous session is closed
      await NfcManager.instance.stopSession();

      // Start fresh
      await NfcManager.instance.startSession(
        pollingOptions: {NfcPollingOption.iso14443},
        onDiscovered: (NfcTag tag) async {
          try {
            final TagPigeon data = tag.data as TagPigeon;
            Uint8List idBytes = Uint8List.fromList(data.id.cast<int>());
            final reversedBytes = idBytes.reversed.toList();

            final hex =
                reversedBytes
                    .map((b) => b.toRadixString(16).padLeft(2, '0'))
                    .join('')
                    .toUpperCase();
            final decimal = int.tryParse(hex, radix: 16);

            print('✅ Card UID (bytes): $idBytes');
            print('✅ Card UID (HEX Reversed): $hex');
            print('✅ Card UID (DEC Reversed): $decimal');

            await NfcManager.instance
                .stopSession(); // stop cleanly before showing dialog

            // Show dialog after stopping NFC
            Get.dialog(
              AlertDialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.zero,
                content: DropOffScanSuccessModalDialog(
                  Get.put(DropOffScanSuccessModalController()),
                  decimal.toString(),
                  () => pickUp(decimal.toString()),
                ),
              ),
            );
          } catch (e) {
            print('❌ Error processing NFC tag: $e');
            await NfcManager.instance.stopSession(
              errorMessageIos: 'Error reading tag',
            );
          } finally {
            //isDropOffScanning.value = false;
            isPickUpScanning.value = false;
          }
        },
      );
    } catch (e) {
      print('❌ Error starting NFC session: $e');
      isPickUpScanning.value = false;
      //isDropOffScanning.value = false;
    }
  }

  // void scanCardpickup() {
  //   print('📡 Starting NFC scan... pickup');
  //   isPickUpScanning.value = true;
  //   if (availabilityx.value) {
  //     NfcManager.instance.startSession(
  //       pollingOptions: {NfcPollingOption.iso14443},
  //       onDiscovered: (NfcTag tag) async {
  //         try {
  //           final TagPigeon data = tag.data as TagPigeon;

  //           // The card UID bytes (the unique ID of the tag)
  //           Uint8List idBytes = Uint8List.fromList(data.id.cast<int>());

  //           final reversedBytes = idBytes.reversed.toList();

  //           // Convert to HEX and DEC
  //           final hex =
  //               reversedBytes
  //                   .map((b) => b.toRadixString(16).padLeft(2, '0'))
  //                   .join('')
  //                   .toUpperCase();
  //           final decimal = int.tryParse(hex, radix: 16);

  //           print('✅ Card UID (bytes): $idBytes');
  //           print(
  //             '✅ Card UID (HEX NFC order): ${idBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join('').toUpperCase()}',
  //           );
  //           print('✅ Card UID (HEX Reversed): $hex');
  //           print('✅ Card UID (DEC Reversed): $decimal');
  //           //Get.toNamed(AppRoutes.successModalScreen, arguments: decimal);
  //           //Get.toNamed(AppRoutes.scannedCardScreen, arguments: decimal);
  //           // pickUpId.value = decimal.toString();
  //          // await NfcManager.instance.stopSession();
  //           Get.dialog(
  //             AlertDialog(
  //               backgroundColor: Colors.transparent,
  //               insetPadding: EdgeInsets.zero,
  //               content: DropOffScanSuccessModalDialog(
  //                 Get.put(DropOffScanSuccessModalController()),
  //                 decimal.toString(),
  //                 () => pickUp(decimal.toString()),
  //               ),
  //             ),
  //           );
  //           final nfcA = data.nfcA;
  //           if (nfcA != null) {
  //             print('📘 NFC-A tag detected: ${nfcA.toString()}');
  //           }
  //         } catch (e) {
  //           print('❌ Error reading tag: $e');
  //         } finally {
  //           isPickUpScanning.value = false;
  //           await NfcManager.instance.stopSession();
  //           // Future.delayed(
  //           //   const Duration(seconds: 1),
  //           //   scanCard,
  //           // ); // re-scan automatically
  //         }
  //       },
  //     );
  //   }
  // }

  // void scanCarddropoff() {
  //   print('📡 Starting NFC scan...');
  //   isDropOffScanning.value = true;
  //   if (availabilityx.value) {
  //     NfcManager.instance.startSession(
  //       pollingOptions: {NfcPollingOption.iso14443},
  //       onDiscovered: (NfcTag tag) async {
  //         try {
  //           final TagPigeon data = tag.data as TagPigeon;

  //           // The card UID bytes (the unique ID of the tag)
  //           Uint8List idBytes = Uint8List.fromList(data.id.cast<int>());

  //           final reversedBytes = idBytes.reversed.toList();

  //           // Convert to HEX and DEC
  //           final hex =
  //               reversedBytes
  //                   .map((b) => b.toRadixString(16).padLeft(2, '0'))
  //                   .join('')
  //                   .toUpperCase();
  //           final decimal = int.tryParse(hex, radix: 16);

  //           print('✅ Card UID (bytes): $idBytes');
  //           print(
  //             '✅ Card UID (HEX NFC order): ${idBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join('').toUpperCase()}',
  //           );
  //           print('✅ Card UID (HEX Reversed): $hex');
  //           print('✅ Card UID (DEC Reversed): $decimal');
  //           //Get.toNamed(AppRoutes.successModalScreen, arguments: decimal);
  //           //Get.toNamed(AppRoutes.scannedCardScreen, arguments: decimal);
  //           //dropOffId.value = decimal.toString();
  //           //await NfcManager.instance.stopSession();
  //           Get.dialog(
  //             AlertDialog(
  //               backgroundColor: Colors.transparent,
  //               insetPadding: EdgeInsets.zero,
  //               content: DropOffScanSuccessModalDialog(
  //                 Get.put(DropOffScanSuccessModalController()),
  //                 decimal.toString(),
  //                 () => dropOff(decimal.toString()),
  //               ),
  //             ),
  //           );
  //           final nfcA = data.nfcA;
  //           if (nfcA != null) {
  //             print('📘 NFC-A tag detected: ${nfcA.toString()}');
  //           }
  //         } catch (e) {
  //           print('❌ Error reading tag: $e');
  //         } finally {
  //           isDropOffScanning.value = false;
  //           await NfcManager.instance.stopSession();
  //           // Future.delayed(
  //           //   const Duration(seconds: 1),
  //           //   scanCard,
  //           // ); // re-scan automatically
  //         }
  //       },
  //     );
  //   }
  // }

  void scanCarddropoff() async {
    if (isDropOffScanning.value) {
      print("⚠️ Scan already in progress, skipping new session.");
      return;
    }

    isDropOffScanning.value = true;
    print('📡 Starting NFC scan...');
    isDropOffScanning.value = true;

    bool available = await NfcManager.instance.isAvailable();
    if (!available) {
      print("❌ NFC not available on this device or temporarily disabled.");
      isDropOffScanning.value = false;
      isDropOffScanning.value = false;
      return;
    }

    try {
      // Ensure previous session is closed
      await NfcManager.instance.stopSession();

      // Start fresh
      await NfcManager.instance.startSession(
        pollingOptions: {NfcPollingOption.iso14443},
        onDiscovered: (NfcTag tag) async {
          try {
            final TagPigeon data = tag.data as TagPigeon;
            Uint8List idBytes = Uint8List.fromList(data.id.cast<int>());
            final reversedBytes = idBytes.reversed.toList();

            final hex =
                reversedBytes
                    .map((b) => b.toRadixString(16).padLeft(2, '0'))
                    .join('')
                    .toUpperCase();
            final decimal = int.tryParse(hex, radix: 16);

            print('✅ Card UID (bytes): $idBytes');
            print('✅ Card UID (HEX Reversed): $hex');
            print('✅ Card UID (DEC Reversed): $decimal');

            await NfcManager.instance
                .stopSession(); // stop cleanly before showing dialog

            // Show dialog after stopping NFC
            Get.dialog(
              AlertDialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.zero,
                content: DropOffScanSuccessModalDialog(
                  Get.put(DropOffScanSuccessModalController()),
                  decimal.toString(),
                  () => dropOff(decimal.toString()),
                ),
              ),
            );
          } catch (e) {
            print('❌ Error processing NFC tag: $e');
            await NfcManager.instance.stopSession(
              errorMessageIos: 'Error reading tag',
            );
          } finally {
            isDropOffScanning.value = false;
            isDropOffScanning.value = false;
          }
        },
      );
    } catch (e) {
      print('❌ Error starting NFC session: $e');
      isDropOffScanning.value = false;
      isDropOffScanning.value = false;
    }
  }

  void syncQueuedRequests() async {
    final networkInfo = NetworkInfo();
    if (await networkInfo.isConnected()) {
      final requests = await OfflineQueueDB().getAllRequests();
      for (final req in requests) {
        try {
          await _apiService.attendance(req);
        } catch (_) {}
      }
      await OfflineQueueDB().clearQueue();
    }
  }

  Future<void> checkIn(String cardId) async {
    Navigator.pop(Get.context!);
    OverlayLoadingProgress.start(
      context: Get.context!,
      circularProgressColor: Color(0XFFFF8C42),
    );
    var schoolCode = await dataBase.getBrmCode();
    final body = {
      "schoolCode": schoolCode,
      "cardUID": cardId,
      "eventType": 3,
      "eventDateTime": DateTime.now().toIso8601String(),
      "notes": "",
    };

    try {
      final networkInfo = NetworkInfo();
      if (await networkInfo.isConnected()) {
        try {
          final response = await _apiService.attendance(body);
          if (response.statusCode == 200 || response.statusCode == 201) {
            myLog.log(response.body);
            Get.snackbar(
              'success',
              'Check-In successful',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          } else if (response.statusCode == 404) {
            OverlayLoadingProgress.stop();
            var responseBody = jsonDecode(response.body);

            Get.snackbar(
              responseBody['message'],
              'Register this card before use',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.deepOrange,
              colorText: Colors.white,
            );
            Navigator.pop(Get.context!);
          }
        } on SocketException {
          Get.snackbar(
            'Opps!!!',
            'Check your internet connection and try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Color(0XFFFF8C42),
            colorText: Colors.white,
          );
        } catch (e) {
          Get.snackbar(
            'Error',
            e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } finally {
          OverlayLoadingProgress.stop();
        }
      } else {
        await OfflineQueueDB().addRequest(body);
        Get.snackbar(
          'Offline',
          'Request saved. Will sync when online.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: const Color.fromARGB(255, 167, 46, 46),
        );
        OverlayLoadingProgress.stop();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      OverlayLoadingProgress.stop();
    }
  }

  Future<void> checkOut(String cardId) async {
    Navigator.pop(Get.context!);
    OverlayLoadingProgress.start(
      context: Get.context!,
      circularProgressColor: Color(0XFFFF8C42),
    );
    var schoolCode = await dataBase.getBrmCode();
    final body = {
      "schoolCode": schoolCode,
      "cardUID": cardId,
      "eventType": 4,
      "eventDateTime": DateTime.now().toIso8601String(),
      "notes": "",
    };
    try {
      final networkInfo = NetworkInfo();
      if (await networkInfo.isConnected()) {
        try {
          final response = await _apiService.attendance(body);
          if (response.statusCode == 200 || response.statusCode == 201) {
            myLog.log(response.body);
            Get.snackbar(
              'success',
              'Check-out successful',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          } else if (response.statusCode == 404) {
            OverlayLoadingProgress.stop();
            var responseBody = jsonDecode(response.body);

            Get.snackbar(
              responseBody['message'],
              'Register this card before use',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.deepOrange,
              colorText: Colors.white,
            );
          }
        } on SocketException {
          Get.snackbar(
            'Opps!!!',
            'Check your internet connection and try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Color(0XFFFF8C42),
            colorText: Colors.white,
          );
        } catch (e) {
          Get.snackbar(
            'Error',
            e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } finally {
          OverlayLoadingProgress.stop();
        }
      } else {
        await OfflineQueueDB().addRequest(body);
        Get.snackbar(
          'Offline',
          'Request saved. Will sync when online.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        OverlayLoadingProgress.stop();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      OverlayLoadingProgress.stop();
    }
  }

  Future<void> dropOff(String cardId) async {
    Navigator.pop(Get.context!);
    OverlayLoadingProgress.start(
      context: Get.context!,
      circularProgressColor: Color(0XFFFF8C42),
    );
    var schoolCode = await dataBase.getBrmCode();
    myLog.log("school code here ============ ${schoolCode}");
    final body = {
      "schoolCode": schoolCode,
      "cardUID": cardId,
      "eventType": 1,
      "eventDateTime": DateTime.now().toIso8601String(),
      "notes": "",
    };
    try {
      final networkInfo = NetworkInfo();
      if (await networkInfo.isConnected()) {
        try {
          final response = await _apiService.attendance(body);
          if (response.statusCode == 200 || response.statusCode == 201) {
            myLog.log(response.body);
            Get.snackbar(
              'success',
              'Drop-off successful',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          } else if (response.statusCode == 404) {
            OverlayLoadingProgress.stop();
            var responseBody = jsonDecode(response.body);

            Get.snackbar(
              responseBody['message'],
              'Register this card before use',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.deepOrange,
              colorText: Colors.white,
            );
          }
        } on SocketException {
          Get.snackbar(
            'Opps!!!',
            'Check your internet connection and try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Color(0XFFFF8C42),
            colorText: Colors.white,
          );
        } catch (e) {
          Get.snackbar(
            'Error',
            e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } finally {
          OverlayLoadingProgress.stop();
        }
      } else {
        await OfflineQueueDB().addRequest(body);
        Get.snackbar(
          'Offline',
          'Request saved. Will sync when online.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        OverlayLoadingProgress.stop();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      OverlayLoadingProgress.stop();
    }
  }

  Future<void> pickUp(String cardId) async {
    Navigator.pop(Get.context!);
    OverlayLoadingProgress.start(
      context: Get.context!,
      circularProgressColor: Color(0XFFFF8C42),
    );
    var schoolCode = await dataBase.getBrmCode();
    final body = {
      "schoolCode": schoolCode,
      "cardUID": cardId,
      "eventType": 2,
      "eventDateTime": DateTime.now().toIso8601String(),
      "notes": "",
    };
    try {
      final networkInfo = NetworkInfo();
      if (await networkInfo.isConnected()) {
        try {
          final response = await _apiService.attendance(body);
          if (response.statusCode == 200 || response.statusCode == 201) {
            myLog.log(response.body);
            Get.snackbar(
              'success',
              'Pick-up successful',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          } else if (response.statusCode == 404) {
            OverlayLoadingProgress.stop();
            var responseBody = jsonDecode(response.body);

            Get.snackbar(
              responseBody['message'],
              'Register this card before use',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.deepOrange,
              colorText: Colors.white,
            );
          }
        } on SocketException {
          Get.snackbar(
            'Opps!!!',
            'Check your internet connection and try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Color(0XFFFF8C42),
            colorText: Colors.white,
          );
        } catch (e) {
          Get.snackbar(
            'Error',
            e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } finally {
          OverlayLoadingProgress.stop();
        }
      } else {
        await OfflineQueueDB().addRequest(body);
        Get.snackbar(
          'Offline',
          'Request saved. Will sync when online.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        OverlayLoadingProgress.stop();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      OverlayLoadingProgress.stop();
    }
  }
}
