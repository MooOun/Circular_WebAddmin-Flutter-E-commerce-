import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SalesReportScreen extends StatefulWidget {
  @override
  _SalesReportScreenState createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายงานประวัติการซื้อของลูกค้า'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.purple.shade500,
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No sales data available.',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.purple.shade500,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.7,
                ),
              ),
            );
          }

          return FutureBuilder<Map<String, String>>(
            future: _getStoreInformation(),
            builder: (context, storeInfoSnapshot) {
              if (storeInfoSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple.shade500,
                  ),
                );
              } else if (storeInfoSnapshot.hasError) {
                return Center(
                  child: Text(
                      'Error fetching store information: ${storeInfoSnapshot.error}'),
                );
              } else if (storeInfoSnapshot.data == null ||
                  storeInfoSnapshot.data!.isEmpty) {
                return Center(
                  child: Text('Store information not found'),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Date range selection
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => _selectDate(context, true),
                            child: Text(
                              'เลือกวันที่เริ่ม',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () => _selectDate(context, false),
                            child: Text(
                              'เลือกวันที่สินสุด',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Selected date range display
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _startDate != null
                                ? 'วันที่เริ่ม : ${DateFormat('dd/MM/yyyy').format(_startDate!)}'
                                : 'ยังไม่ได้เลือกวันเริ่มต้น',
                          ),
                          SizedBox(width: 16),
                          Text(
                            _endDate != null
                                ? 'วันที่สิ้นสุด : ${DateFormat('dd/MM/yyyy').format(_endDate!)}'
                                : 'ยังไม่ได้เลือกวันสิินสุด',
                          ),
                        ],
                      ),
                    ),
                    // Store information
                    Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.grey.shade200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ชื่อร้านค้า : ${storeInfoSnapshot.data!['name']}',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'ที่อยู่ : ${storeInfoSnapshot.data!['address']}',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'เบอร์ติดต่อ : ${storeInfoSnapshot.data!['phone']}',
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            'อีเมล : ${storeInfoSnapshot.data!['email']}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    // Sales report table
                    FutureBuilder<List<DataRow>>(
                      future: _buildDataRows(
                        snapshot.data!.docs,
                        _startDate,
                        _endDate,
                      ),
                      builder: (context, dataRowSnapshot) {
                        if (dataRowSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.purple.shade500,
                            ),
                          );
                        } else if (dataRowSnapshot.hasError) {
                          return Center(
                            child: Text('Error building data rows'),
                          );
                        } else {
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              columns: [
                                DataColumn(label: Text('อันดับ',style: TextStyle(fontSize: 18),)),
                                DataColumn(label: Text('ชื่อลูกค้า',style: TextStyle(fontSize: 18))),
                                DataColumn(
                                    label: Text('จำนวนสินค้าที่ซื้อ (ชิ้น)',style: TextStyle(fontSize: 18))),
                                DataColumn(label: Text('ยอดรวมการซื้อทั้งหมด',style: TextStyle(fontSize: 18))),
                              ],
                              rows: dataRowSnapshot.data!,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }

  Future<Map<String, String>> _getStoreInformation() async {
    try {
      var sellersSnapshot = await FirebaseFirestore.instance
          .collection('Sellers')
          .where('storeName', isEqualTo: 'CircularMall')
          .get();

      if (sellersSnapshot.docs.isNotEmpty) {
        var sellerData =
            sellersSnapshot.docs.first.data() as Map<String, dynamic>;
        return {
          'name': sellerData['storeName'] ?? '',
          'address': sellerData['address'] ?? '',
          'phone': sellerData['phone'] ?? '',
          'email': sellerData['email'] ?? '',
        };
      }
    } catch (error) {
      print('Error fetching seller information: $error');
    }

    return {
      'name': 'CircularMall',
      'address': 'UDRU อำเภอเมืองอุดรธานี อุดรธานี 41000',
      'phone': '063-5415971',
      'email': 'Circularmall@gmail.com',
    };
  }

  Future<List<DataRow>> _buildDataRows(
  List<QueryDocumentSnapshot<Object?>> docs,
  DateTime? startDate,
  DateTime? endDate) async {
  Map<String, Map<String, dynamic>> customerDataMap = {};

  for (var doc in docs) {
    var orderData = doc.data() as Map<String, dynamic>;

    // Convert timestamp to DateTime
    DateTime orderDate = (orderData['orderDate'] as Timestamp).toDate();

    // Check if the orderDate is within the selected date range
    if ((startDate == null ||
        orderDate.isAfter(startDate) ||
        orderDate.isAtSameMomentAs(startDate)) &&
        (endDate == null ||
            orderDate.isBefore(endDate) ||
            orderDate.isAtSameMomentAs(endDate))) {
      // Fetch customer details based on customerId
      var customerData = await _fetchCustomerDetails(orderData['uid']);
      print('Order Data: $orderData');
      print('Customer Data: $customerData');

      // Replace "customerName" with the actual field name in your Firestore database
      String customerName = customerData?['customerName'] ?? 'N/A';

      // Initialize the map if not exists
      customerDataMap.putIfAbsent(
          customerName,
          () => {
            'totalProductsPurchased': 0,
            'totalPurchaseAmount': 0.0,
          });
      customerDataMap[customerName]!['totalProductsPurchased'] +=
          orderData['orders'][0]['orderQuantity'];
      customerDataMap[customerName]!['totalPurchaseAmount'] +=
          orderData['totalOrderPrice'];
    }
  }

  var sortedCustomerData = customerDataMap.entries.toList()
    ..sort((a, b) => b.value['totalProductsPurchased']
        .compareTo(a.value['totalProductsPurchased']));

  List<DataRow> dataRows = sortedCustomerData.asMap().entries.map((entry) {
    int rank = entry.key + 1;
    String customerName = entry.value.key;
    int totalProductsPurchased = entry.value.value['totalProductsPurchased'];
    double totalPurchaseAmount = entry.value.value['totalPurchaseAmount'];

    return DataRow(cells: [
      DataCell(
        Text(
          rank.toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      DataCell(Text(
        customerName,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      )),
      DataCell(Text(
        totalProductsPurchased.toString(),
        style: TextStyle(
          fontSize: 18,
          // Add additional styling as needed
        ),
      )),
      DataCell(Text(
        totalPurchaseAmount.toStringAsFixed(2) + ' บาท',
        style: TextStyle(
          fontSize: 18,
          color: Colors.green, // Change text color to green
          // Add additional styling as needed
        ),
      )),
    ]);
  }).toList();

  return dataRows;
}


  Future<Map<String, dynamic>> _fetchCustomerDetails(String customerId) async {
  try {
    var customerSnapshot = await FirebaseFirestore.instance
        .collection('Customers')
        .where('uid', isEqualTo: customerId)
        .get();

    if (customerSnapshot.docs.isNotEmpty) {
      var customerData = customerSnapshot.docs.first.data() as Map<String, dynamic>;
      return customerData;
    } else {
      print('Customer not found for UID: $customerId');
      // Return default values
      return {
        'customerName': 'N/A',
        // Add other default values as needed
      };
    }
  } catch (error) {
    print('Error fetching customer information: $error');
    // Handle the error as needed
    return {
      'customerName': 'N/A',
      // Add other default values as needed
    };
  }
}


  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = selectedDate;
        } else {
          // Check if end date is before the start date
          if (_startDate == null || selectedDate.isAfter(_startDate!)) {
            _endDate = selectedDate;
          } else {
            // Show an error or handle the invalid selection
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Invalid Selection"),
                  content: Text("End date must be after the start date."),
                  actions: <Widget>[
                    TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      });
    }
  }
}
