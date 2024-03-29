// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webadmincircular/AdminComponent/sidenav.dart';
import 'package:webadmincircular/AdminComponent/stat.dart';
import 'package:webadmincircular/AdminComponent/topHeader.dart';
import 'package:webadmincircular/AdminComponent/Dashboard.dart';
import 'package:webadmincircular/DeliveryComponent/DeliveryStat.dart';
import 'package:webadmincircular/DeliveryComponent/ManageShipping.dart';
import 'package:webadmincircular/DeliveryComponent/SideNavDelivery.dart';
import 'package:webadmincircular/DeliveryComponent/TopHeader.dart';

class DeliveryMainScreenWidget extends StatefulWidget {
  const DeliveryMainScreenWidget({super.key});

  @override
  State<DeliveryMainScreenWidget> createState() => _DeliveryMainScreenWidgetState();
}

class _DeliveryMainScreenWidgetState extends State<DeliveryMainScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DeliverySideNavWidget(),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional(0, -1),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: 1370,
                  ),
                  decoration: BoxDecoration(),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        DeliveryTopHeaderWidget(),
                        Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: DeliveryStatWidget(),
                        ),
                        ManageShipping(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
