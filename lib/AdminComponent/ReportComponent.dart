// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webadmincircular/AdminScreen/ReportScreen/BestSellingProductsScreen.dart';
import 'package:webadmincircular/AdminScreen/ReportScreen/ProductInformationScreen.dart';
import 'package:webadmincircular/AdminScreen/ReportScreen/PurchaseHistoryScreen.dart';
import 'package:webadmincircular/AdminScreen/ReportScreen/SalesReportScreen.dart';

class ReportComponentWidget extends StatefulWidget {
  const ReportComponentWidget({super.key});

  @override
  State<ReportComponentWidget> createState() => _ReportComponentWidgetState();
}

class _ReportComponentWidgetState extends State<ReportComponentWidget> {
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
              GestureDetector(
                    onTap: () {
                      Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SalesReportPage()),
                );
                    },
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                  child: Container(
                    height: 120,
                    constraints: BoxConstraints(
                     maxWidth: 300,
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
                                    'รายงานข้อมูลการขาย',
                                    style: TextStyle(
                                      color: Color(0xFF606A85),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                    onTap: () {
                      Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SalesReportScreen()),
                );
                    },
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                  child: Container(
                    height: 120,
                    constraints: BoxConstraints(
                     maxWidth: 300,
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
                                    'รายงานประวัติการซื้อสินค้า',
                                    style: TextStyle(
                                      color: Color(0xFF606A85),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                    onTap: () {
                      Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductInformationScreen()),
                );
                    },
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                  child: Container(
                    height: 120,
                    constraints: BoxConstraints(
                     maxWidth: 300,
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
                                    'รายงานข้อมูลสินค้า',
                                    style: TextStyle(
                                      color: Color(0xFF606A85),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                    onTap: () {
                      Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BestSellingProductsScreen()),
                );
                    },
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                  child: Container(
                    height: 120,
                    constraints: BoxConstraints(
                     maxWidth: 300,
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
                                    'รายงานข้อมูลสินค้าขายดี',
                                    style: TextStyle(
                                      color: Color(0xFF606A85),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
