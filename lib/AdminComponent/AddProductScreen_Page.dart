// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../Model/VendorScreen_Models/upload_product_page_model.dart';
export '../Model/VendorScreen_Models/upload_product_page_model.dart';



class UploadProductPageWidget extends StatefulWidget {
  const UploadProductPageWidget({super.key});

  @override
  State<UploadProductPageWidget> createState() =>
      _UploadProductPageWidgetState();
}

class _UploadProductPageWidgetState extends State<UploadProductPageWidget> {
  late UploadProductPageModel _model;
  List<Map<String, dynamic>> categories = [];
  List<File> selectedImages = [];
  List<String> selectedSizes = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UploadProductPageModel());

    _model.productNameController ??= TextEditingController();
    _model.productNameFocusNode ??= FocusNode();

    _model.productPriceController ??= TextEditingController();
    _model.productPriceFocusNode ??= FocusNode();

    // _model.productQtyController ??= TextEditingController();
    // _model.productQtyFocusNode ??= FocusNode();

    _model.productDescriptionController ??= TextEditingController();
    _model.productDescriptionFocusNode ??= FocusNode();

    fetchCategories().then((categoryList) {
      setState(() {
        _model.categories = categoryList;
      });
    });
  }

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Categories').get();

    return querySnapshot.docs
        .map((doc) => Map<String, dynamic>.from(doc.data() as Map))
        .toList();
  }

  Future<void> _pickImages() async {
    List<XFile>? images = await ImagePicker().pickMultiImage();
    if (images != null && images.isNotEmpty) {
      setState(() {
        selectedImages.addAll(images.map((image) => File(image.path)));
      });
    }
  }

  Map<String, Map<String, dynamic>> selectedSizesMap = {};

// Function to show a dialog for entering quantity
  Future<void> _showQuantityDialog(BuildContext context, dynamic size) async {
    int? quantity;
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Quantity for $size'),
          content: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              quantity = int.tryParse(value);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    if (quantity != null) {
      // Update the selected size and accumulate quantities
      setState(() {
        if (selectedSizesMap.containsKey(size.toString())) {
          // If the size is already in the map, accumulate the quantity
          selectedSizesMap[size.toString()]!['quantity'] += quantity!;
        } else {
          // If the size is not in the map, add it with the quantity
          selectedSizesMap[size.toString()] = {
            'hasQuantity': true,
            'quantity': quantity,
          };
        }
      });
    }
  }

  Future<void> _uploadProduct() async {
    // Validate required fields
    if (_model.productNameController.text.isEmpty ||
        _model.categoryValue == null ||
        _model.productPriceController.text.isEmpty ||
        _model.productDescriptionController.text.isEmpty ||
        selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all required fields and add images.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Add product information to Firestore
    final String productId = Uuid().v4();

    // Upload images to Firebase Storage and collect image paths
    List<String> imagePaths = [];
    final storage = FirebaseStorage.instance;
    for (int i = 0; i < selectedImages.length; i++) {
      final ref = storage.ref('ImgProducts/$productId/image$i.jpg');
      await ref.putFile(selectedImages[i]);
      final String imagePath = await ref.getDownloadURL();
      imagePaths.add(imagePath);
    }

    // Save data to Firestore, including image paths
    await FirebaseFirestore.instance.collection('Products').doc(productId).set({
      'productId': productId,
      'productName': _model.productNameController.text,
      'category': _model.categoryValue,
      'price': double.parse(_model.productPriceController.text),
      'description': _model.productDescriptionController.text,
      'sizes': selectedSizesMap,
      'imgProduct': imagePaths,
      'soldCount': '',
      'rating': ''
      // Add other fields as needed
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product added successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF15161E),
              size: 30,
            ),
            onPressed: () {
              // Navigator.of(context).pushNamed('VendorHome_Page');
              // print('IconButton pressed ...');
            },
          ),
          title: Text(
            'เพิ่มรายการสินค้า',
            style: TextStyle(
              color: Color(0xFF15161E),
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'สินค้าใหม่',
                      style: TextStyle(
                        color: Color(0xFF15161E),
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: GestureDetector(
                      onTap: _pickImages,
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: 500,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0xFFE5E7EB),
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.add_a_photo_rounded,
                                color: Color(0xFF6F61EF),
                                size: 32,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                child: Text(
                                  'เพิ่มรูปภาพสินค้า',
                                  textAlign: TextAlign.center,
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
                  Container(
                    height: 120, // Adjust the height as needed
                    margin: EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedImages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  width: 100, // Adjust the width as needed
                                  height: 100, // Adjust the height as needed
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: kIsWeb
                                        ? Image.network(
                                            selectedImages[index].path,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.file(
                                            selectedImages[index],
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Icon(
                                  Icons.cancel_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextFormField(
                          controller: _model.productNameController,
                          focusNode: _model.productNameFocusNode,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'ชื่อสินค้า',
                            labelStyle: TextStyle(
                              color: Color(0xFF606A85),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            hintStyle: TextStyle(
                              color: Color(0xFF606A85),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFE5E7EB),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF6F61EF),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFF5963),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFF5963),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                          ),
                          style: TextStyle(
                            color: Color(0xFF15161E),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          cursorColor: Color(0xFF6F61EF),
                          validator: _model.productNameControllerValidator
                              .asValidator(context),
                        ),
                        Container(
                          width: 365,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('หมวดหมู่สินค้าหลัก',
                                  style: TextStyle(
                                      fontFamily: 'Kanit-Bold', fontSize: 18)),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1,
                                  ),
                                ),
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(12),
                                    border: InputBorder.none,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _model.categoryValue,
                                      items: _model.categories.map((category) {
                                        return DropdownMenuItem<String>(
                                          value: category['categoryName']
                                              .toString(),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              category['categoryName']
                                                  .toString(),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          _model.categoryValue = val;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                  'เลือกหมวดหมู่: ${_model.categoryValue ?? 'ยังไม่ได้เลือก'}',
                                  style: TextStyle(
                                      fontFamily: 'Kanit-Bold', fontSize: 18)),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'ไซส์',
                              style: TextStyle(
                                  fontFamily: 'Kanit-Bold', fontSize: 18),
                            ),
                            Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                FlutterFlowChoiceChips(
                                  options: [
                                    ChipData('S'),
                                    ChipData('M'),
                                    ChipData('L'),
                                    ChipData('XL'),
                                    ChipData('XXL'),
                                  ],
                                  onChanged:
                                      (List<dynamic>? selectedSizes) async {
                                    if (selectedSizes != null &&
                                        selectedSizes.isNotEmpty) {
                                      // Show a single dialog for the last selected size
                                      await _showQuantityDialog(
                                          context, selectedSizes.last);
                                    }
                                  },
                                  selectedChipStyle: ChipStyle(
                                      // Selected chip style properties
                                      ),
                                  unselectedChipStyle: ChipStyle(
                                      // Unselected chip style properties
                                      ),
                                  chipSpacing: 4,
                                  rowSpacing: 4,
                                  multiselect: true,
                                  alignment: WrapAlignment.start,
                                  controller: _model.sizeValueController ??=
                                      FormFieldController<List<String>>([]),
                                ),
                                // Other widgets if needed
                              ],
                            )
                          ].divide(SizedBox(width: 35)),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 375,
                              child: TextFormField(
                                controller: _model.productPriceController,
                                focusNode: _model.productPriceFocusNode,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'ราคา(หน่วย:บาท)',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF606A85),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Color(0xFF606A85),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFE5E7EB),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF6F61EF),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16, 12, 16, 12),
                                ),
                                style: TextStyle(
                                  color: Color(0xFF15161E),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                cursorColor: Color(0xFF6F61EF),
                                validator: _model
                                    .productPriceControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ].divide(SizedBox(width: 60)),
                        ),
                        TextFormField(
                          controller: _model.productDescriptionController,
                          focusNode: _model.productDescriptionFocusNode,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Color(0xFF606A85),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: 'รายละเอียดสินค้า',
                            hintStyle: TextStyle(
                              color: Color(0xFF606A85),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFE5E7EB),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF6F61EF),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFF5963),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFF5963),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(16, 24, 16, 12),
                          ),
                          style: TextStyle(
                            color: Color(0xFF15161E),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 16,
                          minLines: 6,
                          cursorColor: Color(0xFF6F61EF),
                          validator: _model
                              .productDescriptionControllerValidator
                              .asValidator(context),
                        ),
                      ].divide(SizedBox(height: 12)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 12),
                    child: FFButtonWidget(
                      onPressed: () {
                        _uploadProduct();
                        print('AddProduct pressed ...');
                      },
                      text: 'เพิ่มสินค้า',
                      icon: Icon(
                        Icons.add,
                        size: 15,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 48,
                        padding: EdgeInsets.all(0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: Color(0xFF6F61EF),
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        elevation: 4,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
