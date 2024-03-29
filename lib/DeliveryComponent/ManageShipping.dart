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

class ManageShipping extends StatefulWidget {
  const ManageShipping({super.key});

  @override
  State<ManageShipping> createState() => _ManageShippingState();
}

class _ManageShippingState extends State<ManageShipping> {
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
                              'สถานที่จัดส่ง',
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
                      .where('shippingStatus', isNotEqualTo: '')
                      .orderBy('shippingStatus')
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
                                      width: 180,
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
                                        '${order['address']} / ${order['jangwhat']}',
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
                                                  order['shippingStatus']),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              border: Border.all(
                                                color:
                                                    (order['shippingStatus'] ==
                                                            'inshipping')
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
                                                    order['shippingStatus']),
                                                style: TextStyle(
                                                  color: (order['shippingStatus'] ==
                                                              'shipping' ||
                                                          order['shippingStatus'] ==
                                                              'delivered')
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
                                                'shippingStatus'], // ค่าเริ่มต้นของ Dropdown
                                            onChanged:
                                                (String? newValue) async {
                                              // ตรวจสอบเงื่อนไขและอัปเดตค่าใน Firestore ตามสถานะที่เลือก
                                              if (newValue == 'inshipping') {
                                                print(
                                                    'Changing status to: ขนส่งกำลังคัดแยก');
                                                await FirebaseFirestore.instance
                                                    .collection('Orders')
                                                    .doc(order['orderId'])
                                                    .update({
                                                  'shippingStatus':
                                                      'inshipping',
                                                });
                                              } else if (newValue ==
                                                  'Sorting') {
                                                print(
                                                    'Changing status to: เตรียมสินค้าเพื่อมอบให้กับขนส่ง');
                                                await FirebaseFirestore.instance
                                                    .collection('Orders')
                                                    .doc(order['orderId'])
                                                    .update({
                                                  'shippingStatus': 'Sorting',
                                                  'Sorting': true,
                                                  'SortingDate': DateTime.now(),
                                                });
                                              }
                                              else if (newValue ==
                                                  'delivered') {
                                                print(
                                                    'Changing status to: เตรียมสินค้าเพื่อมอบให้กับขนส่ง');
                                                await FirebaseFirestore.instance
                                                    .collection('Orders')
                                                    .doc(order['orderId'])
                                                    .update({
                                                  'deliverStatus': 'delivered',
                                                  'delivered': true,
                                                  'deliveryDate':
                                                      DateTime.now(),
                                                  'shippingStatus': 'delivered',
                                                });
                                              }
                                               else if (newValue ==
                                                  'shipping') {
                                                print(
                                                    'Changing status to: มอบสินค้าให้กับขนส่ง');
                                                await FirebaseFirestore.instance
                                                    .collection('Orders')
                                                    .doc(order['orderId'])
                                                    .update({
                                                  'shippingStatus': 'shipping',
                                                  'shipping': true,
                                                  'shippingDate':
                                                      DateTime.now(),
                                                });
                                              }
                                            },
                                            items: <String>[
                                              'inshipping', // สถานะ 'inshipping'
                                              'Sorting', // สถานะ 'Sorting'
                                              'shipping', // สถานะ 'shipping'
                                              'delivered'
                                            ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                                String statusText = '';
                                                // ใช้เงื่อนไขเพื่อกำหนดชื่อสถานะที่แตกต่างจากค่า value
                                                if (value == 'inshipping') {
                                                  statusText =
                                                      'ขนส่งรับเข้าระบบ';
                                                } else if (value == 'Sorting') {
                                                  statusText =
                                                      'ขนส่งกำลังคัดเเยกสินค้า';
                                                } else if (value ==
                                                    'shipping') {
                                                  statusText = 'ขนส่งกำลังนำพัสดุส่งให้คุณ';
                                                }
                                                else if (value ==
                                                    'delivered') {
                                                  statusText = 'ผู้รับได้รับสินค้าเเล้ว';
                                                }
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                      statusText), // แสดงชื่อสถานะตามที่กำหนด
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
    case 'inshipping':
      return Color(0x4C39D2C0);
    case 'Sorting':
      return Color(0xFF0000FF); // Change to your desired color
    case 'shipping':
      return Color(0xFFFFA500); // Change to your desired color
    case 'delivered':
      return Color(0xFF008000); // Change to your desired color
    default:
      return Colors.transparent;
  }
}

String getStatusText(String status) {
  switch (status) {
    case 'inshipping':
      return 'ขนส่งรับเข้าระบบ';
    case 'Sorting':
      return 'ขนส่งกำลังคัดเเยกสินค้า';
    case 'shipping':
      return 'ขนส่งกำลังนำพัสดุส่งให้คุณ';
    case 'delivered':
      return 'ผู้รับได้รับสินค้าเเล้ว';
    default:
      return '';
  }
}
