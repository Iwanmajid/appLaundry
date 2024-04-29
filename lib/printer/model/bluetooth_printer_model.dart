import 'package:thermal_printer/thermal_printer.dart';

class BluetoothPrinterModel {
  int? id;
  String? deviceName;
  String? address;
  String? port;
  String? vendorId;
  String? productId;
  bool? isBle;

  PrinterType typePrinter;
  bool? state;

  BluetoothPrinterModel(
      {this.deviceName,
      this.address,
      this.port,
      this.state,
      this.vendorId,
      this.productId,
      this.typePrinter = PrinterType.bluetooth,
      this.isBle = false});

  @override
  String toString() =>
      'BluetoothPrinterModel{deviceName: $deviceName, address: $address, port: $port, vendorId: $vendorId, productId: $productId, typePrinter: $typePrinter, state: $state}';
}
