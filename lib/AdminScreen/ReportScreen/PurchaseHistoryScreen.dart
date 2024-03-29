import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SalesReportPage extends StatefulWidget {
  @override
  _SalesReportPageState createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {
  DateTime selectedStartDate = DateTime.now().subtract(Duration(days: 7));
  DateTime selectedEndDate = DateTime.now();
  late Stream<QuerySnapshot> salesStream;
  int totalItemsSold = 0;
  double totalRevenue = 0.0;

  @override
  void initState() {
    super.initState();
    updateSalesStream(selectedStartDate, selectedEndDate);
  }

  void updateSalesStream(DateTime startDate, DateTime endDate) {
    salesStream = FirebaseFirestore.instance
        .collection('Orders')
        .where('orderDate', isGreaterThanOrEqualTo: startDate)
        .where('orderDate',
            isLessThanOrEqualTo: endDate.add(Duration(days: 1)))
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายงานข้อมูลการขาย'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDatePicker(),
            SizedBox(height: 20),
            _buildSummary(),
            SizedBox(height: 20),
            _buildSalesData(),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return ElevatedButton(
      onPressed: () async {
        DateTimeRange? pickedDateRange = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
          initialDateRange: DateTimeRange(
            start: selectedStartDate,
            end: selectedEndDate,
          ),
        );
        if (pickedDateRange != null) {
          setState(() {
            selectedStartDate = pickedDateRange.start;
            selectedEndDate = pickedDateRange.end;
          });
          updateSalesStream(selectedStartDate, selectedEndDate);
        }
      },
      child: Text(
        'เลือกช่วงเวลาที่เเสดงข้อมูล: ${DateFormat('yyyy-MM-dd').format(selectedStartDate)} ถึง ${DateFormat('yyyy-MM-dd').format(selectedEndDate)}',
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  Widget _buildSummary() {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'สรุปรายงานการขายทั้งหมด',
              style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'ยอดรวมคำสั่งซื้อทั้งหมด: $totalItemsSold ชิ้น',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'ยอดรวมรายได้ทั้งหมด: ${totalRevenue.toStringAsFixed(0)} บาท',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesData() {
    return StreamBuilder(
      stream: salesStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No sales data found for the selected date range');
        }

        List<DocumentSnapshot> salesData = snapshot.data!.docs;

        totalItemsSold = 0;
        totalRevenue = 0.0;

        List<DataRow> rows = [];
        
        // New lines to calculate totalItemsSold and totalRevenue
        for (var document in salesData) {
          var data = document.data() as Map<String, dynamic>;
          var orders = data['orders'] as List<dynamic>;

          for (var order in orders) {
            var productData = order as Map<String, dynamic>;
            int quantity = productData['orderQuantity'] ?? 0;
            double price = productData['orderPrice'] ?? 0.0;
            totalItemsSold += quantity;
            totalRevenue += quantity * price;
          }
        }

        for (var document in salesData) {
          var data = document.data() as Map<String, dynamic>;
          var orders = data['orders'] as List<dynamic>;

          for (var order in orders) {
            var productData = order as Map<String, dynamic>;
            String productId =
                (productData['productId'] ?? 'N/A').toString().substring(0, 12);
            String productName = productData['orderName'] ?? 'N/A';
            int quantity = productData['orderQuantity'] ?? 0;
            double price = productData['orderPrice'] ?? 0.0;

            // Calculate total price
            double totalPrice = quantity * price;

            // Add data row to the list
            rows.add(
              DataRow(
                cells: [
                  DataCell(Text(productId, style: TextStyle(fontSize: 18))),
                  DataCell(Text(productName, style: TextStyle(fontSize: 18))),
                  DataCell(Text('${quantity.toString()} ชิ้น',
                      style: TextStyle(fontSize: 18))),
                  DataCell(Text('${price.toStringAsFixed(0)} บาท',
                      style: TextStyle(fontSize: 18))), // Display price per item
                  DataCell(Text('${totalPrice.toStringAsFixed(0)} บาท',
                      style: TextStyle(fontSize: 18))), // Display total price
                ],
              ),
            );
          }
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'รายงานข้อมูลการขาย',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DataTable(
              columns: [
                DataColumn(
                    label: Text(
                  'รหัสสินค้า',
                  style: TextStyle(fontSize: 18),
                )),
                DataColumn(
                    label: Text(
                  'ชื่อสินค้า',
                  style: TextStyle(fontSize: 18),
                )),
                DataColumn(
                    label: Text(
                  'จำนวนที่ขาย',
                  style: TextStyle(fontSize: 18),
                )),
                DataColumn(
                    label: Text(
                  'ราคาต่อชิ้น',
                  style: TextStyle(fontSize: 18),
                )),
                DataColumn(
                    label: Text(
                  'ยอดรวมการขาย',
                  style: TextStyle(fontSize: 18),
                )),
              ],
              rows: rows,
            ),
          ],
        );
      },
    );
  }
}
