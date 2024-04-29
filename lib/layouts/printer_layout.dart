import 'package:flutter/material.dart';
import 'package:projek_cuciklik/printer/print.dart';
import 'package:thermal_printer/thermal_printer.dart';

class HalPrinter extends StatefulWidget {
  const HalPrinter({super.key});

  @override
  State<HalPrinter> createState() => _HalPrinterState();
}

class _HalPrinterState extends State<HalPrinter> {
  var printerManager = PrinterManager.instance;
  PrinterDevice? selectedPrinter;
  final prText = TextEditingController();

  var devices = [];
  _scan(PrinterType type, {bool isBle = false}) {
    var tmp = [];
    // Find printers
    PrinterManager.instance.discovery(type: type, isBle: isBle).listen((device) {
      tmp.add(device);
    });

    setState(() {
      devices = tmp;
    });
  }

  _connectDevice(PrinterDevice selectedPrinter, PrinterType type,
      {bool reconnect = false, bool isBle = false, String? ipAddress = null}) async {
    Print.cPrinter.setBluetooth(selectedPrinter.name, selectedPrinter.address ?? "");
    switch (type) {
      // only windows and android
      case PrinterType.usb:
        await PrinterManager.instance.connect(
            type: type,
            model: UsbPrinterInput(
                name: selectedPrinter.name,
                productId: selectedPrinter.productId,
                vendorId: selectedPrinter.vendorId));
        break;
      // only iOS and android
      case PrinterType.bluetooth:
        await PrinterManager.instance.connect(
            type: type,
            model: BluetoothPrinterInput(
                name: selectedPrinter.name,
                address: selectedPrinter.address!,
                isBle: isBle,
                autoConnect: reconnect));
        break;
      case PrinterType.network:
        await PrinterManager.instance.connect(
            type: type, model: TcpPrinterInput(ipAddress: ipAddress ?? selectedPrinter.address!));
        break;
      default:
        break;
    }
  }

  _disconnectDevice(PrinterType type) async {
    await PrinterManager.instance.disconnect(type: type);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
      decoration: BoxDecoration(color: Colors.white70),
      child: ListView(children: [
        Center(
            child: const Text(
          "KONEKSI PRINTER",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        )),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
            onPressed: () {
              _scan(PrinterType.bluetooth);
            },
            child: const Text("SCAN PRINTER",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))),
        SizedBox(
          height: 7,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
            onPressed: () {
              _connectDevice(selectedPrinter!, PrinterType.bluetooth);
            },
            child: const Text("CONNECT PRINTER",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))),
        SizedBox(
          height: 7,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
            onPressed: () {
              _disconnectDevice(PrinterType.bluetooth);
            },
            child: const Text("DISCONNECT PRINTER",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))),
        devices.isEmpty
            ? Center(
                child: const Text("\nTIDAK ADA PRINTER",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPrinter = devices[index];
                          });
                        },
                        child: ListTile(
                            title: Text(
                              devices[index].name,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(devices[index].address ?? "",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            leading: selectedPrinter != null
                                ? selectedPrinter!.name == devices[index].name
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )
                                    : null
                                : null),
                      );
                    }),
              )
      ]),
    );
  }
}
