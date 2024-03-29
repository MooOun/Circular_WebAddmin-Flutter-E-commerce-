
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webadmincircular/AdminComponent/ManageProductComponent.dart';
import 'package:webadmincircular/AdminComponent/manageOrder.dart';
import 'package:webadmincircular/AdminComponent/sidenav.dart';
import 'package:webadmincircular/AdminComponent/stat.dart';
import 'package:webadmincircular/AdminComponent/topHeader.dart';

class ManageProductScreenWidget extends StatefulWidget {
  const ManageProductScreenWidget({super.key});

  @override
  State<ManageProductScreenWidget> createState() =>
      _ManageProductScreenWidgetState();
}

class _ManageProductScreenWidgetState extends State<ManageProductScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SideNavWidget(),
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
                        TopHeaderWidget(),
                        Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: StatWidget(),
                        ),
                        ManageProductComponentWidget(),
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
