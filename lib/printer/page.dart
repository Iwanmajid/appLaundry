import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:thermal_printer/esc_pos_utils_platform/esc_pos_utils_platform.dart';
import 'package:thermal_printer/thermal_printer.dart';

import 'model/bluetooth_printer_model.dart';

part 'controller.dart';

class PrinterPage extends StatefulWidget {
  const PrinterPage({
    super.key,
    required this.item,
  });

  static const String route = '/printer';
  final String item;

  @override
  State<PrinterPage> createState() => _PrinterPageState();
}

class _PrinterPageState extends State<PrinterPage> {
  late final PrinterController c;

  @override
  void initState() {
    c = PrinterController();
    super.initState();
    c.item = widget.item;
    c.printerManager.discovery(type: c.defaultPrinterType, isBle: c.isBle).listen((device) {
      c.devices.add(BluetoothPrinterModel(
        deviceName: device.name,
        address: device.address,
        isBle: c.isBle,
        vendorId: device.vendorId,
        productId: device.productId,
        typePrinter: c.defaultPrinterType,
      ));
      setState(() {});
    });

    // subscription to listen change status of bluetooth connection
    c.bluetoothSubscription = PrinterManager.instance.stateBluetooth.listen((status) {
      log(' ----------------- status bt $status ------------------ ');
      if (status == BTStatus.connected) {
        setState(() {
          c.isConnected = true;
        });
      }
      if (status == BTStatus.none) {
        setState(() {
          c.isConnected = false;
        });
      }
      if (status == BTStatus.connected && c.pendingTask != null) {
        if (Platform.isAndroid) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            PrinterManager.instance.send(type: PrinterType.bluetooth, bytes: c.pendingTask!);
            c.pendingTask = null;
          });
        } else if (Platform.isIOS) {
          PrinterManager.instance.send(type: PrinterType.bluetooth, bytes: c.pendingTask!);
          c.pendingTask = null;
        }
      }
    });
    //  PrinterManager.instance.stateUSB is only supports on Android
    c.usbSubscription = PrinterManager.instance.stateUSB.listen((status) {
      log(' ----------------- status usb $status ------------------ ');

      if (Platform.isAndroid) {
        if (status == USBStatus.connected && c.pendingTask != null) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            PrinterManager.instance.send(type: PrinterType.usb, bytes: c.pendingTask!);
            c.pendingTask = null;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    c.bluetoothSubscription.cancel();
    c.usbSubscription.cancel();
    if (c.isConnected) {
      c.printerManager.disconnect(type: c.defaultPrinterType);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Printer Page'),
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: c.selectedPrinter == null || c.isConnected
                              ? null
                              : () {
                                  c.connectDevice();
                                  setState(() {});
                                },
                          child: const Text("Connect", textAlign: TextAlign.center),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: c.selectedPrinter == null || !c.isConnected
                              ? null
                              : () {
                                  if (c.selectedPrinter != null) {
                                    c.printerManager
                                        .disconnect(type: c.selectedPrinter!.typePrinter);
                                  }
                                  c.isConnected = false;
                                  setState(() {});
                                },
                          child: const Text("Disconnect", textAlign: TextAlign.center),
                        ),
                      ),
                    ],
                  ),
                ),
                DropdownButtonFormField<PrinterType>(
                  value: c.defaultPrinterType,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.print,
                      size: 24,
                    ),
                    labelText: "Type Printer Device",
                    labelStyle: TextStyle(fontSize: 18.0),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  items: <DropdownMenuItem<PrinterType>>[
                    if (Platform.isAndroid || Platform.isIOS)
                      const DropdownMenuItem(
                        value: PrinterType.bluetooth,
                        child: Text("bluetooth"),
                      ),
                    if (Platform.isAndroid || Platform.isWindows)
                      const DropdownMenuItem(
                        value: PrinterType.usb,
                        child: Text("usb"),
                      ),
                    const DropdownMenuItem(
                      value: PrinterType.network,
                      child: Text("Wifi"),
                    ),
                  ],
                  onChanged: (PrinterType? value) {
                    if (value != null) {
                      c.defaultPrinterType = value;
                      c.selectedPrinter = null;
                      c.isBle = false;
                      c.isConnected = false;
                      c.scan();
                      setState(() {});
                    }
                  },
                ),
                Visibility(
                  visible: c.defaultPrinterType == PrinterType.bluetooth && Platform.isAndroid,
                  child: SwitchListTile.adaptive(
                    contentPadding: const EdgeInsets.only(bottom: 20.0, left: 20),
                    title: const Text(
                      "This device supports ble (low energy)",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 19.0),
                    ),
                    value: c.isBle,
                    onChanged: (bool? value) {
                      c.isBle = value ?? false;
                      c.isConnected = false;
                      c.selectedPrinter = null;
                      c.scan();
                      setState(() {});
                    },
                  ),
                ),
                Visibility(
                  visible: c.defaultPrinterType == PrinterType.bluetooth && Platform.isAndroid,
                  child: SwitchListTile.adaptive(
                    contentPadding: const EdgeInsets.only(bottom: 20.0, left: 20),
                    title: const Text(
                      "reconnect",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 19.0),
                    ),
                    value: c.reconnect,
                    onChanged: (bool? value) {
                      c.reconnect = value ?? false;
                      c.scan();
                      setState(() {});
                    },
                  ),
                ),
                Column(
                  children: c.devices
                      .map(
                        (device) => ListTile(
                          title: Text('${device.deviceName}'),
                          subtitle: Platform.isAndroid && c.defaultPrinterType == PrinterType.usb
                              ? null
                              : Visibility(
                                  visible: !Platform.isWindows, child: Text("${device.address}")),
                          onTap: () {
                            // do something
                            c.selectDevice(device);
                            setState(() {});
                          },
                          leading: c.selectedPrinter != null &&
                                  ((device.typePrinter == PrinterType.usb && Platform.isWindows
                                          ? device.deviceName == c.selectedPrinter!.deviceName
                                          : device.vendorId != null &&
                                              c.selectedPrinter!.vendorId == device.vendorId) ||
                                      (device.address != null &&
                                          c.selectedPrinter!.address == device.address))
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : null,
                          trailing: OutlinedButton.icon(
                            onPressed: c.selectedPrinter == null ||
                                    device.deviceName != c.selectedPrinter?.deviceName
                                ? null
                                : () async {
                                    // c.printReceive();
                                  },
                            icon: const Icon(Icons.print),
                            label: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                              child: Text("Print", textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Visibility(
                  visible: c.defaultPrinterType == PrinterType.network && Platform.isWindows,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      controller: c.ipController,
                      keyboardType: const TextInputType.numberWithOptions(signed: true),
                      decoration: const InputDecoration(
                        label: Text("Ip Address"),
                        prefixIcon: Icon(Icons.wifi, size: 24),
                      ),
                      onChanged: (val) {
                        c.setIpAddress(val);
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: c.defaultPrinterType == PrinterType.network && Platform.isWindows,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      controller: c.portController,
                      keyboardType: const TextInputType.numberWithOptions(signed: true),
                      decoration: const InputDecoration(
                        label: Text("Port"),
                        prefixIcon: Icon(Icons.numbers_outlined, size: 24),
                      ),
                      onChanged: c.setPort,
                    ),
                  ),
                ),
                Visibility(
                  visible: c.defaultPrinterType == PrinterType.network && Platform.isWindows,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        if (c.ipController.text.isNotEmpty) {
                          c.setIpAddress(c.ipController.text);
                        }
                        // c.printReceive();
                      },
                      label: const Text("Print", textAlign: TextAlign.center),
                      icon: const Icon(Icons.print),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
