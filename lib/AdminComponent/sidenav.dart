// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webadmincircular/AdminComponent/Dashboard.dart';
import 'package:webadmincircular/AdminScreen/LoginScreen.dart';
import 'package:webadmincircular/AdminScreen/MainScreen.dart';
import 'package:webadmincircular/AdminScreen/ManageCategoryScreen.dart';
import 'package:webadmincircular/AdminScreen/ManageOrderScreem.dart';
import 'package:webadmincircular/AdminScreen/ManageProductScreen.dart';
import 'package:webadmincircular/AdminScreen/ReportScreen.dart';
import 'package:webadmincircular/DeliveryScreen/DeliveryMainScreen.dart';

class SideNavWidget extends StatefulWidget {
  const SideNavWidget({super.key});

  @override
  State<SideNavWidget> createState() => _SideNavWidgetState();
}

class _SideNavWidgetState extends State<SideNavWidget> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: responsiveVisibility(
        context: context,
        phone: false,
        tablet: false,
      ),
      child: Container(
        width: 270,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF1F4F8),
          borderRadius: BorderRadius.circular(0),
          border: Border.all(
            color: Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.blur_circular,
                      color: Color(0xFF6F61EF),
                      size: 32,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: Text(
                        'CircularMall Dashboard',
                        style: TextStyle(
                          color: Color(0xFF15161E),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 12,
                thickness: 2,
                color: Color(0xFFE5E7EB),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                      child: Text(
                        'ทางลัด',
                        style: TextStyle(
                          color: Color(0xFF606A85),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the desired page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreenWidget()),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: double.infinity,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F4F8),
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 6, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.space_dashboard,
                                  color: Color(0xFF15161E),
                                  size: 24,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                  child: Text(
                                    'ภาพรวมร้านค้า',
                                    style: TextStyle(
                                      color: Color(0xFF15161E),
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
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the desired page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManageCategoryWidget()),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: double.infinity,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F4F8),
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 6, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.category,
                                  color: Color(0xFF15161E),
                                  size: 24,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Text(
                                    'จัดการหมวดหมู่',
                                    style: TextStyle(
                                      color: Color(0xFF15161E),
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
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the desired page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManageProductScreenWidget()),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: double.infinity,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F4F8),
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 6, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.work,
                                  color: Color(0xFF15161E),
                                  size: 24,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                  child: Text(
                                    'จัดการสินค้า',
                                    style: TextStyle(
                                      color: Color(0xFF15161E),
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
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the desired page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManageOrderScreenWidget()),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: double.infinity,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F4F8),
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 6, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.delivery_dining,
                                  color: Color(0xFF15161E),
                                  size: 24,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                  child: Text(
                                    'จัดการคำสั่งซื้อ',
                                    style: TextStyle(
                                      color: Color(0xFF15161E),
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
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the desired page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeliveryMainScreenWidget()),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: double.infinity,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F4F8),
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 6, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.local_shipping,
                                  color: Color(0xFF15161E),
                                  size: 24,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                  child: Text(
                                    'จัดการการขนส่ง',
                                    style: TextStyle(
                                      color: Color(0xFF15161E),
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
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the desired page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReportScreenWidget()),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: double.infinity,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F4F8),
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 6, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.report,
                                  color: Color(0xFF15161E),
                                  size: 24,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                  child: Text(
                                    'รายงาน',
                                    style: TextStyle(
                                      color: Color(0xFF15161E),
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
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Text(
                        'ตั้งค่า',
                        style: TextStyle(
                          color: Color(0xFF606A85),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    
                    
                    GestureDetector(
                      onTap: () {
                        // Navigate to the desired page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreenWidget()),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          width: double.infinity,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F4F8),
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 6, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.logout
                                  
                                ),
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                  child: Text(
                                    'ออกจากระบบ',
                                    style: TextStyle(
                                      color: Color(0xFF15161E),
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
                    ),
                    
                  ].divide(SizedBox(height: 12)),
                ),
              ),
              Divider(
                height: 12,
                thickness: 2,
                color: Color(0xFFE5E7EB),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.menu_open_rounded,
                      color: Color(0xFF606A85),
                      size: 24,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
