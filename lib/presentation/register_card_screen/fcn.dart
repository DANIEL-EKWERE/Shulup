// import 'package:flutter/material.dart';
// import 'package:nfc_manager/nfc_manager.dart';

// class NFCCardReader extends StatefulWidget {
//   @override
//   _NFCCardReaderState createState() => _NFCCardReaderState();
// }

// class _NFCCardReaderState extends State<NFCCardReader> {
//   String _cardId = '';
//   bool _isReading = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkNFCAvailability();
//   }

//   Future<void> _checkNFCAvailability() async {
//     bool isAvailable = await NfcManager.instance.isAvailable();
//     if (!isAvailable) {
//       setState(() {
//         _cardId = 'NFC not available on this device';
//       });
//     }
//   }

//   void _startNFCReading() {
//     setState(() {
//       _isReading = true;
//       _cardId = 'Hold card near device...';
//     });

//     NfcManager.instance.startSession(
//       onDiscovered: (NfcTag tag) async {
//         // Extract the card ID from the tag
//         String cardId = _extractCardId(tag);
        
//         setState(() {
//           _cardId = cardId;
//           _isReading = false;
//         });

//         // Stop the session after reading
//         NfcManager.instance.stopSession();
//       },
//       onError: (error) async {
//         setState(() {
//           _cardId = 'Error: ${error.message}';
//           _isReading = false;
//         });
//         return error;
//       },
//     );
//   }

//   String _extractCardId(NfcTag tag) {
//     // Try to get the ID from different tag types
    
//     // For NfcA (ISO 14443-3A) - most common for plastic cards
//     if (tag.data.containsKey('nfca')) {
//       final nfcA = NfcA.from(tag);
//       if (nfcA != null) {
//         return _bytesToDecimal(nfcA.identifier);
//       }
//     }

//     // For NfcB (ISO 14443-3B)
//     if (tag.data.containsKey('nfcb')) {
//       final nfcB = NfcB.from(tag);
//       if (nfcB != null) {
//         return _bytesToDecimal(nfcB.identifier);
//       }
//     }

//     // For NfcF (FeliCa)
//     if (tag.data.containsKey('nfcf')) {
//       final nfcF = NfcF.from(tag);
//       if (nfcF != null) {
//         return _bytesToDecimal(nfcF.identifier);
//       }
//     }

//     // For NfcV (ISO 15693)
//     if (tag.data.containsKey('nfcv')) {
//       final nfcV = NfcV.from(tag);
//       if (nfcV != null) {
//         return _bytesToDecimal(nfcV.identifier);
//       }
//     }

//     // For ISO7816 (smart cards)
//     if (tag.data.containsKey('iso7816')) {
//       final iso7816 = Iso7816.from(tag);
//       if (iso7816 != null) {
//         return _bytesToDecimal(iso7816.identifier);
//       }
//     }

//     // Fallback: try to get identifier from tag.data
//     if (tag.data.containsKey('identifier')) {
//       return _bytesToDecimal(tag.data['identifier'] as List<int>);
//     }

//     return 'Unable to extract card ID';
//   }

//   // Convert byte array to decimal number (like RFID readers do)
//   String _bytesToDecimal(List<int> bytes) {
//     // Method 1: Convert to decimal (most common for card IDs)
//     String decimal = '';
//     for (int byte in bytes) {
//       decimal += byte.toString().padLeft(3, '0');
//     }
    
//     // Remove leading zeros and return
//     return decimal.replaceFirst(RegExp(r'^0+'), '');
    
//     // Alternative Method 2: Convert to integer (if you want single number)
//     // BigInt value = BigInt.zero;
//     // for (int byte in bytes) {
//     //   value = (value << 8) | BigInt.from(byte);
//     // }
//     // return value.toString();
    
//     // Alternative Method 3: Hex representation (uncommon but possible)
//     // return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
//   }

//   void _stopNFCReading() {
//     NfcManager.instance.stopSession();
//     setState(() {
//       _isReading = false;
//     });
//   }

//   @override
//   void dispose() {
//     NfcManager.instance.stopSession();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('NFC Card Reader'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.nfc,
//               size: 100,
//               color: _isReading ? Colors.blue : Colors.grey,
//             ),
//             SizedBox(height: 30),
//             Text(
//               'Card ID:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Container(
//               padding: EdgeInsets.all(16),
//               margin: EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 _cardId.isEmpty ? 'No card read yet' : _cardId,
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(height: 40),
//             ElevatedButton.icon(
//               onPressed: _isReading ? _stopNFCReading : _startNFCReading,
//               icon: Icon(_isReading ? Icons.stop : Icons.nfc),
//               label: Text(_isReading ? 'Stop Reading' : 'Start Reading'),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }