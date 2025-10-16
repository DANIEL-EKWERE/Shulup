import 'dart:async';
import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:nfc_manager/nfc_manager_android.dart';
// import 'package:nfc_manager_ndef/nfc_manager_ndef.dart';
import 'package:flutter/material.dart';
import 'package:schulup/presentation/drop_off_scan_screen/models/card_model.dart';

import '../../../core/app_export.dart';
import '../models/register_card_model.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:developer' as myLog;
// import 'package:nfc_manager/nfc_manager.dart';
// import 'package:nfc_manager/src/nfc_manager_android/pigeon.dart';

import 'package:nfc_manager/src/nfc_manager_android/pigeon.g.dart';

//import 'package:nfc_manager_ndef/';

/// A controller class for the RegisterCardScreen.
///
/// This class manages the state of the RegisterCardScreen, including the
/// current registerCardModelObj
class RegisterCardController extends GetxController {
  Rx<RegisterCardModel> registerCardModelObj = RegisterCardModel().obs;
  RxBool isScanning = false.obs;
  RxBool availablex = false.obs;
  final FocusNode focusNode = FocusNode();
  final TextEditingController textController5 = TextEditingController();

  RxString _status = "Ready".obs;
  RxString _cardBuffer = "".obs;
  RxList<CardScan> _scannedCards = RxList<CardScan>();
  Timer? _bufferTimer;

  @override
  void onInit() async {
    super.onInit();
    bool availability = await NfcManager.instance.isAvailable();
    availablex.value = availability;
    update();
    if (!availability) {
      print("NFC may not be supported or may be temporarily disabled");
    } else {
      print("NFC is supported");
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });

    textController5.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    //isDropOffScanning.value = true;

    String text = textController5.text;

    if (text.isEmpty) return;

    // Cancel previous timer
    _bufferTimer?.cancel();

    // Check if text contains newline (Enter key pressed)
    if (text.contains('\n')) {
      String cardId = text.replaceAll('\n', '').trim();
      if (cardId.isNotEmpty) {
        _processCardId1(cardId);
      }
      textController5.clear();
      _cardBuffer.value = "";
    } else {
      // Set timer to process if no more input comes
      _cardBuffer.value = text;
      _bufferTimer = Timer(Duration(milliseconds: 500), () {
        if (_cardBuffer.isNotEmpty) {
          _processCardId1(_cardBuffer.trim());
          textController5.clear();
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
    isScanning.value = false;
    Get.toNamed(AppRoutes.scannedCardScreen, arguments: cardId);

    // Reset status after 2 seconds
    Timer(Duration(seconds: 2), () {});
  }

  @override
  void onClose() {
    super.onClose();
    isScanning.value = false;
    //stopScan();
  }

  void stopScan() async {
    await NfcManager.instance.stopSession();
    isScanning.value = false;
  }

  // void scanCard() {
  //   print('📡 Starting NFC scan...');
  //   isScanning.value = true;
  //   NfcManager.instance.startSession(
  //     pollingOptions: {NfcPollingOption.iso14443},
  //     onDiscovered: (NfcTag tag) async {
  //       try {
  //         final TagPigeon data = tag.data as TagPigeon;

  //         // The card UID bytes (the unique ID of the tag)
  //         Uint8List idBytes = Uint8List.fromList(data.id.cast<int>());

  //         final reversedBytes = idBytes.reversed.toList();

  //         // Convert to HEX and DEC
  //         final hex =
  //             reversedBytes
  //                 .map((b) => b.toRadixString(16).padLeft(2, '0'))
  //                 .join('')
  //                 .toUpperCase();
  //         final decimal = int.tryParse(hex, radix: 16);

  //         print('✅ Card UID (bytes): $idBytes');
  //         print(
  //           '✅ Card UID (HEX NFC order): ${idBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join('').toUpperCase()}',
  //         );
  //         print('✅ Card UID (HEX Reversed): $hex');
  //         print('✅ Card UID (DEC Reversed): $decimal');
  //         isScanning.value = false;
  //         update();
  //         //Get.toNamed(AppRoutes.successModalScreen, arguments: decimal);
  //         Get.toNamed(AppRoutes.scannedCardScreen, arguments: decimal);
  //         final nfcA = data.nfcA;
  //         if (nfcA != null) {
  //           print('📘 NFC-A tag detected: ${nfcA.toString()}');
  //         }
  //       } catch (e) {
  //         isScanning.value = false;
  //         print('❌ Error reading tag: $e');
  //       } finally {
  //         isScanning.value = false;
  //         update();
  //         await NfcManager.instance.stopSession();
  //         Future.delayed(
  //           const Duration(seconds: 1),
  //           scanCard,
  //         ); // re-scan automatically
  //       }
  //     },
  //   );
  // }



  void scanCard() async {
  
  if (isScanning.value) {
    print("⚠️ Scan already in progress, skipping new session.");
    return;
  }

  isScanning.value = true;
  print('📡 Starting NFC scan...');
  isScanning.value = true;

  bool available = await NfcManager.instance.isAvailable();
  if (!available) {
    print("❌ NFC not available on this device or temporarily disabled.");
    // isDropOffScanning.value = false;
    isScanning.value = false;
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

          final hex = reversedBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join('').toUpperCase();
          final decimal = int.tryParse(hex, radix: 16);

          print('✅ Card UID (bytes): $idBytes');
          print('✅ Card UID (HEX Reversed): $hex');
          print('✅ Card UID (DEC Reversed): $decimal');

          await NfcManager.instance.stopSession(); // stop cleanly before showing dialog

          // Show dialog after stopping NFC
         Get.toNamed(AppRoutes.scannedCardScreen, arguments: decimal);
        } catch (e) {
          print('❌ Error processing NFC tag: $e');
          await NfcManager.instance.stopSession(errorMessageIos: 'Error reading tag');
        } finally {
          //isDropOffScanning.value = false;
          isScanning.value = false;
        }
      },
    );
  } catch (e) {
    print('❌ Error starting NFC session: $e');
    isScanning.value = false;
    //isDropOffScanning.value = false;
  }

}
}
