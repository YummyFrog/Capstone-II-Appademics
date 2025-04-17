import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});

  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrText;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void _markAttendance(String code) {
    setState(() {
      qrText = code;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Attendance marked for: $code')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 4.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Center(
                    child: Text(
                      'Camera window',
                      textAlign: TextAlign.center,
                    ),
                  ),
                      //child: QRView(
                          //key: qrKey,
                          //onQRViewCreated: _onQRViewCreated,
                        //),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (qrText != null)
              Text(
                '$qrText',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _markAttendance('Student_ID');
              },
              child: const Text('Simulate QR Scan (Mark Attendance)'),
            ),         
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      _markAttendance(scanData.code ?? 'Unknown Code');
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}