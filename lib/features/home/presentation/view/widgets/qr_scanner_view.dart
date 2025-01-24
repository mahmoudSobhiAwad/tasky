import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:tasky/core/utils/extensions/navigation_handler.dart';
import 'package:tasky/core/utils/theme/app_colors.dart';
import 'package:tasky/core/widgets/custom_snack_bar.dart';
import 'package:tasky/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:tasky/features/task_details/presentation/views/details_view.dart';

class QrScannerView extends StatefulWidget {
  const QrScannerView({
    super.key,
    required this.homeCubit,
  });
  final HomeCubit homeCubit;
  @override
  State<StatefulWidget> createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        bloc: widget.homeCubit,
        listener: (context, state) {
          if (state is GetOneTaskSuccessState) {
            context
                .pushReplacement(TaskDetailsView(taskModel: state.taskModel));
          } else if (state is GetOneTaskFailureState) {
            showCustomSnackBar(context, "${state.errMessage}",
                backgroundColor: AppColor.red100);
          }
        },
        buildWhen: (curr, prev) {
          return curr is ScanQrCodeState;
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(flex: 4, child: _buildQrView(context)),
              Container(
                  padding: EdgeInsets.all(10),
                  margin: const EdgeInsets.all(12),
                  child: state is GetOneTaskLoadingState
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            context.pop(result?.code);
                          },
                          child: const Text('Scanning ....',
                              style: TextStyle(fontSize: 20)),
                        )),
            ],
          );
        },
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(
    QRViewController controller,
  ) async {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      log(scanData.code ?? "no code");
      result = scanData;
      await controller.pauseCamera();
      widget.homeCubit.refreshScanQr(scanData.code ?? "");
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
