// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webadmincircular/AdminComponent/ShowOrderDetailComponent.dart';
import 'package:webadmincircular/AdminComponent/UpdateStatusDelivery.dart';

class ManageOrderWidget extends StatefulWidget {
  const ManageOrderWidget({super.key});

  @override
  State<ManageOrderWidget> createState() => _ManageOrderWidgetState();
}

class _ManageOrderWidgetState extends State<ManageOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: 1170,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Color(0x33000000),
                offset: Offset(0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color(0xFFE0E3E7),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                            child: Text(
                              'จัดการคำสั่งซื้อ',
                              style: TextStyle(
                                color: Color(0xFF14181B),
                                fontSize: 28,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 4, 12, 0),
                            child: Text(
                              'สามารถจัดการคำสั่งซื้อได้จากตารางด้านล่าง',
                              style: TextStyle(
                                color: Color(0xFF57636C),
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'ยังไมไ่ด้ยืนยันคำสั่งซื้อ',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: Color(0xFF4B39EF),
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'ยืนยันคำสั่งซื้อเเล้ว',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: Color(0xFF4B39EF),
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'เตรียมคำสั่งซื้อ',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: Color(0xFF4B39EF),
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'มอบให้ขนส่งเเล้ว',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: Color(0xFF4B39EF),
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F4F8),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 200,
                            child: Text(
                              'รหัสคำสั่งซื้อ',
                              style: TextStyle(
                                color: Color(0xFF14181B),
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            child: Text(
                              'ชื่อลูกค้า',
                              style: TextStyle(
                                color: Color(0xFF14181B),
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 215,
                            child: Text(
                              'วันที่สั่งซื้อ',
                              style: TextStyle(
                                color: Color(0xFF14181B),
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              'จำนวน',
                              style: TextStyle(
                                color: Color(0xFF14181B),
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 260,
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                'สถานะ',
                                style: TextStyle(
                                  color: Color(0xFF14181B),
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                'จัดการคำสั่งซื้อ',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Color(0xFF14181B),
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Orders')
                      .orderBy('orderDate',
                          descending: true) // Add this line for ordering
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    int totalOrderQuantity = 0;

                    // Iterate through documents in the 'Orders' collection
                    snapshot.data!.docs.forEach((orderDocument) {
                      // Assuming 'orderQuantity' is a field within the 'orders' map
                      dynamic orders = orderDocument['orders'];

                      // Check if 'orders' is a List<Map<String, dynamic>>
                      if (orders is List &&
                          orders.isNotEmpty &&
                          orders[0] is Map<String, dynamic>) {
                        // Sum up 'orderQuantity' for each order in the document
                        orders.forEach((order) {
                          dynamic orderQuantity = order['orderQuantity'];

                          // Check if 'orderQuantity' is of type 'int' or 'String'
                          if (orderQuantity != null) {
                            totalOrderQuantity += (orderQuantity is int)
                                ? orderQuantity
                                : int.tryParse(orderQuantity) ?? 0;
                          }
                        });
                      }
                    });

                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var order = snapshot.data!.docs[index];
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 0,
                                    color: Color(0xFFF1F4F8),
                                    offset: Offset(0, 1),
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 175,
                                      child: Text(
                                        '# ${order['orderId'].toString().split('-').first.padLeft(6, '0')}',
                                        style: TextStyle(
                                          color: Color(0xFF14181B),
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 220,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 8, 12, 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(4, 0, 0, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      order['customerName'],
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF14181B),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 215,
                                      child: Text(
                                        DateFormat('dd/MMM/yyyy-HH:mm:ss')
                                            .format((order['orderDate']
                                                    as Timestamp)
                                                .toDate()),
                                        style: TextStyle(
                                          color: Color(0xFF14181B),
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 110,
                                      child: Text(
                                        '$totalOrderQuantity รายการ',
                                        style: TextStyle(
                                          color: Color(0xFF14181B),
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 190,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            height: 32,
                                            decoration: BoxDecoration(
                                              color: getColorForStatus(
                                                  order['deliverStatus']),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              border: Border.all(
                                                color:
                                                    (order['deliverStatus'] ==
                                                            'notconfirmed')
                                                        ? Color(0xFF39D2C0)
                                                        : Colors.transparent,
                                              ),
                                            ),
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 0, 12, 0),
                                              child: Text(
                                                getStatusText(
                                                    order['deliverStatus']),
                                                style: TextStyle(
                                                  color: (order['deliverStatus'] ==
                                                              'onconfirmed' ||
                                                          order['deliverStatus'] ==
                                                              'transport')
                                                      ? Colors.white
                                                      : Color(0xFF15161E),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 8, 0),
                                            child: FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 44,
                                              icon: Icon(
                                                Icons.remove_red_eye,
                                                color: Color(0xFF57636C),
                                                size: 20,
                                              ),
                                              onPressed: () async {
                                                print('IconButton pressed ...');

                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      content: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.99,
                                                        child:
                                                            ShowOrderDetailComponentWidget(
                                                          orderData:
                                                              order.data()
                                                                  as Map<String,
                                                                      dynamic>,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          DropdownButton<String>(
                                            value: order[
                                                'deliverStatus'], // ค่าเริ่มต้นของ Dropdown
                                            onChanged:
                                                (String? newValue) async {
                                              if (newValue == 'notconfirmed') {
                                                print(
                                                    'Changing status to: ยืนยันคำสั่งซื้อ');
                                                await FirebaseFirestore.instance
                                                    .collection('Orders')
                                                    .doc(order['orderId'])
                                                    .update({
                                                  'deliverStatus':
                                                      'notconfirmed',
                                                  // 'onconfirmed': true,
                                                  // 'confirmDate': DateTime.now(),
                                                });
                                              } else if (newValue ==
                                                  'onconfirmed') {
                                                print(
                                                    'Changing status to: เตรียมสินค้าเพื่อมอบให้กับขนส่ง');
                                                await FirebaseFirestore.instance
                                                    .collection('Orders')
                                                    .doc(order['orderId'])
                                                    .update({
                                                  'deliverStatus':
                                                      'onconfirmed',
                                                  'onconfirmed': true,
                                                  'confirmDate': DateTime.now(),
                                                });
                                              } else if (newValue ==
                                                  'preparetransport') {
                                                print(
                                                    'Changing status to: มอบสินค้าให้กับขนส่ง');
                                                await FirebaseFirestore.instance
                                                    .collection('Orders')
                                                    .doc(order['orderId'])
                                                    .update({
                                                  'deliverStatus':
                                                      'preparetransport',
                                                  'prepareTransport': true,
                                                  'prepareDate': DateTime.now(),
                                                });
                                              } else if (newValue ==
                                                  'cancelOrder') {
                                                print(
                                                    'Changing status to: มอบสินค้าให้กับขนส่ง');
                                                await FirebaseFirestore.instance
                                                    .collection('Orders')
                                                    .doc(order['orderId'])
                                                    .update({
                                                  'deliverStatus':
                                                      'cancelOrder',
                                                });
                                              } else if (newValue ==
                                                  'transport') {
                                                print(
                                                    'Changing status to: มอบสินค้าให้กับขนส่ง');
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    String selectedService = '';
                                                    return StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                        String
                                                            generateRandomTrackingNumber() {
                                                          String letters = String
                                                              .fromCharCodes(
                                                                  List.generate(
                                                                      2,
                                                                      (index) =>
                                                                          Random()
                                                                              .nextInt(26) +
                                                                          65));
                                                          String digits =
                                                              Random()
                                                                  .nextInt(
                                                                      100000)
                                                                  .toString()
                                                                  .padLeft(
                                                                      5, '0');
                                                          String digits2 =
                                                              Random()
                                                                  .nextInt(
                                                                      100000)
                                                                  .toString()
                                                                  .padLeft(
                                                                      5, '0');
                                                          return '$letters $digits $digits2 TH';
                                                        }

                                                        return AlertDialog(
                                                          title: Text(
                                                              'เลือกบริการขนส่ง'),
                                                          content: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                'ขนส่งที่เลือก : $selectedService',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                              DropdownButton<
                                                                  String>(
                                                                value: selectedService
                                                                        .isNotEmpty
                                                                    ? selectedService
                                                                    : null,
                                                                onChanged: (String?
                                                                    newValue) {
                                                                  if (newValue !=
                                                                      null) {
                                                                    setState(
                                                                        () {
                                                                      selectedService =
                                                                          newValue;
                                                                    });
                                                                  }
                                                                },
                                                                items: <String>[
                                                                  'Circular Express',
                                                                ].map<
                                                                    DropdownMenuItem<
                                                                        String>>(
                                                                  (String
                                                                      value) {
                                                                    return DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          value,
                                                                      child: Text(
                                                                          value),
                                                                    );
                                                                  },
                                                                ).toList(),
                                                              ),
                                                              SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                'รหัสติดตามสินค้า: ${generateRandomTrackingNumber()}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ],
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                  'ยกเลิก'),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                final DateTime
                                                                    now =
                                                                    DateTime
                                                                        .now();
                                                                final DateTime
                                                                    deliveryDate =
                                                                    now.add(Duration(
                                                                        days:
                                                                            4));
                                                                final String
                                                                    trackingNumber =
                                                                    generateRandomTrackingNumber();

                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Orders')
                                                                    .doc(order[
                                                                        'orderId'])
                                                                    .update({
                                                                  'deliveryService':
                                                                      selectedService,
                                                                  'deliveryDate':
                                                                      deliveryDate,
                                                                  'trackingNumber':
                                                                      trackingNumber,
                                                                  'shippingStatus':
                                                                      'inshipping',
                                                                  'deliverStatus':
                                                                      'transport',
                                                                  'transport':
                                                                      true,
                                                                  'transportDate':
                                                                      DateTime
                                                                          .now(),
                                                                });

                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child:
                                                                  Text('ตกลง'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            items: <String>[
                                              'notconfirmed',
                                              'onconfirmed',
                                              'preparetransport',
                                              'transport',
                                              'delivered',
                                              'cancelOrder',
                                              
                                            ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                                String statusText = '';
                                                // ใช้เงื่อนไขเพื่อกำหนดชื่อสถานะที่แตกต่างจากค่า value
                                                if (value == 'notconfirmed') {
                                                  statusText =
                                                      'ยังไม่ได้ยืนยัน';
                                                } else if (value ==
                                                    'onconfirmed') {
                                                  statusText = 'ยืนยันแล้ว';
                                                } else if (value ==
                                                    'preparetransport') {
                                                  statusText =
                                                      'เตรียมสินค้าเพื่อขนส่ง';
                                                } else if (value ==
                                                    'transport') {
                                                  statusText = 'กำลังขนส่ง';
                                                }
                                                else if (value ==
                                                    'cancelOrder') {
                                                  statusText = 'ยกเลิกสินค้า';
                                                }
                                                else if (value ==
                                                    'delivered') {
                                                  statusText = 'จัดส่งเเล้ว';
                                                }

                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                      statusText), // แสดงชื่อสถานะที่กำหนดตามเงื่อนไข
                                                );
                                              },
                                            ).toList(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Color getColorForStatus(String status) {
  switch (status) {
    case 'notconfirmed':
      return Color(0x4C39D2C0);
    case 'onconfirmed':
      return Color(0xFF0000FF); // Change to your desired color
    case 'preparetransport':
      return Color.fromARGB(255, 225, 255, 0); // Change to your desired color
    case 'transport':
      return Color(0xFF008000); // Change to your desired color
    case 'inshipping':
      return Color.fromARGB(255, 255, 166, 0);
    case 'delivered':
      return Color.fromARGB(255, 0, 255, 13);
    case 'cancelOrder':
      return Color.fromARGB(255, 255, 0, 0); // Change to your desired color
    default:
      return Colors.transparent;
  }
}

String getStatusText(String status) {
  switch (status) {
    case 'notconfirmed':
      return 'ยังไม่ยืนยัน';
    case 'onconfirmed':
      return 'ยืนยันคำสั่งซื้อแล้ว';
    case 'preparetransport':
      return 'เตรียมสินค้าเพื่อมอบให้ขนส่ง';
    case 'transport':
      return 'มอบสินค้าให้กับขนส่ง';
    case 'inshipping':
      return 'ส่งสินค้าแล้ว';
    case 'delivered':
      return 'ผู้รับได้้รับสินค้าเเล้ว';
    case 'cancelOrder':
      return 'ยกเลิกสินค้า';
    default:
      return '';
  }
}
