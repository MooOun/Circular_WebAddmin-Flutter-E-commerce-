// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StatWidget extends StatefulWidget {
  const StatWidget({super.key});

  @override
  State<StatWidget> createState() => _StatWidgetState();
}

class _StatWidgetState extends State<StatWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(-1, 0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                child: Container(
                  height: 120,
                  constraints: BoxConstraints(
                    maxWidth: 270,
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
                        Icon(
                          Icons.attach_money,
                          color: Color(0xFF39D2C0),
                          size: 32,
                        ),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: Text(
                                  'รายรับทั้งหมด',
                                  style: TextStyle(
                                    color: Color(0xFF606A85),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
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
                                  int totalOrderPrice = 0;

                                  // Iterate through documents in the collection
                                  snapshot.data!.docs.forEach((document) {
                                    // Assuming totalOrderPrice is a field in your Firestore document
                                    if (document['totalOrderPrice'] != null) {
                                      totalOrderPrice +=
                                          (document['totalOrderPrice']
                                              as int); // Explicitly cast to int
                                    }
                                  });

                                  return Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 4, 4, 0),
                                          child: Text(
                                            '$totalOrderPrice บาท',
                                            style: TextStyle(
                                              color: Color(0xFF15161E),
                                              fontSize: 32,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                child: Container(
                  height: 120,
                  constraints: BoxConstraints(
                    maxWidth: 270,
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
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Orders')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }

                        int totalOrders = 0;

                        // Iterate through documents in the collection
                        snapshot.data!.docs.forEach((document) {
                          // Assuming orderId is a field in your Firestore document
                          if (document['orderId'] != null) {
                            totalOrders++;
                          }
                        });

                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                              child: Icon(
                                Icons.trending_up_rounded,
                                color: Color(0xFF39D2C0),
                                size: 32,
                              ),
                            ),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'รายการคำสั่งซื้อทั้งหมด',
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
                                          '$totalOrders รายการ',
                                          style: TextStyle(
                                            color: Color(0xFF15161E),
                                            fontSize: 32,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                child: Container(
                  height: 120,
                  constraints: BoxConstraints(
                    maxWidth: 270,
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
                            Icons.trending_up_rounded,
                            color: Color(0xFF39D2C0),
                            size: 32,
                          ),
                        ),
                        Flexible(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Orders')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }

                              int prepareTransportCount = 0;
                              int onConfirmedCount = 0;
                              int notConfirmedCount = 0;

                              // Iterate through documents in the collection
                              snapshot.data!.docs.forEach((document) {
                                // Check the value of deliverStatus and update the counts
                                String deliverStatus =
                                    document['deliverStatus'];

                                if (deliverStatus == 'preparetransport') {
                                  prepareTransportCount++;
                                } else if (deliverStatus == 'onconfirmed') {
                                  onConfirmedCount++;
                                } else if (deliverStatus == 'notconfirmed') {
                                  notConfirmedCount++;
                                }
                              });

                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'รายการคำสั่งซื้อที่ยังไม่จัดส่ง',
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
                                          '${prepareTransportCount + onConfirmedCount + notConfirmedCount} รายการ',
                                          style: TextStyle(
                                            color: Color(0xFF15161E),
                                            fontSize: 32,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                child: Container(
                  height: 120,
                  constraints: BoxConstraints(
                    maxWidth: 270,
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
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Customers')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }

                        // Use a Set to store unique uid values
                        Set<String> uniqueUids = Set<String>();

                        // Iterate through documents in the collection
                        snapshot.data!.docs.forEach((document) {
                          // Assuming uid is a field in your Firestore document
                          if (document['uid'] != null) {
                            uniqueUids.add(document['uid']);
                          }
                        });

                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                              child: Icon(
                                Icons.trending_up_rounded,
                                color: Color(0xFF39D2C0),
                                size: 32,
                              ),
                            ),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'จำนวนผู้ใช้งานทั้งหมด',
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
                                          '${uniqueUids.length} คน',
                                          style: TextStyle(
                                            color: Color(0xFF15161E),
                                            fontSize: 32,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ]
                .divide(SizedBox(width: 16))
                .addToStart(SizedBox(width: 16))
                .addToEnd(SizedBox(width: 16)),
          ),
        ),
      ),
    );
  }
}
