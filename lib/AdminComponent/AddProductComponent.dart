// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../Model/VendorScreen_Models/add_product_component_model.dart';
export '../Model/VendorScreen_Models/add_product_component_model.dart';

class AddProductComponentWidget extends StatefulWidget {
  const AddProductComponentWidget({super.key});

  @override
  State<AddProductComponentWidget> createState() =>
      _AddProductComponentWidgetState();
}

class _AddProductComponentWidgetState extends State<AddProductComponentWidget> {
  late AddProductComponentModel _model;
  List<Map<String, dynamic>> categories = [];
  List<File> selectedImages = [];
  List<String> selectedSizes = [];

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddProductComponentModel());

    _model.productNameController ??= TextEditingController();
    _model.productNameFocusNode ??= FocusNode();

    _model.projectURLController ??= TextEditingController();
    _model.projectURLFocusNode ??= FocusNode();

    _model.descriptionController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();

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

  Map<String, Map<String, dynamic>> selectedSizesMap = {};

// Function to show a dialog for entering quantity
  Future<void> _showQuantityDialog(BuildContext context, dynamic size) async {
    int? quantity;
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('กรอกจำนวนสินค้าของไซส์ : $size'),
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

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    List<XFile>? images = await _picker.pickMultiImage(
        // source: ImageSource.gallery,
        );

    if (images != null) {
      setState(() {
        selectedImages.addAll(images.map((image) => File(image.path)));
      });
    }
  }

  Future<void> _uploadProduct() async {
  try {
    print('Platform: ${kIsWeb ? 'Web' : Platform.operatingSystem}');

    // Debug prints to check values
    print('ProductName: ${_model.productNameController.text}');
    print('CategoryValue: ${_model.categoryValue}');
    print('ProductPrice: ${_model.productPriceController.text}');
    print('ProductDescription: ${_model.productDescriptionController.text}');
    print('SelectedImages: $selectedImages');

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

    // Rest of the code...
  } catch (e, stackTrace) {
    print('Error: $e');
    print('StackTrace: $stackTrace');
    // Handle the error as needed
  }
}



  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 4,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxWidth: 670,
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
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Color(0xFFE0E3E7),
                    width: 1,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _model.formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 4),
                                            child: Text(
                                              'เพิ่มสินค้าใหม่',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMedium
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF14181B),
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 8),
                                            child: Text(
                                              'เพิ่มรายละเอียดสินค้าได้ที่ฟอร์มด้านล่าง',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    color: Color(0xFF57636C),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      borderWidth: 1,
                                      buttonSize: 60,
                                      icon: Icon(
                                        Icons.close_rounded,
                                        color: Color(0xFF57636C),
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Row(
  mainAxisSize: MainAxisSize.max,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
        child: InkWell(
          onTap: _pickImage,
          child: Container(
            width: 120,
            height: 250,
            decoration: BoxDecoration(
              color: Color(0xFFE0E3E7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              alignment: AlignmentDirectional(0, 0),
              children: [
                if (selectedImages.isNotEmpty)
                  kIsWeb
                      ? Image.network(
                          selectedImages.first.path,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          selectedImages.first,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                if (selectedImages.isEmpty)
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo_outlined,
                        color: Color(0xFF57636C),
                        size: 72,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: Text(
                          'Add Photo',
                          style: FlutterFlowTheme.of(context).titleLarge,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Upload images here...',
                          style: FlutterFlowTheme.of(context).labelMedium,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    ),
  ],
),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                child: TextFormField(
                                  controller: _model.productNameController,
                                  focusNode: _model.productNameFocusNode,
                                  autofocus: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'ชื่อสินค้า',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF57636C),
                                          fontSize: 24,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFE0E3E7),
                                        width: 2,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF4B39EF),
                                        width: 2,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF5963),
                                        width: 2,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF5963),
                                        width: 2,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 24, 0, 24),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF14181B),
                                        fontSize: 24,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  validator: _model
                                      .productNameControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                              Container(
                                width: 365,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('หมวดหมู่สินค้าหลัก',
                                        style: TextStyle(
                                            fontFamily: 'Kanit-Bold',
                                            fontSize: 18)),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
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
                                            items: _model.categories
                                                .map((category) {
                                              return DropdownMenuItem<String>(
                                                value: category['categoryName']
                                                    .toString(),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
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
                                            fontFamily: 'Kanit-Bold',
                                            fontSize: 18)),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                        onChanged: (List<dynamic>?
                                            selectedSizes) async {
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
                                        controller: _model
                                                .sizeValueController ??=
                                            FormFieldController<List<String>>(
                                                []),
                                      ),
                                      // Other widgets if needed
                                    ],
                                  )
                                ].divide(SizedBox(width: 35)),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF6F61EF),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                      EdgeInsetsDirectional.fromSTEB(
                                          16, 24, 16, 12),
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
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 4, 0),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          _uploadProduct();
                                          print('Button pressed ...');
                                        },
                                        text: 'เพิ่มสินค้า',
                                        options: FFButtonOptions(
                                          height: 50,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  32, 0, 32, 0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          color: Color(0xFF4B39EF),
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                          elevation: 2,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
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
                    ],
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
