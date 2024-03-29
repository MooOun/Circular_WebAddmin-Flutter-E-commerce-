// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 6,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 120,
                constraints: BoxConstraints(
                  maxWidth: () {
                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                      return 700.0;
                    } else if (MediaQuery.sizeOf(context).width <
                        kBreakpointMedium) {
                      return 900.0;
                    } else if (MediaQuery.sizeOf(context).width <
                        kBreakpointLarge) {
                      return 450.0;
                    } else {
                      return 1000.0;
                    }
                  }(),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xFFE5E7EB),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                        child: Icon(
                          Icons.check_box_outline_blank,
                          color: Color(0xFF39D2C0),
                          size: 32,
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Orders')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }

                          int notConfirmedOrdersCount = 0;

                          // Iterate through documents in the collection
                          snapshot.data!.docs.forEach((document) {
                            // Assuming 'deliverStatus' is a field in your Firestore document
                            String deliverStatus = document['deliverStatus'];

                            // Check if deliverStatus is 'notconfirmed'
                            if (deliverStatus == 'notconfirmed') {
                              notConfirmedOrdersCount++;
                            }
                          });

                          return Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'คำสั่งซื้อที่ยังไม่ยืนยัน',
                                  style: TextStyle(
                                    color: Color(0xFF606A85),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 4, 0),
                                      child: Text(
                                        '$notConfirmedOrdersCount รายการ',
                                        style: TextStyle(
                                          color: Color(0xFF15161E),
                                          fontSize: 40,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 120,
                constraints: BoxConstraints(
                  maxWidth: () {
                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                      return 700.0;
                    } else if (MediaQuery.sizeOf(context).width <
                        kBreakpointMedium) {
                      return 900.0;
                    } else if (MediaQuery.sizeOf(context).width <
                        kBreakpointLarge) {
                      return 450.0;
                    } else {
                      return 1000.0;
                    }
                  }(),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xFFE5E7EB),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                        child: Icon(
                          Icons.check_box_outlined,
                          color: Color(0xFF39D2C0),
                          size: 32,
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Orders')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }

                          int onConfirmedOrdersCount = 0;

                          // Iterate through documents in the collection
                          snapshot.data!.docs.forEach((document) {
                            // Assuming 'deliverStatus' is a field in your Firestore document
                            String deliverStatus = document['deliverStatus'];

                            // Check if deliverStatus is 'notconfirmed'
                            if (deliverStatus == 'onconfirmed') {
                              onConfirmedOrdersCount++;
                            }
                          });

                          return Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'คำสั่งซื้อที่ยืนยันเเล้ว',
                                  style: TextStyle(
                                    color: Color(0xFF606A85),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 4, 0),
                                      child: Text(
                                        '$onConfirmedOrdersCount รายการ',
                                        style: TextStyle(
                                          color: Color(0xFF15161E),
                                          fontSize: 40,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 120,
                constraints: BoxConstraints(
                  maxWidth: () {
                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                      return 700.0;
                    } else if (MediaQuery.sizeOf(context).width <
                        kBreakpointMedium) {
                      return 900.0;
                    } else if (MediaQuery.sizeOf(context).width <
                        kBreakpointLarge) {
                      return 450.0;
                    } else {
                      return 1000.0;
                    }
                  }(),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xFFE5E7EB),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                        child: Icon(
                          Icons.all_inbox,
                          color: Color(0xFF39D2C0),
                          size: 32,
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Orders')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }

                          int preparetransportOrdersCount = 0;

                          // Iterate through documents in the collection
                          snapshot.data!.docs.forEach((document) {
                            // Assuming 'deliverStatus' is a field in your Firestore document
                            String deliverStatus = document['deliverStatus'];

                            // Check if deliverStatus is 'notconfirmed'
                            if (deliverStatus == 'preparetransport') {
                              preparetransportOrdersCount++;
                            }
                          });

                          return Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'คำสั่งซื้อเตรียมการจัดส่ง',
                                  style: TextStyle(
                                    color: Color(0xFF606A85),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 4, 0),
                                      child: Text(
                                        '$preparetransportOrdersCount รายการ',
                                        style: TextStyle(
                                          color: Color(0xFF15161E),
                                          fontSize: 40,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 120,
                constraints: BoxConstraints(
                  maxWidth: () {
                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                      return 700.0;
                    } else if (MediaQuery.sizeOf(context).width <
                        kBreakpointMedium) {
                      return 900.0;
                    } else if (MediaQuery.sizeOf(context).width <
                        kBreakpointLarge) {
                      return 450.0;
                    } else {
                      return 1000.0;
                    }
                  }(),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xFFE5E7EB),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                        child: Icon(
                          Icons.local_shipping,
                          color: Color(0xFF39D2C0),
                          size: 32,
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Orders')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }

                          int transportOrdersCount = 0;

                          // Iterate through documents in the collection
                          snapshot.data!.docs.forEach((document) {
                            // Assuming 'deliverStatus' is a field in your Firestore document
                            String deliverStatus = document['deliverStatus'];

                            // Check if deliverStatus is 'notconfirmed'
                            if (deliverStatus == 'transport') {
                              transportOrdersCount++;
                            }
                          });

                          return Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'คำสั่งซื้อที่จัดส่งเเล้ว',
                                  style: TextStyle(
                                    color: Color(0xFF606A85),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 4, 0),
                                      child: Text(
                                        '$transportOrdersCount รายการ',
                                        style: TextStyle(
                                          color: Color(0xFF15161E),
                                          fontSize: 40,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ].divide(SizedBox(height: 16)),
          ),
        ),
        if (responsiveVisibility(
          context: context,
          phone: false,
          tablet: false,
          tabletLandscape: false,
        ))
          Expanded(
            flex: 12,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxWidth: 1270,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xFFE5E7EB),
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 12, 0),
                                  child: Text(
                                    'รายการคำสั่งซื้อล่าสุด',
                                    style: TextStyle(
                                      color: Color(0xFF15161E),
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 12, 0),
                                  child: Text(
                                    'ด้านล่างนี้เป็นรายการคำสั่งซื้อล่าสุดที่ยังไม่ได้จัดส่ง',
                                    style: TextStyle(
                                      color: Color(0xFF606A85),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 160,
                                  child: Text(
                                    'รหัสคำสั่งซื้อ',
                                    style: TextStyle(
                                      color: Color(0xFF606A85),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 140,
                                  child: Text(
                                    'ชื่อลูกค้า',
                                    style: TextStyle(
                                      color: Color(0xFF606A85),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 190,
                                  child: Text(
                                    'ราคารวมสินค้า',
                                    style: TextStyle(
                                      color: Color(0xFF606A85),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  child: Text(
                                    'สถานะ',
                                    style: TextStyle(
                                      color: Color(0xFF606A85),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  child: Text(
                                    'จัดการ',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: Color(0xFF606A85),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Orders')
                            .where('deliverStatus', isEqualTo: 'notconfirmed')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          // Access the documents that match the 'deliverStatus' filter
                          List<DocumentSnapshot> notConfirmedOrders =
                              snapshot.data!.docs;

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data?.docs.length ?? 0,
                            itemBuilder: (context, index) {
                              var order = snapshot.data?.docs[index].data()
                                  as Map<String, dynamic>;
                              return Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                                child: Container(
                                  width: double.infinity,
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
                                        16, 10, 16, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 140,
                                          child: Text(
                                            '# ${order['orderId'].toString().split('-').first.padLeft(6, '0')}',
                                            style: TextStyle(
                                              color: Color(0xFF15161E),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 170,
                                          child: Text(
                                            order['customerName'],
                                            style: TextStyle(
                                              color: Color(0xFF15161E),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 160,
                                          child: Text(
                                            ' ${order['totalOrderPrice']} บาท',
                                            style: TextStyle(
                                              color: Color(0xFF15161E),
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
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
                                                            : Colors
                                                                .transparent,
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            width: 0,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.more_vert,
                                                color: Color(0xFF606A85),
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                print('IconButton pressed ...');
                                                // Add your IconButton press logic here
                                              },
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ].divide(SizedBox(width: 16)).addToStart(SizedBox(width: 16)),
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
      return Color(0xFFFFA500); // Change to your desired color
    case 'transport':
      return Color(0xFF008000); // Change to your desired color
    case 'delivered':
      return Color(0xFFFF4500); // Change to your desired color
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
      return 'มอบสินค้าให้กับขนส่งแล้ว';
    case 'delivered':
      return 'ส่งสินค้าแล้ว';
    default:
      return '';
  }
}
