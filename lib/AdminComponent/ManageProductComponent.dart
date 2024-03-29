// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:js_interop';

import 'package:webadmincircular/AdminComponent/AddProductComponent.dart';
import 'package:webadmincircular/AdminComponent/AddProductScreen_Page.dart';
import 'package:webadmincircular/AdminScreen/AddProductScreen.dart';

class ManageProductComponentWidget extends StatefulWidget {
  const ManageProductComponentWidget({super.key});

  @override
  State<ManageProductComponentWidget> createState() =>
      _ManageProductComponentWidgetState();
}

class _ManageProductComponentWidgetState
    extends State<ManageProductComponentWidget> {
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
                              'จัดการสินค้า',
                              style: TextStyle(
                                color: Color(0xFF14181B),
                                fontSize: 26,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 4, 12, 0),
                            child: Text(
                              'ด้านล่างเป็นรายการสินค้าในร้านค้าของคุณ',
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
                    FFButtonWidget(
                      onPressed: () async {
                        print('IconButton pressed ...');

                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height:
                                      MediaQuery.of(context).size.height * 0.99,
                                  child: UploadProductPageWidget()),
                            );
                          },
                        );
                      },
                      text: 'เพิ่มสินค้า',
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
                      ),
                      options: FFButtonOptions(
                        height: 40,
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: Color(0xFF14181B),
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Readex Pro',
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
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: Container(
                              width: 50,
                              height: 20,
                              decoration: BoxDecoration(),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'ชื่อสินค้า',
                              style: TextStyle(
                                color: Color(0xFF14181B),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'หมวดหมู่',
                              style: TextStyle(
                                color: Color(0xFF14181B),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'จำนวนในสต็อก',
                              style: TextStyle(
                                color: Color(0xFF14181B),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 20,
                            decoration: BoxDecoration(),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'ยอดขาย',
                              style: TextStyle(
                                color: Color(0xFF14181B),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                'จัดการสินค้า',
                                style: TextStyle(
                                  color: Color(0xFF14181B),
                                  fontSize: 16,
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
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Products')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;

                        List<String> quantityList = data['quantity'] ?? [];
                        String totalQuantity = quantityList.join(', ');
                        print(data['imgProduct'][0]);

                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 8, 12, 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                    Text(
                                      data['productName'],
                                      style: TextStyle(
                                        color: Color(0xFF14181B),
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 20,
                                decoration: BoxDecoration(),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  data['category'],
                                  style: TextStyle(
                                    color: Color(0xFF14181B),
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                width: 80,
                                height: 20,
                                decoration: BoxDecoration(),
                              ),
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        18, 0, 0, 0),
                                    child: Text(
                                      '$totalQuantity ชิ้น',
                                      style: TextStyle(
                                        color: Color(0xFF14181B),
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      3, 0, 0, 0),
                                  child: Text(
                                    '${data['soldCount']} ชิ้น',
                                    style: TextStyle(
                                      color: Color(0xFF14181B),
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 30,
                                height: 20,
                                decoration: BoxDecoration(),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          25, 0, 5, 0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Show edit dialog
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              // Controllers for form fields
                                              TextEditingController
                                                  categoryController =
                                                  TextEditingController(
                                                      text: data['category']);
                                              TextEditingController
                                                  descriptionController =
                                                  TextEditingController(
                                                      text:
                                                          data['description']);
                                              TextEditingController
                                                  priceController =
                                                  TextEditingController(
                                                      text: data['price']
                                                          .toString());
                                              TextEditingController
                                                  productIdController =
                                                  TextEditingController(
                                                      text: data['productId']);
                                              TextEditingController
                                                  productNameController =
                                                  TextEditingController(
                                                      text:
                                                          data['productName']);

                                              // Map to store controllers for sizes
                                              Map<String, TextEditingController>
                                                  sizesControllers = {};
                                              for (var sizeKey
                                                  in data['sizes'].keys) {
                                                sizesControllers[sizeKey] =
                                                    TextEditingController(
                                                        text: data['sizes']
                                                                    [sizeKey]
                                                                ['quantity']
                                                            .toString());
                                              }

                                              return AlertDialog(
                                                title: Text(
                                                  'Edit Product',
                                                  style: TextStyle(
                                                      fontFamily: 'Kanit-Bold',
                                                      fontSize: 18),
                                                ),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextField(
                                                          controller:
                                                              productNameController,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      'Product Name'),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Kanit-Bold',
                                                              fontSize: 18)),
                                                      TextField(
                                                          controller:
                                                              categoryController,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      'Category'),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Kanit-Bold',
                                                              fontSize: 18)),
                                                      TextField(
                                                        controller:
                                                            descriptionController,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Description',
                                                        ),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Kanit-Bold',
                                                            fontSize: 18),
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        maxLines:
                                                            null, // Set to null for multiline input
                                                        minLines:
                                                            3, // Minimum number of lines to display
                                                      ),

                                                      TextField(
                                                        controller:
                                                            priceController,
                                                        decoration:
                                                            InputDecoration(
                                                                labelText:
                                                                    'Price'),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Kanit-Bold',
                                                            fontSize: 18),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                      ),

                                                      // Add form fields for other data...

                                                      // Form fields for sizes
                                                      for (var sizeKey
                                                          in sizesControllers
                                                              .keys)
                                                        TextField(
                                                          controller:
                                                              sizesControllers[
                                                                  sizeKey],
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      'Quantity for Size $sizeKey'),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Kanit-Bold',
                                                              fontSize: 18),
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      // User pressed Close
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Close'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      // User pressed Save
                                                      // Perform the save operation with updated data
                                                      // For example, update Firestore document

                                                      // Extract sizes data from the form
                                                      Map<String, dynamic>
                                                          sizesData = {};
                                                      for (var sizeKey
                                                          in sizesControllers
                                                              .keys) {
                                                        int quantity = int.parse(
                                                            sizesControllers[
                                                                    sizeKey]!
                                                                .text);
                                                        sizesData[sizeKey] = {
                                                          'hasQuantity': true,
                                                          'quantity': quantity
                                                        };
                                                      }

                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'Products')
                                                          .doc(document.id)
                                                          .update({
                                                        'category':
                                                            categoryController
                                                                .text,
                                                        'description':
                                                            descriptionController
                                                                .text,
                                                        'price': double.parse(
                                                            priceController
                                                                .text),
                                                        'productName':
                                                            productNameController
                                                                .text,
                                                        'sizes':
                                                            sizesData, // Update sizes data
                                                        // Update other fields...
                                                      });

                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    },
                                                    child: Text('Save'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 28,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                            ),
                                          ),
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 0, 12, 0),
                                            child: Text(
                                              'แก้ไข',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Show delete confirmation dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('ยืนยันการลบสินค้า'),
                                              content: Text(
                                                  'คุณต้องการจะลบสินค้าชิ้นนี้ใช่ไหม'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    // User pressed Cancel
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('ยกเลิก'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    // User pressed Delete
                                                    // Delete product from Firestore
                                                    FirebaseFirestore.instance
                                                        .collection('Products')
                                                        .doc(document
                                                            .id) // Assuming your document has an 'id' field
                                                        .delete();

                                                    // Close the dialog
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('ลบสินค้า'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            25, 0, 5, 0),
                                        child: Container(
                                          height: 28,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                            ),
                                          ),
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 0, 12, 0),
                                            child: Text(
                                              'ลบ',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
    );
  }
}
